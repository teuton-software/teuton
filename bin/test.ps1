<#
Windows S-NODE installation
version: 20190922
#>

If ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -NotContains "S-1-5-32-544") {
    $Host.UI.WriteErrorLine("Must be run as administrator")
    Exit 1
}

$global:temp = "$env:windir\temp\snode"
$file = "$global:temp\OpenSSH-Win64.zip"
$url = "https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.0.0.0p1-Beta/OpenSSH-Win64.zip"

function Make-Folder($folder) {
    Write-Host "Creating folder $folder ..."
    New-Item -ItemType Directory $folder -ErrorAction SilentlyContinue | Out-Null
}

function Remove-Folder($folder) {
    Write-Host "Removing folder $folder..."
    Remove-Item -Force -Recurse $folder
}

function Unzip-File($zipFile, $destFolder) {
    & "$env:ProgramFiles\7-Zip\7z" "e" "-y" "-o$destFolder" "$zipFile" | Out-Null
}

function Wget-File($url, $file) {
    & "$env:ProgramFiles\wget\wget" "-O" "$file" "$url"
}

function Install-7zip() {
    Write-Host "Downloading and installing 7-Zip ..."
    (New-Object System.Net.WebClient).DownloadFile("https://www.7-zip.org/a/7z1900-x64.msi", "$global:temp\7z1900-x64.msi")
    & "$global:temp\7z1900-x64.msi" /passive
}

function Install-Wget() {
    Write-Host "Downloading and installing wget for Windows ..."
    (New-Object System.Net.WebClient).DownloadFile("https://eternallybored.org/misc/wget/releases/wget-1.20.3-win64.zip", "$global:temp\wget-1.20.3-win64.zip")
    Unzip-File "$global:temp\wget-1.20.3-win64.zip" "$env:ProgramFiles\wget"
}

Write-Host "[0/5.INFO] WINDOWS S-NODE installation"

Write-Host "[1/5.INFO] Installing PACKAGES..."

Make-Folder $global:temp

Install-7zip

Install-Wget

Write-Host "Downloading OpenSSH-Win64 from $url to $file..."
Wget-File $url $file 

Write-Host "Unzipping OpenSSH..."
Unzip-File $file $env:ProgramFiles

Remove-Folder $global:temp

Write-Host "[2/5.INFO] Config OpenSSH as a service"
& "$env:ProgramFiles\OpenSSH-Win64\install-sshd.ps1" | Out-Null

Write-Host "[3/5.INFO] Config auto and running ssh service"
Set-Service sshd -StartupType Automatic
Start-Service sshd

Write-Host "[4/5.INFO] Opening TCP port 22 in Windows Firewall"
$FirewallRuleName = "SSH TCP port 22"
If (!(Get-NetFirewallRule -DisplayName $FirewallRuleName -ErrorAction SilentlyContinue)) {
    New-NetFirewallRule -DisplayName $FirewallRuleName -Direction Inbound -Action Allow -Protocol TCP -LocalPort @('22') | Out-Null
}

Write-Host "[5/5.INFO] Finish!"