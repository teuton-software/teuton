#!/bin/bash
# MacOSX S-Node Installation
# version: 20190312

[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

function ssh_enabled() {
	systemsetup -getremotelogin | grep -q "On$"
}

echo "[0/2.INFO] MacOSX S-NODE installation"

echo "[1/2.INFO] Enabling SSH server..."
ssh_enabled || systemsetup -setremotelogin on

echo "[2/2.INFO] Finish!"