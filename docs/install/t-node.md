[<< back](../../README.md)

# T-NODE installation

_T-NODE is a host with Teuton installed. Monitors one or severals S-NODE hosts._

1. Install Ruby on your system.
2. `gem install teuton`

> NOTE:
> * Show current version: `teuton version`.
> * Install a specific version: `gem install teuton -v VERSION`. Available versions ([rubygems.org/gems/teuton](https://rubygems.org/gems/teuton/)).
> * Update: `gem update teuton`.
> * Uninstall: `gem uninstall teuton`.

## 1. Problems

Sometimes we don't find `teuton` command (OpenSUSE distro, for example), so try this:

Option A:
* `ruby -v`, display your current ruby version. Suppose it is "2.5".
* Run `teuton.ruby2.5`, instead of `teuton`.

Option B:
* `find /usr/lib64/ruby -name teuton`, to find absolute path to teuton command.
* `sudo ln -s /PATH/TO/bin/teuton /usr/local/bin/teuton`, to create symbolic link to teuton command.

## 2. Installation scripts

If you don't know how to install Ruby on your system, execute this script to run automatical installation for your OS.

**GNU/Linux installation**

Run this command as `root` user:

```bash
wget -qO- https://raw.githubusercontent.com/teuton-software/teuton/master/install/linux/t-node_install.sh | bash
```

**Windows installation**

Requirements:
* Windows 7+ / Windows Server 2003+
* PowerShell v2+

Run this command on **PowerShell (PS)** as `Administrator` user:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/teuton-software/teuton/master/install/windows/t-node_install.ps1'))
```

**Mac OS X installation**

Run this command as admin user (member of `admin` group):

```bash
curl -sL https://raw.githubusercontent.com/teuton-software/teuton/master/install/mac/t-node_install.sh | bash
```

## 3. Vagrant and Docker installation

Choose this way if you plan to install Teuton into virtual machines or containers, and you are familiar with Vagrant and Docker technologies.

## 3.1 Install using Vagrant

* First, install `Vagrant` and `VirtualBox` on your host.
* Create directory for vagrant project. For example, `mkdir teuton-vagrant`.
* Move into that directory: `cd teuton-vagrant`.
* Choose and download [Vagrantfile](../../install/vagrant).
* Run `vagrant up` to create your Virtual Machine.

## 3.2 Install using Docker

First:
* Install `docker` on your host.

Second, choose:
* Pulling docker image from remote or
* Rebuild local docker image.

## 3.2 Pulling docker images from remote

Run this command to pull **dvarrui/teuton** image from Docker Hub and create "teuton" container:

`docker run --name teuton -v /home/teuton -i -t dvarrui/teuton /bin/bash`

## 3.2 Rebuild local docker image

1. Create Dockerfile like this:

```
FROM debian:latest

MAINTAINER teuton 2.1

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y vim tree
RUN apt-get install -y ruby
RUN gem install teuton
RUN mkdir /home/teuton

EXPOSE 80

WORKDIR /home/teuton
CMD ["/bin/bash"]
```

1. Build local docker image **dvarrui/teuton** with `docker build -t dvarrui/teuton .`
1. Create **teuton** container with `docker run --name teuton -v /home/teuton -i -t dvarrui/teuton /bin/bash`.

> Notice `/home/teuton` folder is persistent volume.

## 4. Source code

If you want to install Teuton by your own, or there are not installation scripts for your OS, and you don't want to use Vagrant then... here you have information how to install all the required packages for Teuton.

Manual installation:
1. Git installation
    * Install Git.
    * Run `git --version` to show current version
1. Ruby installation
    * Install ruby.
    * Run `ruby -v` to show current version (2.1.3p242+)
1. Rake installation
    * Run `gem install rake`, then
    * `rake --version` to show current version (10.4.2+).
1. Download this project
    * (a) `git clone https://github.com/dvarrui/teuton.git` or
    * (b) Download and unzip [file](https://github.com/dvarrui/teuton-panel/archive/master.zip).
1. Move into Teuton folder
    * Run `cd teuton`
1. Gems installation.
    * `rake install`, to install required gems.
1. Only for developers
    * Run `rake devel:debian` or
    * `rake devel:opensuse`, install gem for developers.
1. Final check
    * `rake`
