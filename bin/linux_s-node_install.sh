#!/bin/bash
# GNU/Linux S-Node Installation
# version: 20190124

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

function exists_binary() {
	which $1 > /dev/null
}

CONFIGFILE="/etc/ssh/sshd_config"
BACKUPFILE="$CONFIGFILE.bak"

echo "[INFO] GNU/Linux S-NODE installation"

echo "[INFO] Checking distro..."
[ "$distro" = "" ] && exists_binary zypper && distro=opensuse
[ "$distro" = "" ] && exists_binary apt    && distro=debian
[ "$distro" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $distro distribution found"

echo "[INFO] Installing PACKAGES..."
[ $distro = "opensuse" ] && zypper install -y openssh
[ $distro = "debian" ] && apt install -y openssh-server sudo

echo "[INFO] Configuring SSH service..."
[ ! -f $BACKUPFILE ] && cp $CONFIGFILE $BACKUPFILE
sed 's/^#PermitRootLogin .*$/PermitRootLogin yes/g' $BACKUPFILE > $CONFIGFILE
systemctl restart sshd
systemctl enable sshd 2> /dev/null

echo "[INFO] Finish!"