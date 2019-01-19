#!/bin/bash

echo "[INFO] Debian T-NODE installation"
echo "[INFO] Installing PACKAGES..."
apt in -y git
apt in -y ruby irb
gem install rake

echo "[INFO] Cloning git REPO..."
git clone https://github.com/dvarrui/teuton.git

echo "[INFO] Checking..."
cd teuton
./teuton version
rake

echo "[INFO] Finish!"
