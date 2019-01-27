#!/bin/bash
# GNU/Linux S-Node Uninstallation
# version: 20190124

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

function exists_binary() {
	which $1 > /dev/null
}

CONFIGFILE="/etc/ssh/sshd_config"
BACKUPFILE="$CONFIGFILE.bak"

echo "[INFO] GNU/Linux S-NODE uninstallation"

echo "[INFO] Checking distro..."
exists_binary zypper && distro=opensuse
exists_binary apt    && distro=debian
[ "$distro" = "" ]   &&	echo "Unsupported distribution ... exiting!" && exit 1
echo "- $distro distribution found"

echo "[INFO] Removing SSH service..."
mv $BACKUPFILE $CONFIGFILE
systemctl stop sshd
systemctl disable sshd 2> /dev/null

echo "[INFO] Uninstalling PACKAGES..."
[ $distro = "opensuse" ] && zypper remove -y openssh
[ $distro = "debian" ] && apt remove -y openssh-server sudo

echo "[INFO] Finish!"