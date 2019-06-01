<#
Windows T-NODE uninstallation
version: 20190129
#>

If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotMatch "S-1-5-32-544") {
    Write-Error -Category PermissionDenied "Must be run as administrator"
    Exit 1
}

$TeutonPath = $env:ProgramFiles + "\teuton"

Write-Host "[0/4.INFO] WINDOWS T-NODE uninstallation"

Write-Host "[1/4.INFO] Uninstalling PACKAGES..."
If (Get-Command choco.exe -ErrorAction SilentlyContinue) {
    choco uninstall git ruby -y --remove-dependencies
}

Write-Host "[2/4.INFO] Uninstalling teuton"
Remove-Item -Force -Recurse $TeutonPath

Write-Host "[3/4.INFO] Removing teuton from system environment PATH variable"
$CurrentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
If (!$CurrentPath.Contains($TeutonPath)) {
    [Environment]::SetEnvironmentVariable("Path", $CurrentPath.Replace($TeutonPath, ""), [EnvironmentVariableTarget]::Machine)
}

Write-Host "[4/4.INFO] Finish!"