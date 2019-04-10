param (
    [string]$token = $(throw "-token is required."),
    [string]$tags = $(throw "-tags are required."),
    [string]$tag = $(throw "-tag is required."),
)

echo "FROM embarkstudios/buildkite:ltsc2019-2017-1.33.0" | docker build -t $tag --build-arg "buildkiteAgentToken=$token" --build-arg "buildkiteAgentTags=$tags" -