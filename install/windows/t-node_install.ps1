<#
Windows T-NODE installation
version: 20191105
#>

If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotContains "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

Write-Host "[0/3.INFO] WINDOWS T-NODE installation"

Write-Host "[1/3.INFO] Installing PACKAGES..."
If (!(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
choco install -y ruby
refreshenv

Write-Host "[2/3.INFO] Installing teuton"
gem install teuton

Write-Host "[3/3.INFO] Finish!"
teuton version