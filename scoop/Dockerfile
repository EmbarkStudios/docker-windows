FROM mcr.microsoft.com/powershell:nanoserver-1809

# Nanoserver doesn't include robocopy.exe, so copy it into to image and see what goes wrong!
COPY Robocopy.exe c:/windows/system32
COPY install-scoop.ps1 install-scoop.ps1

SHELL ["pwsh", "-c", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install scoop
RUN ./install-scoop.ps1

ENV PATH="$PATH;c:/users/containeruser/scoop/shims"

RUN Get-ChildItem Env:

# Install git, scoop actually requires git to eg add buckets, and it will
# most likely be used in child containers anyways
RUN scoop install git-with-openssh
# Attempt to see what went wrong
RUN cat ~/scoop/apps/7zip/19.00/msi.log

CMD ["scoop"]
