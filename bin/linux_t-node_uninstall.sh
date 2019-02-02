#!/bin/bash
# GNU/Linux T-Node Uninstallation
# version: 20190127

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

teutonPath=/opt/teuton

function exists_binary() {
	which $1 > /dev/null
}

echo "[0/4.INFO] GNU/Linux T-NODE uninstallation"

echo "[1/4.INFO] Checking distro..."
[ "$distro" = "" ] && exists_binary zypper && distro=opensuse
[ "$distro" = "" ] && exists_binary apt    && distro=debian
[ "$distro" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $distro distribution found"

echo "[2/4.INFO] Uninstalling PACKAGES..."
[ $distro = "debian" ] && apt remove -y git ruby irb
[ $distro = "opensuse" ] && zypper remove -y git

echo "[3/4.INFO] Uninstalling teuton..."
rm -rf /usr/local/bin/teuton
rm -rf $teutonPath

echo "[4/4.INFO] Finish!"