#!/bin/bash
# MacOSX T-Node Uninstallation
# version: 20190312

teutonPath=/usr/local/opt/teuton

echo "[0/3.INFO] MacOSX T-NODE uninstallation"

echo "[1/3.INFO] Uninstalling PACKAGES..."
brew uninstall git
brew uninstall chruby

sed -i "" '/^source \/usr\/local\/opt\/chruby\/share\/chruby\/chruby.sh$/d' ~/.bash_profile
sed -i "" '/^source \/usr\/local\/opt\/chruby\/share\/chruby\/auto.sh$/d' ~/.bash_profile
rm -rf ~/.ruby_version

echo "[2/3.INFO] Uninstalling teuton..."
rm -rf /usr/local/bin/teuton
rm -rf $teutonPath

echo "[3/3.INFO] Finish!"