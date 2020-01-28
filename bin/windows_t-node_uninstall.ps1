<#
Windows T-NODE uninstallation
version: 20191105
#>

If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotContains "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

Write-Host "[0/2.INFO] WINDOWS T-NODE uninstallation"

Write-Host "[1/2.INFO] Uninstalling teuton"
gem uninstall -x teuton

Write-Host "[2/2.INFO] Finish!"