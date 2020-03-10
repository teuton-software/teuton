[<< back](README.md)

# Teuton installation for developers

There are diferents Teuton [Modes of use](Modes of use). For every mode there are 2 node types and every node has their own installation:

* **T-node**: This host has installed Teuton software.
* **S-node**: This host has installed SSH server.

---
# T-NODE: Manual installation

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
    * `rake install:gems`, to install required gems.
1. Only for developers
    * Run `rake install:debian` or
    * `rake install:opensuse`, install gem for developers.
1. Final check
    * `rake`

---

# S-NODE: Manual installation

* Install SSH server on your host.

> How to [install SSH on Windows](windows-ssh)
