FROM embarkstudios/rust-extras:ltsc2019-2017-1.33.0

COPY buildkite-service.ps1 c:/temp/buildkite-service.ps1

# Install nssm "the Non-Sucking Service Manager" to manage the buildkite agent as a service
RUN scoop install nssm

# Install the agent as a service, but only when 
ONBUILD RUN c:/temp/buildkite-service.ps1
