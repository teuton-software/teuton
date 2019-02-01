<#
Windows S-NODE uninstallation
version: 20190127
#>

Write-Host "[INFO] WINDOWS S-NODE uninstallation"

Write-Host "[INFO] Closing TCP port 22 in Windows Firewall"
Remove-NetFirewallRule -DisplayName "SSH TCP port 22" | Out-Null

Write-Host "[INFO] Stopping and disabling ssh service"
Stop-Service sshd
Set-Service sshd -StartupType Disabled

Write-Host "[INFO] Removing OpenSSH as a service"
& "$env:ProgramFiles\OpenSSH-Win64\uninstall-sshd.ps1" | Out-Null

Write-Host "[INFO] Uninstalling PACKAGES..."
If (!(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
choco uninstall openssh -y --remove-dependencies

Write-Host "[INFO] Finish!"
if (Get-Service sshd -ErrorAction SilentlyContinue) { exit 1 } else { exit 0 }