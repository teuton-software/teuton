<#
Windows T-NODE installation
version: 20190127
#>

$TeutonPath = $env:ProgramFiles + "\teuton"
$TeutonUrl = "https://github.com/dvarrui/teuton.git"

Write-Host "[INFO] WINDOWS T-NODE installation"

Write-Host "[INFO] Installing PACKAGES..."
If (!(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
choco install -y git
choco install -y ruby

$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
refreshenv

Write-Host "[INFO] Rake gem installation"
gem install rake -f

Write-Host "[INFO] Installing teuton in $TeutonPath"
git clone $TeutonUrl $TeutonPath -q

Write-Host "[INFO] Adding teuton to system environment PATH variable"
$CurrentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
If (!$CurrentPath.Contains($TeutonPath)) {
    [Environment]::SetEnvironmentVariable("Path", $CurrentPath + ";$TeutonPath", [EnvironmentVariableTarget]::Machine)
}

Write-Host "[INFO] Configuring..."
Push-Location
cd $TeutonPath
rake gems
rake
Pop-Location

refreshenv

Write-Host "[INFO] Finish!"
teuton version