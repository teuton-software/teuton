#!/bin/bash
# MacOSX T-Node Uninstallation
# version: 20190312

teutonPath=/usr/local/opt/teuton

echo "[0/4.INFO] MacOSX T-NODE uninstallation"

echo "[2/4.INFO] Uninstalling PACKAGES..."
brew uninstall git
brew uninstall chruby

echo "[3/4.INFO] Uninstalling teuton..."
rm -rf /usr/local/bin/teuton
rm -rf $teutonPath
grep -v "^chruby ruby$" ~/.bash_profile > ~/.bash_profile.bak
mv ~/.bash_profile.bak ~/.bash_profile

echo "[4/4.INFO] Finish!"