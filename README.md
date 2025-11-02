
# TEUTON

[![Gem Version](https://badge.fury.io/rb/teuton.svg)](https://badge.fury.io/rb/teuton)
![GitHub](https://img.shields.io/github/license/dvarrui/teuton)

_Create Unit Test for your machines. Test your infrastructure as code._

![logo](./docs/images/logo.png)

The infrastructure test is useful for:
* Sysadmin teachers who want to evaluate students remote machines.
* Students who want to evaluate their learning process.
* Professionals who want to monitor their remote machines.

# Installation

Install Ruby and then:

```console
gem install teuton
```

> Install Teuton as normal user: `gem install --user-install teuton`

# Usage

Use `teuton run` command to run test:

```console
> teuton run examples/01-target

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | anonymous | 100.0 | ✔     |
+------+-----------+-------+-------+
```

> More information about [commands](docs/commands/README.md)

# Features

* Simple DSL to define your tests: `target`, `run`,`expect` and more.
* Remote devices only require SSH or Telnet service installed.
* Output format: txt, html, json, yaml, etc.
* Multiplatform.
* [Free Software License](LICENSE).

# Documentation

* [Installation](docs/install/README.md)
* [Getting started](docs/learn/README.md)
* [Examples](examples)
* [Commands](docs/commands/README.md)
* [Language reference](docs/dsl/README.md)
* [Blogs and videos](docs/videos.md)

# Contact

* **Email**: `teuton.software@protonmail.com`

# Contributing

1. Make sure you have Ruby installed
1. Fork it
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create new Pull Request.

You can also [create issues](https://github.com/teuton-software/teuton/issues) with your requests, incidences or suggestions.

> Read [Spanish documentation](docs/es/README.md)
