
# TEUTON

[![Gem Version](https://badge.fury.io/rb/teuton.svg)](https://badge.fury.io/rb/teuton)
![GitHub](https://img.shields.io/github/license/dvarrui/teuton)

_Test your infrastructure as code._

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

* Install a specific version: `gem install teuton -v VERSION`. Available versions ([rubygems.org/gems/teuton](https://rubygems.org/gems/teuton/)).
* Update: `gem update teuton`.

# Quickstart

**Create** your test

```
$ cat examples/02-target/start.rb 
group "Learn about targets" do
  target "Create user obiwan", weight: 2
  run "id obiwan"
  expect ["uid=", "(obiwan)", "gid="]

  target "Delete user vader"
  run "id vader"
  expect_fail
end

start do
  show
  export
end
```

**Usage**: `teuton run TESTPATH` command to run test:

```console
$ teuton run examples/02-target
------------------------------------
Started at 2025-12-01 18:14:44 +0000
F.
Finished in 0.005 seconds
------------------------------------
 
CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | anonymous | 33.0  | ?     |
+------+-----------+-------+-------+
```

**Output**: reports saved into `var/TESTPATH` folder.

```
$ tree var 
var
└── 02-target
    ├── case-01.txt
    ├── moodle.csv
    └── resume.txt
```

Consult the generated [output files](examples/02-target/output.d/)

# Features

* Use simple DSL to define your tests: `target`, `run`,`expect` and more.
* Remote devices only require SSH or Telnet service installed.
* Output format: txt, html, json, yaml, markdown, etc.
* Multiplatform.
* [Free Software License](LICENSE).

# Documentation

* [Installation](docs/install/README.md)
* [Using Teuton by commands](docs/commands/README.md)
* [Learning guide](docs/learn/README.md). How to create tests using examples.
* [Test examples](examples). The learning guide is based on these examples.
* [Configuration file](docs/config_file.md)
* [DSL - Language reference](docs/dsl/README.md). DSL used to define tests.
* [Modes of use](docs/modes_of_use.md): Classroom, contest, standalone.
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
