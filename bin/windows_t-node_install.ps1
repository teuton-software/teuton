<#
Windows T-NODE installation
version: 20190129
#>

If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotMatch "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

$TeutonPath = $env:ProgramFiles + "\teuton"
$TeutonUrl = "https://github.com/teuton-software/teuton.git"

Write-Host "[0/6.INFO] WINDOWS T-NODE installation"

Write-Host "[1/6.INFO] Installing PACKAGES..."
If (!(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
choco install -y git
choco install -y ruby

$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
refreshenv

Write-Host "[2/6.INFO] Rake gem installation"
gem install rake -f

Write-Host "[3/6.INFO] Installing teuton in $TeutonPath"
git clone $TeutonUrl $TeutonPath -q

Write-Host "[4/6.INFO] Adding teuton to system environment PATH variable"
$CurrentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
If (!$CurrentPath.Contains($TeutonPath)) {
    [Environment]::SetEnvironmentVariable("Path", $CurrentPath + ";$TeutonPath", [EnvironmentVariableTarget]::Machine)
}

Write-Host "[5/6.INFO] Configuring..."
Push-Location
cd $TeutonPath
rake gems
rake
Pop-Location

refreshenv

Write-Host "[6/6.INFO] Finish!"
teuton version