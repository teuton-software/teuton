#!/bin/bash
# GNU/Linux S-Node Installation
# version: 20190124

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

function exists_binary() {
	which $1 > /dev/null
}

CONFIGFILE="/etc/ssh/sshd_config"
BACKUPFILE="$CONFIGFILE.bak"

echo "[0/4.INFO] GNU/Linux S-NODE installation"

echo "[1/4.INFO] Checking distro..."
[ "$distro" = "" ] && exists_binary zypper && distro=opensuse
[ "$distro" = "" ] && exists_binary apt-get && distro=debian
[ "$distro" = "" ] && exists_binary dnf && distro=fedora
[ "$distro" = "" ] && echo "Unsupported distribution ... exiting!" && exit 1
echo "- $distro distribution found"

echo "[2/4.INFO] Installing PACKAGES..."
[ $distro = "opensuse" ] && zypper install -y openssh
[ $distro = "debian" ] && apt-get install -y openssh-server sudo
[ $distro = "fedora" ] && dnf install -y openssh-server sudo

echo "[3/4.INFO] Configuring SSH service..."
[ ! -f $BACKUPFILE ] && cp $CONFIGFILE $BACKUPFILE
sed 's/^#PermitRootLogin .*$/PermitRootLogin yes/g' $BACKUPFILE > $CONFIGFILE
systemctl restart sshd
systemctl enable sshd 2> /dev/null

echo "[4/4.INFO] Finish!"
