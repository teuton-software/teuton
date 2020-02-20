
There are different Teuton [Modes of use](modes_of_use.md). For every mode there are 2 node types and every node has their own installation script:

* **T-node**: This host has installed Teuton software.
* **S-node**: This host has installed SSH server.

---
# T-NODE

* **Install** Teuton on machine with T-NODE role.
Installation process:
    1. Install Ruby on your system.
    2. `gem install teuton`
* Run `teuton version` to check that your installation is ok.

> **PROBLEMS**: If you have problems to find `teuton`command (OpenSUSE distro), try this:
> * `find / -name teuton`, to find absolute path to teuton command.
> * As superuser do `ln -s /PATH/TO/bin/teuton /usr/local/bin/teuton`, to create symbolic link to teuton command.
> * Try again as normal user.

* **Update** Teuton with `gem teuton update`.
* **Uninstall** Teuton with `gem uninstall teuton`

---
# S-NODE

* **Install** SSH server on every machine with S-NODE role.

---
# Other installation ways

## Using scripts

[Installation using scripts](scripts.md)
* Use our scripts to run automatical installation for your OS.
* Use this way if you don't know how to install Ruby on your system.

## Using Vagranfiles

[Installation using Vagrant](vagrant.md)
* If you plan to install Teuton into virtual machines, and have Vagrant installed into your real machine, this is the easier way for you.

## Manual

[Manual installation](manual.md)
* If you don't need help, and want to install Teuton by your own, or there are not installation scripts for your favorite OS, and you don't want to use Vagrant then... here you have information how to install all the required packages for Teuton.

Let's us known your installation difficulties.

Thanks!
