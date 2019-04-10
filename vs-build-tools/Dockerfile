FROM embarkstudios/scoop:ltsc2019

# Download the installer
ADD https://aka.ms/vs/15/release/vs_buildtools.exe c:/temp/vs_buildtools.exe

COPY install-build-tools.ps1 c:/temp/install-build-tools.ps1

# Install...far too much, but at least it's better than it used to be
RUN cmd /S /C c:/temp/vs_buildtools.exe --quiet --wait --norestart --nocache \
    --installPath C:/buildtools \
    --add Microsoft.VisualStudio.Workload.VCTools;includeRecommended \
    --add Microsoft.VisualStudio.Workload.MSBuildTools

# Cleanup the temp directory
RUN Remove-Item -Recurse -Force c:/temp
