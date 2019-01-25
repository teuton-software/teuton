#!/bin/bash
# version: 20190125

echo "[INFO] DEBIAN T-NODE installation"
echo "[INFO] Installing PACKAGES..."
apt update
apt install -y git
apt install -y ruby irb
gem install rake

echo "[INFO] Cloning git REPO..."
git clone https://github.com/dvarrui/teuton.git

echo "[INFO] Checking..."
cd teuton
rake debian
rake

echo "[INFO] Finish!"
./teuton version
