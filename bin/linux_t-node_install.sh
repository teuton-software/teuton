#!/bin/bash
# GNU/Linux T-Node Installation
# version: 20190127

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

teutonPath=/opt/teuton
teutonUrl=https://github.com/dvarrui/teuton.git

function exists_binary() {
	which $1 > /dev/null
}

echo "[INFO] GNU/Linux T-NODE installation"

echo "[INFO] Checking distro..."
[ "$distro" = "" ] && exists_binary zypper && distro=opensuse
[ "$distro" = "" ] && exists_binary apt && distro=debian
[ "$distro" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $distro distribution found"

echo "[INFO] Installing PACKAGES..."
[ $distro = "debian" ] && apt update && apt install -y git ruby irb
[ $distro = "opensuse" ] && zypper refresh && zypper install -y git

echo "[INFO] Rake gem installation"
gem install rake

echo "[INFO] Installing teuton..."
git clone $teutonUrl $teutonPath -q

echo "[INFO] Configuring..."
cd $teutonPath
rake $distro
rake

echo "[INFO] Finish!"
/usr/local/bin/teuton version