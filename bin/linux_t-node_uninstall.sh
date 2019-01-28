#!/bin/bash
# GNU/Linux T-Node Uninstallation
# version: 20190127

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

teutonPath=/opt/teuton

function exists_binary() {
	which $1 > /dev/null
}

echo "[INFO] GNU/Linux T-NODE uninstallation"

echo "[INFO] Checking distro..."
[ "$distro" = "" ] && exists_binary zypper && distro=opensuse
[ "$distro" = "" ] && exists_binary apt    && distro=debian
[ "$distro" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $distro distribution found"

echo "[INFO] Uninstalling PACKAGES..."
[ $distro = "debian" ] && apt remove -y git ruby irb
[ $distro = "opensuse" ] && zypper remove -y git

echo "[INFO] Uninstalling teuton..."
rm -rf $teutonPath

echo "[INFO] Finish!"