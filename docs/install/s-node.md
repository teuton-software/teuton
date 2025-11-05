[<< back](README.md)

# S-NODE installation

Install SSH server on every machine with S-NODE role.

**S-node**: Host where SSH server is installed. This hosts are monitorized by T-NODE host.

**GNU/Linux installation**

Run this command as `root` user:

```bash
wget -qO- https://raw.githubusercontent.com/teuton-software/teuton/master/install/linux/s-node_install.sh | bash
```

**Windows installation**

Requirements:
* Windows 7+ / Windows Server 2003+
* PowerShell v2+

Run this command on **PowerShell (PS)** as `Administrator` user:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/teuton-software/teuton/master/install/windows/s-node_install.ps1'))
```

**Mac OS X installation**

Run this command as `root` user:

```bash
curl -sL https://raw.githubusercontent.com/teuton-software/teuton/master/install/mac/s-node_install.sh | bash
```
