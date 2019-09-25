
If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotContains "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

$file = "$env:USERPROFILE\OpenSSH-Win64.zip"
$url = "https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.0.0.0p1-Beta/OpenSSH-Win64.zip"

(New-Object System.Net.WebClient).DownloadFile([System.Uri]$url, $file)

