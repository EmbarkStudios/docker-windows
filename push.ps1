param (
    [string]$rust_version = $(throw "-rust_version is required."),
    [string]$token = $(throw "-token is required."),
    [string]$org = "embarkstudios",
    [string]$vs_tag = "2017"
)

# Stop and exit if any command/cmdlet fails
$ErrorActionPreference="Stop"

$base_tag = "1909"

$tags = @(
  "$org/scoop:$base_tag",
  "$org/vs-build-tools:$base_tag-$vs_tag",
  "$org/rust:$base_tag-$vs_tag-$rust_version",
  "$org/rust-extras:$base_tag-$vs_tag-$rust_version",
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

        $name = $dirs[$i]
        $tag = $tags[$i]

        # HAAAAAAX!
        if (($name -eq "rust") -or ($name -eq "rust-extras")) {
            docker build -t $tag --build-arg "rust_version=$rust_version" $name
        } elseif ($name -eq "buildkite") {
            docker build -t $tag --build-arg "rust_version=$rust_version" --build-arg "buildkiteAgentToken=$token" $name
        } else {
            docker build -t $tag $name
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
