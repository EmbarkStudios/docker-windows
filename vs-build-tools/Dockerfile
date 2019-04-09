FROM embarkstudios/scoop:ltsc2019

# Download the installer
ADD https://aka.ms/vs/15/release/vs_buildtools.exe c:/temp/vs_buildtools.exe

COPY install-build-tools.ps1 c:/temp/install-build-tools.ps1

# Install...far too much
RUN c:/temp/install-build-tools.ps1

# Cleanup the temp directory
RUN Remove-Item -Recurse -Force c:/temp
