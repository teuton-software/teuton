#!/bin/bash

CONFIGFILE="/etc/ssh/sshd_config"
BACKUPFILE="$CONFIGFILE.bak"

echo "[INFO] OPENSUSE S-NODE installation"
echo "[INFO] Installing PACKAGES..."
zypper in -y openssh

echo "[INFO] Configuring..."
cp $CONFIGFILE $BACKUPFILE
sed 's/^#PermitRootLogin yes/PermitRootLogin yes/g' $BACKUPFILE > $CONFIGFILE
systemctl restart sshd
systemctl enable sshd

echo "[INFO] Finish!"
