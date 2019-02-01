<#
Windows S-NODE installation
version: 20190127
#>

Write-Host "[INFO] WINDOWS S-NODE installation"

Write-Host "[INFO] Installing PACKAGES..."
If (!(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
choco install -y openssh

Write-Host "[INFO] Config OpenSSH as a service"
& "$env:ProgramFiles\OpenSSH-Win64\install-sshd.ps1" | Out-Null

Write-Host "[INFO] Config auto and running ssh service"
Set-Service sshd -StartupType Automatic
Start-Service sshd

Write-Host "[INFO] Opening TCP port 22 in Windows Firewall"
$FirewallRuleName = "SSH TCP port 22"
If (!(Get-NetFirewallRule -DisplayName $FirewallRuleName -ErrorAction SilentlyContinue)) {
    New-NetFirewallRule -DisplayName $FirewallRuleName -Direction Inbound -Action Allow -Protocol TCP -LocalPort @('22') | Out-Null
}

Write-Host "[INFO] Finish!"
if (Get-Service sshd -ErrorAction SilentlyContinue) { exit 0 } else { exit 1 }