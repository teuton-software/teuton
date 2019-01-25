#!/bin/bash
# version: 20190125

echo "[INFO] OPENSUSE T-NODE installation"
echo "[INFO] Installing PACKAGES..."
zypper refresh
zypper install -y git
gem install rake

echo "[INFO] Cloning git REPO..."
git clone https://github.com/dvarrui/teuton.git

echo "[INFO] Checking..."
cd teuton
rake opensuse
rake

echo "[INFO] Finish!"
./teuton version
