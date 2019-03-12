#!/bin/bash
# MacOSX T-Node Uninstallation
# version: 20190312

echo "[0/4.INFO] GNU/Linux T-NODE uninstallation"

echo "[1/4.INFO] Checking distro..."
[ "$distro" = "" ] && exists_binary zypper && distro=opensuse
[ "$distro" = "" ] && exists_binary apt-get && distro=debian
[ "$distro" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $distro distribution found"

echo "[2/4.INFO] Uninstalling PACKAGES..."
[ $distro = "debian" ] && apt-get remove -y git ruby irb
[ $distro = "opensuse" ] && zypper remove -y git

echo "[3/4.INFO] Uninstalling teuton..."
rm -rf /usr/local/bin/teuton
rm -rf $teutonPath

echo "[4/4.INFO] Finish!"