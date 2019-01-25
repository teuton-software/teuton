#!/bin/bash
# version: 20190124

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

CONFIGFILE="/etc/ssh/sshd_config"
BACKUPFILE="$CONFIGFILE.bak"

echo "[INFO] GNU/Linux S-NODE installation"

echo "[INFO] Checking distro..."
if which zypper > /dev/null
then
	echo "- OpenSUSE distribution found"
	distro=opensuse
elif which apt > /dev/null
then
	echo "- Debian distribution found"
	distro=debian
else
	echo "- Unknown distribution ... exiting!"
	exit 1
fi

echo "[INFO] Installing PACKAGES..."
[ $distro = "opensuse" ] && zypper install -y openssh
[ $distro = "debian" ] && apt install -y openssh-server sudo

echo "[INFO] Configuring SSH service..."
[ ! -f $BACKUPFILE ] && cp $CONFIGFILE $BACKUPFILE
sed 's/^#PermitRootLogin .*$/PermitRootLogin yes/g' $BACKUPFILE > $CONFIGFILE
systemctl restart sshd
systemctl enable sshd 2> /dev/null

echo "[INFO] Creating teuton user"
useradd -m -s /bin/bash teuton
[ $distro = "opensuse" ] && usermod -aG wheel teuton
[ $distro = "debian" ] && usermod -aG sudo teuton

echo "[INFO] Finish!"
echo "[INFO] You have to set teuton user password manually (e.g.: sudo passwd teuton)"
