#!/bin/bash
# GNU/Linux T-Node Installation
# version: 20231129

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

function exists_binary() {
	which $1 > /dev/null
}

echo "[0/4.INFO] GNU/Linux T-NODE installation"

echo "[1/4.INFO] Checking distro..."
[ "$distro" = "" ] && exists_binary zypper && distro=opensuse
[ "$distro" = "" ] && exists_binary apt-get && distro=debian
[ "$distro" = "" ] && exists_binary dnf && distro=fedora
[ "$distro" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $distro distribution found"

echo "[2/4.INFO] Installing PACKAGES..."
[ $distro = "debian" ] && apt-get update && apt-get install -y ruby
[ $distro = "fedora" ] && dnf upgrade && dnf install -y ruby

echo "[3/4.INFO] Installing teuton..."
gem install teuton

echo "[4/4.INFO] Finish!"
teuton version
