

$wget = "http://downloads.sourceforge.net/gnuwin32/wget-1.11.4-1-setup.exe"
$url = "https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.0.0.0p1-Beta/OpenSSH-Win64.zip"
$file = "$env:windir\temp\OpenSSH-Win64.zip"

$dest = "$env:windir\temp\snode"

Write-Host "Creating temporary directory $dest ..."
New-Item -ItemType Directory $dest | Out-Null


Write-Host "Downloading and installing 7-Zip ..."
(New-Object System.Net.WebClient).DownloadFile("https://www.7-zip.org/a/7z1900-x64.msi", "$env:windir\temp\7z1900-x64.msi")
& "$env:windir\temp\7z1900-x64.msi" /passive

Write-Host "Downloading and installing wget for Windows ..."
(New-Object System.Net.WebClient).DownloadFile("https://netix.dl.sourceforge.net/project/gnuwin32/wget/1.11.4-1/wget-1.11.4-1-bin.zip", "$dest\wget-1.11.4-1-bin.zip")
(New-Object System.Net.WebClient).DownloadFile("https://netix.dl.sourceforge.net/project/gnuwin32/wget/1.11.4-1/wget-1.11.4-1-dep.zip", "$dest\wget-1.11.4-1-dep.zip")
$wget = "$env:ProgramFiles\wget"
& "$env:ProgramFiles\7-Zip\7z" e -y -o{$wget} "$dest\wget-1.11.4-1-bin.zip"
& "$env:ProgramFiles\7-Zip\7z" e -y -o{$wget} "$dest\wget-1.11.4-1-dep.zip"

Write-Host "Removing temporary directory $dest ..."
Remove-Item -Recurse -Force $dest
