Write-Host "Temporarily allowing the execution of remote scripts"
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force

Write-Host "Installing Scoop"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh'))
