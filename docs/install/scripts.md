[<< back](README.md)

# Teuton installation using scripts

There are different Teuton [Modes of use](modes_of_use.md). For every mode there are 2 node types and every node has their own installation script:

* **T-node**: This host has installed Teuton software.
* **S-node**: This host has installed SSH server.

> Consult [tested OS](tested_os.md) to ensure if your favorite OS script installation has been tested.

---
# T-NODE installation

## T-NODE: GNU/Linux installation

Run this command as `root` user:

```bash
wget -qO- https://raw.githubusercontent.com/teuton-software/teuton/devel/install/linux/linux_t-node_install.sh | bash
```

## T-NODE: Mac OS X installation

Run this command as admin user (member of `admin` group):

```bash
curl -sL https://raw.githubusercontent.com/teuton-software/teuton/devel/install/mac/macosx_t-node_install.sh | bash
```

> No `root` user.

## T-NODE: Windows installation

Requirements:
* Windows 7+ / Windows Server 2003+
* PowerShell v2+

Run this command on **PowerShell (PS)** as `Administrator` user:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/teuton-software/teuton/devel/install/windows_t-node_install.ps1'))
```

---

# S-NODE installation

This is, SSH server installation.

> The user from T-NODE have to know admin password/user to establish SSH connections to S-NODE.

## S-NODE: GNU/Linux installation

Run this command as `root` user:

```bash
wget -qO- https://raw.githubusercontent.com/teuton-software/teuton/devel/install/linux/linux_s-node_install.sh | bash
```

## S-NODE: Mac OS X installation

Run this command as `root` user:

```bash
curl -sL https://raw.githubusercontent.com/teuton-software/teuton/devel/install/mac/macosx_s-node_install.sh | bash
```

## S-NODE: Windows installation

Requirements:
* Windows 7+ / Windows Server 2003+
* PowerShell v2+

Run this command on **PowerShell (PS)** as `Administrator` user:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/teuton-software/teuton/devel/install/windows/windows_s-node_install.ps1'))
```
