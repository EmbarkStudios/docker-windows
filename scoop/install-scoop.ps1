$ErrorActionPreference="Stop"

echo "Temporarily allowing the execution of remote scripts"
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force

echo "Installing Scoop"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh'))

Add-Content -Path $Profile.CurrentUserAllHosts -Value '$Env:Path += ";C:\ContainerAdministrator\scoop\shims"'
