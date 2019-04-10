param (
    [string]$rust_version = $(throw "-rust_version is required."),
    [string]$vs_tag = "2017"
)

# Stop and exit if any command/cmdlet fails
$ErrorActionPreference="Stop"

$base_tag = "ltsc2019"
$org = "embarkstudios"

$tags = @(
  "$org/scoop:$base_tag",
  "$org/vs-build-tools:$base_tag-$vs_tag",
  "$org/rust:$base_tag-$vs_tag-$rust_version",
  "$org/rust-extras:$base_tag-$vs_tag-$rust_version"
  "$org/buildkite:$base_tag-$vs_tag-$rust_version"
)

$dirs = @(
    "scoop",
    "vs-build-tools",
    "rust",
    "rust-extras",
    "buildkite"
)

function progress {
    param(
        [string]$act = "",
        [string]$status = "",
        [int]$current = -1
    )

    Write-Progress -Activity $act -Status $status -PercentComplete ($current/($tags.count * 2 + 1)*100)
}

function build {
    for ($i = 0; $i -le ($tags.length - 1); $i += 1) {
        progress -act "Building" -status $tags[$i] -current ($i + 1)

        # HAAAAAAX!
        if ($dirs[$i] -eq "rust") {
            docker build -t $tags[$i] --build-arg "rust_version=$rust_version" $dirs[$i]
        } else {
            docker build -t $tags[$i] $dirs[$i]
        }
    }
}

function push {
    for ($i = 0; $i -le ($tags.length - 1); $i += 1) {
        progress -act "Pushing" -status $tags[$i] -current ($i + $tags.length + 1)
        docker push $tags[$i]
    }
}

build
push
