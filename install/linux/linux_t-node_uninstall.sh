#!/bin/bash
# GNU/Linux T-Node Uninstallation
# version: 20191205

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

echo "[0/2.INFO] GNU/Linux T-NODE uninstallation"

echo "[1/2.INFO] Uninstalling teuton..."
gem uninstall -x teuton

echo "[2/2.INFO] Finish!"