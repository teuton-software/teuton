

$wget = "http://downloads.sourceforge.net/gnuwin32/wget-1.11.4-1-setup.exe"
$url = "https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.0.0.0p1-Beta/OpenSSH-Win64.zip"
$file = "$env:windir\temp\OpenSSH-Win64.zip"

Write-Host "Downloading wget for Windows..."
(New-Object System.Net.WebClient).DownloadFile($wget, "$env:USERPROFILE\wget-1.11.4-1-setup.exe")

