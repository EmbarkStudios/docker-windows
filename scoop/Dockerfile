FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Change the user to just b instead of ContainerAdministrator as it is extremely
# long and lowers the chances of MAX_PATH shenanigans
RUN NET USER b /add
RUN NET LOCALGROUP Administrators /add b
USER b

SHELL ["powershell", "-NoLogo", "-c", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY install-scoop.ps1 install-scoop.ps1

# Install scoop
RUN ./install-scoop.ps1
RUN scoop update *

# Install git, scoop actually requires git to eg add buckets, and it will
# most likely be used in child containers anyways
RUN scoop install git-with-openssh

CMD ["scoop"]
