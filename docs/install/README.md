[<< back](../../README.md)

# Installation

## Teuton installation

_T-NODE is a host with Teuton installed. Monitors one or severals S-NODE hosts._

1. Install Ruby on your system.
2. `gem install teuton`

Other ways of [Teuton installation](t-node.md).

## SSH server installation

_S-NODE is a host with SSH/Telnet service installed. S-NODE hosts are monitorized by T-NODE host._

**SSH GNU/Linux installation**

Run this command as `root` user:

```bash
wget -qO- https://raw.githubusercontent.com/teuton-software/teuton/master/install/linux/s-node_install.sh | bash
```

**SSH Windows installation**

Requirements:
* Windows 7+ / Windows Server 2003+
* PowerShell v2+

Run this command on **PowerShell (PS)** as `Administrator` user:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/teuton-software/teuton/master/install/windows/s-node_install.ps1'))
```

**SSH Mac OS X installation**

Run this command as `root` user:

```bash
curl -sL https://raw.githubusercontent.com/teuton-software/teuton/master/install/mac/s-node_install.sh | bash
```
