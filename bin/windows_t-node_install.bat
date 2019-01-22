@echo off

REM Windows T-NODE installation
REM version: 20190122

echo [INFO] WINDOWS T-NODE installation
echo [INFO] Installing PACKAGES...
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco install -y git
choco install -y ruby

REM Update environment variables after packages installation
call refreshenv

REM Rake Gem installation
call gem install rake -f

echo [INFO] Cloning git REPO...
git clone https://github.com/dvarrui/teuton.git

echo [INFO] Checking...
cd teuton
call rake gems
call rake get_challenges
call rake

echo [INFO] Finish!
ruby teuton version