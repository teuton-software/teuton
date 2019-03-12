#!/bin/bash
# MacOSX S-Node Uninstallation
# version: 20190312

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

function ssh_enabled() {
	systemsetup -getremotelogin | grep -q "On$"
}

echo "[0/2.INFO] MacOSX S-NODE uninstallation"

echo "[1/2.INFO] Disabling SSH server..."
ssh_enabled && $( echo yes | systemsetup -setremotelogin off )

echo "[2/2.INFO] Finish!"