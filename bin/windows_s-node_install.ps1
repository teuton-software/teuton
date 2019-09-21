<#
Windows S-NODE installation
version: 20190922
#>

If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotContains "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

Write-Host "[0/5.INFO] WINDOWS S-NODE installation"

Write-Host "[1/5.INFO] Installing PACKAGES..."

$tempdir = "$env:windir\temp"
$zipfile = "$tempdir\OpenSSH-Win64.zip"

Write-Host "Downloading OpenSSH-Win64..."
Invoke-WebRequest -Uri "https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.0.0.0p1-Beta/OpenSSH-Win64.zip" -OutFile $zipfile

Write-Host "Unzipping OpenSSH..."
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $env:ProgramFiles)

Write-Host "Removing temporary files..."
Remove-Item $zipfile

Write-Host "[2/5.INFO] Config OpenSSH as a service"
& "$env:ProgramFiles\OpenSSH-Win64\install-sshd.ps1" | Out-Null

Write-Host "[3/5.INFO] Config auto and running ssh service"
Set-Service sshd -StartupType Automatic
Start-Service sshd

Write-Host "[4/5.INFO] Opening TCP port 22 in Windows Firewall"
$FirewallRuleName = "SSH TCP port 22"
If (!(Get-NetFirewallRule -DisplayName $FirewallRuleName -ErrorAction SilentlyContinue)) {
    New-NetFirewallRule -DisplayName $FirewallRuleName -Direction Inbound -Action Allow -Protocol TCP -LocalPort @('22') | Out-Null
}

Write-Host "[5/5.INFO] Finish!"