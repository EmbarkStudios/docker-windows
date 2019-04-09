FROM embarkstudios/scoop:ltsc2019

# Download the installer
ADD https://aka.ms/vs/15/release/vs_buildtools.exe c:/temp/vs_buildtools.exe

# Install 
RUN c:/temp/vs_buildtools.exe --quiet --wait --norestart --nocache \
    --installPath C:/buildtools \
    --add "Microsoft.VisualStudio.Workload.VCTools;includeRecommended" \
    --add Microsoft.VisualStudio.Workload.MSBuildTools

# Cleanup the temp directory
RUN Remove-Item -Recurse -Force c:/temp
