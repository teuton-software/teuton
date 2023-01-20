[<< back](README.md)

# S-NODE installation

Install SSH server on every machine with S-NODE role.

**S-node**: Host where SSH server is installed. This hosts are monitorized by T-NODE host.

**S-node GNU/Linux installation**

Run this command as `root` user:

```bash
wget -qO- https://raw.githubusercontent.com/teuton-software/teuton/master/install/linux/linux_s-node_install.sh | bash
```

**S-node Windows installation**

Requirements:
* Windows 7+ / Windows Server 2003+
* PowerShell v2+

Run this command on **PowerShell (PS)** as `Administrator` user:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/teuton-software/teuton/master/install/windows/windows_s-node_install.ps1'))
```

**S-node Mac OS X installation**

Run this command as `root` user:

```bash
curl -sL https://raw.githubusercontent.com/teuton-software/teuton/master/install/mac/macosx_s-node_install.sh | bash
```
