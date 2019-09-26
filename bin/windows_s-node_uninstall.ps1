<#
Windows S-NODE uninstallation
version: 20190925
#>

If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotContains "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

Write-Host "[0/5.INFO] WINDOWS S-NODE uninstallation"

Write-Host "[1/5.INFO] Closing TCP port 22 in Windows Firewall"
& "netsh" "advfirewall" "firewall" "delete" "rule" "name=SSH TCP port 22" | Out-Null

Write-Host "[2/5.INFO] Stopping and disabling ssh service"
Stop-Service sshd
Set-Service sshd -StartupType Disabled

Write-Host "[3/5.INFO] Removing OpenSSH as a service"
& "$env:ProgramFiles\OpenSSH-Win64\uninstall-sshd.ps1" | Out-Null

Write-Host "[4/5.INFO] Uninstalling PACKAGES..."
Remove-Item $env:ProgramFiles\OpenSSH-Win64 -Recurse -Force

Write-Host "[5/5.INFO] Finish!"