#!/bin/bash
# GNU/Linux T-Node Installation
# version: 20190127

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

teutonPath=/opt/teuton
teutonUrl=https://github.com/teuton-software/teuton.git

function exists_binary() {
	which $1 > /dev/null
}

echo "[0/6.INFO] GNU/Linux T-NODE installation"

echo "[1/6.INFO] Checking distro..."
[ "$distro" = "" ] && exists_binary zypper && distro=opensuse
[ "$distro" = "" ] && exists_binary apt-get && distro=debian
[ "$distro" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $distro distribution found"

echo "[2/6.INFO] Installing PACKAGES..."
[ $distro = "debian" ] && apt-get update && apt-get install -y git ruby irb
[ $distro = "opensuse" ] && zypper refresh && zypper install -y git

echo "[3/6.INFO] Rake gem installation"
gem install rake --no-ri

echo "[4/6.INFO] Installing teuton..."
git clone $teutonUrl $teutonPath -q

echo "[5/6.INFO] Configuring..."
cd $teutonPath
rake $distro
rake

echo "[6/6.INFO] Finish!"
/usr/local/bin/teuton version
