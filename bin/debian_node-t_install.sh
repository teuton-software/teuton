#!/bin/bash

echo "[INFO] Debian T-NODE installation"
echo "[INFO] Packages..."
apt in -y git
systemctl enable openssh-server

echo "[INFO] Configuration..."

cp $CONFIGFILE $BACKUPFILE
sed 's/^#PermitRootLogin yes/PermitRootLogin yes/g' $BACKUPFILE > $CONFIGFILE
systemctl restart openssh-server
