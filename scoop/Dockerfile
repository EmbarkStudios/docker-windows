FROM mcr.microsoft.com/powershell:nanoserver-1809

# Nanoserver doesn't include robocopy.exe, so copy it into to image and see what goes wrong!
COPY Robocopy.exe c:/windows/system32
COPY install-scoop.ps1 install-scoop.ps1

SHELL ["pwsh", "-c", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install scoop
RUN ./install-scoop.ps1

ENV PATH="$PATH;c:/users/containeruser/scoop/shims"

RUN Get-ChildItem Env:

COPY install-git.ps1 install-git.ps1
RUN ./install-git.ps1

CMD ["scoop"]
