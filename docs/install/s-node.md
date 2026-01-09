[<< back](../../README.md)

# S-NODE Installation

_S-NODE is a host with SSH/Telnet service installed. S-NODE hosts are monitorized by T-NODE host._

S-NODES needs to have the SSH or Telnet service installed.

## SSH server installation

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
