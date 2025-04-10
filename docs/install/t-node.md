[<< back](README.md)

# T-NODE installation

# 1. Recommended

Installation:
1. Install Ruby on your system.
2. `gem install teuton`

Run `teuton version` to check the installed version.

> NOTE:
> * Update: `gem update teuton`.
> * Uninstall: `gem uninstall teuton`.

# 2. Problems

Sometimes we don't find `teuton` command (OpenSUSE distro, for example), so try this:

Option A:
* `ruby -v`, display your current ruby version. Suppose it is "2.5".
* Run `teuton.ruby2.5`, instead of `teuton`.

Option B:
* `find /usr/lib64/ruby -name teuton`, to find absolute path to teuton command.
* `sudo ln -s /PATH/TO/bin/teuton /usr/local/bin/teuton`, to create symbolic link to teuton command.

# 3. Installation scripts

If you don't know how to install Ruby on your system, execute this script to run automatical installation for your OS.

**T-node GNU/Linux installation**

Run this command as `root` user:

```bash
wget -qO- https://raw.githubusercontent.com/teuton-software/teuton/master/install/linux/t-node_install.sh | bash
```

**T-node Windows installation**

Requirements:
* Windows 7+ / Windows Server 2003+
* PowerShell v2+

Run this command on **PowerShell (PS)** as `Administrator` user:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/teuton-software/teuton/master/install/windows/t-node_install.ps1'))
```

**T-node Mac OS X installation**

Run this command as admin user (member of `admin` group):

```bash
curl -sL https://raw.githubusercontent.com/teuton-software/teuton/master/install/mac/t-node_install.sh | bash
```

# 4. Vagrant/Docker

Choose this way if you plan to install Teuton into virtual machines or containers, and you are familiar with Vagrant and Docker technologies.

[Installation using Vagrant or Docker](vagrant_docker.md)

# 5. Source code

If you want to install Teuton by your own, or there are not installation scripts for your OS, and you don't want to use Vagrant then... here you have information how to install all the required packages for Teuton.

[Manual installation](manual.md)
