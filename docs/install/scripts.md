[<< back](README.md)

# Using scripts to install Teuton

1. T-Node installation
    * GNU/Linux
    * MACOSX
    * Windows
2. S-Node installation
    * GNU/Linux
    * MACOSX
    * Windows
3. Tested OS list

---
# 1. T-NODE installation

* **T-node**: Host where Teuton software is installed. Monitor S-NODE hosts.

## 1.1 T-NODE: GNU/Linux installation

Run this command as `root` user:

```bash
wget -qO- https://raw.githubusercontent.com/teuton-software/teuton/master/install/linux/linux_t-node_install.sh | bash
```

## 1.2 T-NODE: Windows installation

Requirements:
* Windows 7+ / Windows Server 2003+
* PowerShell v2+

Run this command on **PowerShell (PS)** as `Administrator` user:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/teuton-software/teuton/master/install/windows/windows_t-node_install.ps1'))
```

## 1.3 T-NODE: Mac OS X installation

Run this command as admin user (member of `admin` group):

```bash
curl -sL https://raw.githubusercontent.com/teuton-software/teuton/master/install/mac/macosx_t-node_install.sh | bash
```

---
# 2. S-NODE installation

* **S-node**: Host where SSH server is installed. This hosts are monitorized by T-NODE host.

## 2.1 S-NODE: GNU/Linux installation

Run this command as `root` user:

```bash
wget -qO- https://raw.githubusercontent.com/teuton-software/teuton/master/install/linux/linux_s-node_install.sh | bash
```

## 2.2 S-NODE: Windows installation

Requirements:
* Windows 7+ / Windows Server 2003+
* PowerShell v2+

Run this command on **PowerShell (PS)** as `Administrator` user:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/teuton-software/teuton/master/install/windows/windows_s-node_install.ps1'))
```

## 2.3 S-NODE: Mac OS X installation

Run this command as `root` user:

```bash
curl -sL https://raw.githubusercontent.com/teuton-software/teuton/master/install/mac/macosx_s-node_install.sh | bash
```

---
# 3. Tested OS list

| Type      | O.S.      | Version        | Arch   | T-node | S-node |
| --------- | --------- | -------------- | ------ | ------ | ------ |
| GNU/Linux | CentOS    | 7              | x86-64 |        |        |
|           | Debian    | 9.7.0          | x86-64 | Ok     |        |
|           | Fedora    | Workstation 29 | x84-64 | Ok     |        |
|           | LinuxMint | 18.3           | x86-64 | Ok     |        |
|           | openSUSE  | Leap 15        | x86-64 | Ok     | Ok     |
|           | Ubuntu    | 18.04          | x86-64 | Ok     | Ok     |
| Microsoft | Windows   | 7 Enterprise   | x86    | Ok     |        |
|           | Windows   | 10 Pro         | x86-64 | Ok     | Ok     |
|           | Windows   | Server 2012 R2 | x86-64 |        |        |
| Apple     | Mac OS X  | Capitán (10.11.6) | x86-64 | Ok  | Ok     |
|           | Mac OS X  | Sierra (10.12)    | x86-64 | Ok  |        |
