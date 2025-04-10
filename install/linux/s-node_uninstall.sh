#!/bin/bash
# GNU/Linux S-Node Uninstallation
# version: 20231129

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

function exists_binary() {
	which $1 > /dev/null
}

CONFIGFILE="/etc/ssh/sshd_config"
BACKUPFILE="$CONFIGFILE.bak"

echo "[0/4.INFO] GNU/Linux S-NODE uninstallation"

echo "[1/4.INFO] Checking distro..."
[ "$distro" = "" ] && exists_binary zypper && distro=opensuse
[ "$distro" = "" ] && exists_binary apt-get && distro=debian
[ "$distro" = "" ] && exists_binary dnf && distro=fedora
[ "$distro" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $distro distribution found"

echo "[2/4.INFO] Removing SSH service..."
mv $BACKUPFILE $CONFIGFILE
systemctl stop sshd
systemctl disable sshd 2> /dev/null

echo "[3/4.INFO] Uninstalling PACKAGES..."
[ $distro = "opensuse" ] && zypper remove -y openssh
[ $distro = "debian" ] && apt-get remove -y openssh-server sudo
[ $distro = "fedora" ] && dnf remove -y openssh-server
echo "[4/4.INFO] Finish!"
