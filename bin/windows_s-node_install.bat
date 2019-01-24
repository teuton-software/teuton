@echo off

REM Windows S-NODE installation
REM version: 20190124

echo [INFO] WINDOWS S-NODE installation
echo [INFO] Installing PACKAGES...
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco install -y openssh

echo [INFO] Config OpenSSH as a service
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -File "%ProgramFiles%\OpenSSH-Win64\install-sshd.ps1"

echo [INFO] Config auto and running ssh service
sc config sshd start=auto
net start sshd

echo [INFO] Opening 22 TCP port in Windows Firewall
netsh advfirewall firewall add rule name="SSH TCP Port 22" dir=in action=allow protocol=TCP localport=22
netsh advfirewall firewall add rule name="SSH TCP Port 22" dir=out action=allow protocol=TCP localport=22

echo [INFO] Creating teuton user
net user teuton teuton /fullname:"Teuton" /comment:"Teuton user for remote testing" /expires:never /passwordchg:no /add
wmic useraccount WHERE "Name='teuton'" set PasswordExpires=false
net localgroup Administradores teuton /add

echo [INFO] Finish!
