FROM embarkstudios/rust-extras:ltsc2019-2017-1.33.0

COPY buildkite-service.ps1 ./temp/buildkite-service.ps1

# Install nssm "the Non-Sucking Service Manager" to manage the buildkite agent as a service
RUN scoop install nssm

# These environment variables should be overriden when running the container
ENV BUILDKITE_AGENT_TOKEN="" BUILDKITE_AGENT_TAGS=""

# Install the agent as a service
RUN ./temp/buildkite-service.ps1

# Cleanup all our temporary files
RUN Remove-Item -Recurse -Force ./temp
