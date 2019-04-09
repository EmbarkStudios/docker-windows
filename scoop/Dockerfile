FROM mcr.microsoft.com/powershell:nanoserver-1809

COPY install-scoop.ps1 install-scoop.ps1

# Install scoop
RUN pwsh ./install-scoop.ps1

# Install git, scoop actually requires git to eg add buckets, and it will
# most likely be used in child containers anyways
RUN pwsh -command "scoop install git-with-openssh"

CMD ["scoop"]
