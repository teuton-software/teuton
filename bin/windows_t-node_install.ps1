<#
Windows T-NODE installation
version: 20190124
#>

$TeutonPath = $env:ProgramFiles + "\teuton"
$TeutonUrl = "https://github.com/dvarrui/teuton.git"
$ChallengesUrl = "https://github.com/dvarrui/teuton-challenges.git"
$CurrentLocation = Get-Location
$ChallengesPath = $CurrentLocation + "\teuton-challenges"

Write-Host "[INFO] WINDOWS T-NODE installation"

Write-Host "[INFO] Installing PACKAGES..."
If (!(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
choco install -y git
choco install -y ruby

Write-Host "[INFO] Rake gem installation"
gem install rake -f

Write-Host "[INFO] Installing teuton in $TeutonPath"
If (Get-ChildItem $TeutonPath -ErrorAction SilentlyContinue) {
    Remove-Item -Force -Recurse $TeutonPath
}
git clone $TeutonUrl $TeutonPath -q

Write-Host "[INFO] Installing challenges in $ChallengesPath"
If (Get-ChildItem $ChallengesPath -ErrorAction SilentlyContinue) {
    Write-Host "- teuton-challenges repo already exists at current location ... [skipping]"
} Else {
    git clone $ChallengesUrl -q
}

Write-Host "[INFO] Adding teuton to system environment PATH variable"
$CurrentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
If (!$CurrentPath.Contains($TeutonPath)) {
    [Environment]::SetEnvironmentVariable("Path", $CurrentPath + ";$TeutonPath", [EnvironmentVariableTarget]::Machine)
}

Write-Host "[INFO] Checking..."
cd $TeutonPath
rake gems
rake

Write-Host "[INFO] Finish!"
teuton version
cd $CurrentLocation