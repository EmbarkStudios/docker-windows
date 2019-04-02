FROM mcr.microsoft.com/windows/servercore:ltsc2019

COPY install-scoop.ps1 install-scoop.ps1

# Install scoop
RUN powershell ./install-scoop.ps1

CMD ["scoop"]
