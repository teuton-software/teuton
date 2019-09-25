Import-Module BitsTransfer


If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotContains "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

$url = "https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.0.0.0p1-Beta/OpenSSH-Win64.zip"
$file = "C:/OpenSSH-Win64.zip"

# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls
$web = new-object System.Net.WebClient
$web.DownloadFile([string]$url, [string]$file)

