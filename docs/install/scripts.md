[<< back](README.md)

# Using scripts to install Teuton

---
# T-NODE installation

* **T-node**: Host where Teuton software is installed. Monitor S-NODE hosts.

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

* **S-node**: Host where SSH server is installed. This hosts are monitotized by T-NODE host.

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
