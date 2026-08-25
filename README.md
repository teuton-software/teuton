
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

# Quickstart

**Create** your test file:

```ruby
# File: examples/02-target/start.rb 
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

**Usage**: Run test with `teuton run TESTPATH`.

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

**Output**: reports saved into `var/TESTNAME` folder.

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

1. Installation
    * [Teuton installation](docs/install/t-node.md)
    * [SSH/Telnet installation](docs/install/s-node.md)
2. Teuton commands
    * [teuton config](docs/commands/config.md): suggest config file.
    * [teuton check](docs/commands/check.md): check test syntax.
    * [teuton help](docs/commands/help.md): show command help.
    * [teuton new](docs/commands/new.md): create new test.
    * [teuton readme](docs/commands/readme.md): generate test documentation.
    * [teuton run](docs/commands/run.md): run test.
3. [Learning guide](docs/learn/README.md). Learn writing your own tests. [Examples](examples).
    * [Create NEW test](docs/learn/01-cmd_new.md)
    * [Evaluate TARGET](docs/learn/02-target.md)
    * [Check REMOTE HOSTS](docs/learn/03-remote_hosts.md)
    * [Read CONFIG file](docs/learn/04-config.md)
    * [Use several files](docs/learn/05-use.md)
    * [CHECK test syntax](docs/learn/06-cmd_check.md)
    * [Target WEIGHT](docs/learn/07-target_weight.md)
    * [UNIQUE values](docs/learn/08-unique_values.md)
    * [SEND report copies to remote hosts](docs/learn/09-send.md)
    * [DEBUG results](docs/learn/10-debug.md)
    * [Export other FORMATS](docs/learn/11-export.md)
    * [PRESERVE old reports](docs/learn/12-preserve.md)
    * [Hide FEEDBACK from reports](docs/learn/13-feedback.md)
    * [MOODLE](docs/learn/14-moodle_id.md)
    * [Build README from test](docs/learn/15-readme.md)
    * [INCLUDE more configuration files](docs/learn/16-include.md)
    * [ALIAS](docs/learn/17-alias.md)
    * [LOG messages](docs/learn/18-log.md)
    * [Don't get params, just read vars](docs/learn/19-read_vars.md)
    * [MACROS](docs/learn/20-macros.md)
    * [Checking exit codes](docs/learn/21-exit_codes.md)
    * [RESULT object](docs/learn/22-result.md)
    * [How to test code](docs/learn/23-test-code.md)
    * [How to test SQL and database](docs/learn/24-test-sql.md)
    * [expect vs result](docs/learn/25-expect-result.md) TODO
    * [EXPECT_SEQUENCE](docs/learn/26-expect_sequence.md)
    * [RUN_SCRIPT](docs/learn/27-run_script.md)
    * [UPLOAD](docs/learn/28-upload.md)
4. [Configuration file](docs/config_file.md)
5. [DSL - Language reference](docs/dsl/README.md). DSL used to define tests.
    * [expect](docs/dsl/expect.md): check run output with expectations.
    * [export](docs/dsl/export.md): save evaluation reports.
    * [get](docs/dsl/get.md): read config params.
    * [group](docs/dsl/group.md): group targets.
    * [play](docs/dsl/play.md): starts main execution.
    * [result](docs/dsl/result.md): contains run output.
    * [run](docs/dsl/run.md): execute command on local/remote host.
    * [send](docs/dsl/send.md): send reports into remote machines.
    * [set](docs/dsl/set.md): write new param.
    * [show](docs/dsl/show.md): show progress on screen.
    * [target](docs/dsl/target.md): define new target.
6. [Modes of use](docs/modes_of_use.md): Classroom, contest, standalone.
7. [Blogs and videos](docs/videos.md)

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
