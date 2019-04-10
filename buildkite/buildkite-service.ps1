param (
    [string]$agentName = "buildkite-agent",
    [string]$installDir = "c:\buildkite-agent"
)

echo "Installing Buildkite agent"

# Run the BuildKite agent install script
Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/buildkite/agent/master/install.ps1'))

$clone_flags = "--config core.autocrlf=input --config core.eol=lf --config core.longpaths=true --config core.symlinks=true"
$timestamp = "timestamp-lines=true"

# Configure the BuildKite agent clone and timestamp behavior
Add-Content "$installDir\buildkite-agent.cfg" "`n# Configure git clone operations`ngit-clone-flags=$clone_flags`n"
Add-Content "$installDir\buildkite-agent.cfg" "# Include timestamps in log output`n$timestamp"

# Register the BuildKite agent service using NSSM, so that it persists through restarts and is
# restarted if the process dies.
echo "Registering BuildKite agent service."
echo "Registering $agentName as a service."
nssm.exe install $agentName "$installDir\bin\buildkite-agent.exe" "start"
nssm.exe set $agentName AppStdout "$installDir\$agentName.log"
nssm.exe set $agentName AppStderr "$installDir\$agentName.log"
nssm.exe status $agentName
nssm.exe start $agentName
nssm.exe status $agentName
