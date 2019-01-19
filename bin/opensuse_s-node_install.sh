#!/bin/bash

CONFIGFILE="/etc/ssh/sshd_config"
BACKUPFILE="$CONFIGFILE.bak"

echo "[INFO] SSH on OpenSUSE"
echo "[INFO] Installation..."
zypper in -y openssh
systemctl enable sshd

echo "[INFO] Configuration..."

cp $CONFIGFILE $BACKUPFILE
sed 's/^#PermitRootLogin yes/PermitRootLogin yes/g' $BACKUPFILE > $CONFIGFILE
systemctl restart sshd
