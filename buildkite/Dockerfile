FROM embarkstudios/rust-extras:ltsc2019-2017-1.34.0

COPY buildkite-service.ps1 c:/temp/buildkite-service.ps1

# Install nssm "the Non-Sucking Service Manager" to manage the buildkite agent as a service
RUN scoop install nssm

# Due to how the buildkite installer works, we need to have the token at a minimum configured
# before running it, however this is problematic since it would mean exposing build tokens
# into publicly available images, so instead make them ONBUILD so that images that depend on
# this one can pass it in themselves
ONBUILD ARG buildkiteAgentToken
ONBUILD ARG buildkiteAgentTags
ONBUILD RUN c:/temp/buildkite-service.ps1
