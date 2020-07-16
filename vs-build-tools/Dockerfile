FROM embarkstudios/scoop:ltsc2019

USER "$env:user"

# Download the installer
ADD https://aka.ms/vs/15/release/vs_buildtools.exe  c:/temp/vs_buildtools.exe

# Temporarily force the shell back to cmd due to powershell trying to interpret stuff it shouldn't
SHELL ["cmd", "/S", "/C"]

# Install...far too much, but at least it's better than it used to be
RUN c:/temp/vs_buildtools.exe --quiet --wait --norestart --nocache \
    --installPath C:/buildtools \
    --add Microsoft.VisualStudio.Workload.VCTools;includeRecommended \
    --add Microsoft.VisualStudio.Workload.MSBuildTools

# Restore the shell back to powershell
SHELL ["powershell", "-NoLogo", "-c", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Cleanup the temp directory
RUN Remove-Item -Recurse -Force c:/temp
