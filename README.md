
# TEUTON

[![Gem Version](https://badge.fury.io/rb/teuton.svg)](https://badge.fury.io/rb/teuton)
![GitHub](https://img.shields.io/github/license/dvarrui/teuton)
![Gem](https://img.shields.io/gem/dv/teuton/2.4.0)

_Create Unit Test for your machines. Test your infrastructure as code._

![logo](./docs/images/logo.png)

Teuton is an infrastructure test tool, useful for:
* Sysadmin teachers who want to evaluate students remote machines.
* Sysadmin apprentices who want to evaluate their learning process as a game.
* Professional sysadmin who want to monitor remote machines.

Teuton allow us:
* Write unit tests for real or virtual devices, using simple DSL.
* Check compliance with requirements on local or remote devices.

# Installation

Install Ruby and then:

```console
gem install teuton
```

> Install Teuton as normal user: `gem install --user-install teuton`

# Usage

Executing `teuton` command to run example test:

```console
❯ teuton run examples/01-target

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | anonymous | 100.0 | ✔     |
+------+-----------+-------+-------+

```

# Features

* [Free Software License](LICENSE).
* Multiplatform.
* Remote machines/devices only require SSH or Telnet service installed.

# Documentation

* [Learn](docs/learn/README.md)
* [Language reference](docs/dsl/README.md)
* [Commands](docs/commands/README.md)
* [Installation](docs/install/README.md)

> [Blogs and videos](docs/videos.md)

# Contact

* **Email**: `teuton.software@protonmail.com`

# Contributing

1. Make sure you have Ruby installed
1. Fork it
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create new Pull Request.

You can also [create issues](https://github.com/teuton-software/teuton/issues) with your requests/incidences/suggestions.
