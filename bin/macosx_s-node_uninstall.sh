#!/bin/bash
# MacOSX S-Node Uninstallation
# version: 20190312

echo "[0/2.INFO] MacOSX S-NODE uninstallation"

echo "[1/2.INFO] Disabling SSH server..."
systemsetup -setremotelogin off

echo "[2/2.INFO] Finish!"