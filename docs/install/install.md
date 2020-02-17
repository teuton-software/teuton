
> We recommend you, start reading about [Modes of use](modes_of_use.md), and learn the differences between T-node and S-node before installation.

---
# T-NODE (Recomended)

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
# S-NODE (Recomended)

* **Install** SSH server on every machine with S-NODE role.

---
# Other installation ways

[Installation using scripts](scripts_install.md)
* Use our scripts to run automatical installation for your OS.
* Use this way if you don't know how to install Ruby on your system.

[Installation using Vagrant](vagrant_install.md)
* If you plan to install Teuton into virtual machines, and have Vagrant installed into your real machine, this is the easier way for you.

[Manual installation](manual_install.md)
* If you don't need help, and want to install Teuton by your own, or there are not installation scripts for your favorite OS, and you don't want to use Vagrant then... here you have information how to install all the required packages for Teuton.

Let's us known your installation difficulties.

Thanks!
