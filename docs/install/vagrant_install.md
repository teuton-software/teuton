* First, you must have `Vagrant` installed.
* Create directory for your vagrant project. For example, `mkdir teuton-vagrant`.
* Move into that directory: `cd teuton-vagrant`.
* Download required Vagrantfile:

| Vagrantfile        | URL |
| ------------------ | ----|
| Debian T-NODE VM | https://raw.githubusercontent.com/teuton-software/teuton/devel/bin/vagrant/debian/Vagrantfile |
| OpenSUSE T-NODE VM | https://raw.githubusercontent.com/teuton-software/teuton/devel/bin/vagrant/opensuse/Vagrantfile |

* Run `vagrant up` to create your Virtual Machine.

**Notice:** If you plan to build T-node and S-node VMs, then you need to use separated directories for every Vagranfile.
