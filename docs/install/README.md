[<< back](../../README.md)

# Teuton installation

Node definitions:
* **T-node**: Host where Teuton software is installed. Monitor S-NODE hosts.
* **S-node**: Host where SSH server is installed. This hosts are monitotized by T-NODE host.

> Read [Modes of use](modes_of_use.md) to know about different Teuton ways of using it.

## T-NODE installation

* **Install** Teuton on machine with T-NODE role.
Installation process:
    1. Install Ruby on your system.
    2. `gem install teuton`
* Run `teuton version` to check your installation is ok.

> **PROBLEMS**: If you have problems to find `teuton`command (OpenSUSE distro), try this:
> * Option A:
>     * `ruby -v`, display your current ruby version. Suppose it is 2.5.
>     * Run `teuton.ruby2.5`, instead of `teuton`.
> * Option B:
>     * `find /usr/lib64/ruby -name teuton`, to find absolute path to teuton command.
>     * `sudo ln -s /PATH/TO/bin/teuton /usr/local/bin/teuton`, to create symbolic link to teuton command.

* **Update** Teuton with `gem teuton update`.
* **Uninstall** Teuton with `gem uninstall teuton`

## S-NODE installation

* **Install** SSH server on every machine with S-NODE role.

> [All available installation](all.md) ways.

---
Let's us known your installation difficulties.

Thanks!
