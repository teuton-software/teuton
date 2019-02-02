<#
Windows T-NODE uninstallation
version: 20190129
#>

$TeutonPath = $env:ProgramFiles + "\teuton"

Write-Host "[INFO] WINDOWS T-NODE uninstallation"

Write-Host "[INFO] Uninstalling PACKAGES..."
If (!(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
choco uninstall git ruby -y --remove-dependencies

Write-Host "[INFO] Uninstalling teuton"
Remove-Item -Force -Recurse $TeutonPath

Write-Host "[INFO] Removing teuton from system environment PATH variable"
$CurrentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
If (!$CurrentPath.Contains($TeutonPath)) {
    [Environment]::SetEnvironmentVariable("Path", $CurrentPath.Replace($TeutonPath, ""), [EnvironmentVariableTarget]::Machine)
}

Write-Host "[INFO] Finish!"