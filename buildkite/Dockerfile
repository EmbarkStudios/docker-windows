ARG rust_version=stable
FROM embarkstudios/extra:1909-2017-${rust_version}

COPY buildkite-service.ps1 c:/temp/buildkite-service.ps1

# Due to how the buildkite installer works, we need to have the token at a minimum configured
# before running it, however this is problematic since it would mean exposing build tokens
# into publicly available images, so instead make them ONBUILD so that images that depend on
# this one can pass it in themselves
ONBUILD ARG buildkiteAgentToken
ONBUILD ARG buildkiteAgentTags
ONBUILD RUN c:/temp/buildkite-service.ps1
