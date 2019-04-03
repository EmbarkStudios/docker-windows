param (
    [string]$rust_version = $(throw "-rust_version is required."),
    [string]$vs_tag = "2017"
)

$ErrorActionPreference="Stop"

$base_tag = "ltsc2019"
$org = "embarkstudios"

$scoop_tag = "$org/scoop:$base_tag"
$vs_tools_tag = "$org/vs-build-tools:$base_tag-$vs_tag"
$rust_tag = "$org/rust:$base_tag-$rust_version"
$total = 6

function progress {
    param(
        [string]$act = "",
        [string]$status = "",
        [int]$current = -1
    )

    Write-Progress -Activity $act -Status $status -PercentComplete ($current/$total*100)
}

progress -act "Building" -status $scoop_tag -current 1
docker build -t $scoop_tag scoop

progress -act "Building" -status $vs_tools_tag -current 2
docker build -t $vs_tools_tag vs-build-tools

progress -act "Building" -status $rust_tag -current 3
docker build -t $rust_tag --build-arg "rust_version=$rust_version" rust

progress -act "Pushing" -status $scoop_tag -current 4
docker push $scoop_tag

progress -act "Pushing" -status $vs_tools_tag -current 5
docker push $vs_tools_tag

progress -act "Pushing" -status $rust_tag -current 6
docker push $rust_tag
