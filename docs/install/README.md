[<< back](../../README.md)

# Installation

> Definitions:
> * **T-node**: Host where Teuton software is installed. Monitor S-NODE hosts.
> * **S-node**: Host where SSH server is installed. This hosts are monitotized by T-NODE host.
>
> Read [Modes of use](modes_of_use.md) to know about different Teuton ways of using it.

## T-NODE installation

* **Install** Teuton (T-NODE role host):
    1. Install Ruby on your system.
    2. `gem install teuton`
* Run `teuton version` to check is fine.

> **PROBLEMS**: If you don't find `teuton`command (OpenSUSE distro), try this:
> * Option A:
>     * `ruby -v`, display your current ruby version. Suppose it is 2.5.
>     * Run `teuton.ruby2.5`, instead of `teuton`.
> * Option B:
>     * `find /usr/lib64/ruby -name teuton`, to find absolute path to teuton command.
>     * `sudo ln -s /PATH/TO/bin/teuton /usr/local/bin/teuton`, to create symbolic link to teuton command.

* **Update** with `gem teuton update`.
* **Uninstall** with `gem uninstall teuton`

## S-NODE installation

* **Install** SSH server on every machine with S-NODE role.

---
# Other installation ways

**Scripts**. [Installation using scripts](scripts.md)
* Use our scripts to run automatical installation for your OS.
* Use this way if you don't know how to install Ruby on your system.

**Vagrant**. [Installation using Vagrant](vagrant.md)
* If you plan to install Teuton into virtual machines, and have Vagrant installed into your real machine, this is the easier way for you.

**Docker**.

**Manual**. [Manual installation](manual.md)
* If you don't need help, and want to install Teuton by your own, or there are not installation scripts for your favorite OS, and you don't want to use Vagrant then... here you have information how to install all the required packages for Teuton.

---
Let's us known your installation difficulties.

Thanks!
