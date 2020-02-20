
There are diferents Teuton [Modes of use](Modes of use). For every mode there are 2 node typesm and every node has their own installation script:

* **T-node**: This host has installed Teuton software.
* **S-node**: This host has installed SSH server.

---
# T-NODE: Manual installation

| ID | Action            | Details |
| -- | ----------------- | ----------- |
| 1  | Git installation  | Run `git --version` to show current version |
| 2  | Ruby installation | Run `ruby -v` to show current version (2.1.3p242+) |
| 3  | Rake installation | Run `gem install rake`, then `rake --version` to show current version (10.4.2+). |
| 4  | Download this project | (a) `git clone https://github.com/dvarrui/teuton.git` (b) Download and unzip [file](https://github.com/dvarrui/teuton-panel/archive/master.zip). |
| 5  | Gems installation | Run `cd teuton` and `rake gems` |
| 6  | Final check       | `rake` |

---

# S-NODE: Manual installation

* Install SSH server on your host.

> How to [install SSH on Windows](windows-ssh)
