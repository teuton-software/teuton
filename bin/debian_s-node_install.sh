#!/bin/bash
# version: 20190121

CONFIGFILE="/etc/ssh/sshd_config"
BACKUPFILE="$CONFIGFILE.bak"

echo "[INFO] DEBIAN S-NODE installation"
echo "[INFO] Installing PACKAGES..."
apt in -y openssh-server

echo "[INFO] Configuring..."
cp $CONFIGFILE $BACKUPFILE
sed 's/^#PermitRootLogin yes/PermitRootLogin yes/g' $BACKUPFILE > $CONFIGFILE
systemctl restart openssh-server
systemctl enable openssh-server

echo "[INFO] Finish!"
