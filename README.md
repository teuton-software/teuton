
# TEUTON

[![Gem Version](https://badge.fury.io/rb/teuton.svg?icon=si%3Arubygems)](https://badge.fury.io/rb/teuton)
![GitHub](https://img.shields.io/github/license/dvarrui/teuton)

_Test your infrastructure as code._ 

![logo](./docs/images/logo-v3-128x128.png)

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
group "Practicing targets" do
  target "Create user obiwan"
  run "id obiwan"
  expect ["uid=", "(obiwan)", "gid="]

  target "Delete user vader", weight: 2
  run "id vader"
  expect_fail
end

play do
  show
  export
end
```

**Usage**: Run test with `teuton run TESTPATH`.

```console
$ teutonx examples/02-target 
 
 CASE RESULTS
┌──────┬───────────┬───────┬───────┐
│ CASE │ MEMBERS   │ GRADE │ STATE │
│ 01   │ anonymous │ 33.0  │ ?     │
└──────┴───────────┴───────┴───────┘
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
    * [teuton doc](docs/commands/doc.md): generate test documentation.
    * [teuton help](docs/commands/help.md): show command help.
    * [teuton new](docs/commands/new.md): create new test.
    * [teuton run](docs/commands/run.md): run test.
3. Learning guide with [examples](examples).
    * Basic
        * [Create NEW test](docs/learn/101-cmd_new.md)
        * [Evaluate TARGET](docs/learn/102-target.md)
        * [Check REMOTE HOSTS](docs/learn/103-remote_hosts.md)
        * [Read CONFIG file](docs/learn/104-config.md)
        * [Target WEIGHT](docs/learn/105-target_weight.md)
        * [SEND report copies to remote hosts](docs/learn/106-send.md)
    * Medium
        * [USE several files](docs/learn/201-use.md)
        * [CHECK test syntax](docs/learn/202-cmd-check.md)
        * [DEBUG results](docs/learn/203-debug.md)
        * [UNIQUE values](docs/learn/204-unique-values.md)
        * [INCLUDE more configuration files](docs/learn/205-include.md)
        * Zero weight target
        * Negative weight target
    * Output: reports, logs and docs.
        * [LOG messages](docs/learn/301-log.md)
        * [Export other FORMATS](docs/learn/302-export.md)
        * [Build DOC from test](docs/learn/303-doc.md)
        * [PRESERVE old reports](docs/learn/304-preserve.md)
        * [Hide FEEDBACK from reports](docs/learn/305-feedback.md)
        * [MOODLE](docs/learn/306-moodle_id.md)
    * Execution: Runs, expects, etc
        * [Checking exit codes](docs/learn/401-exit_codes.md)
        * [RESULT object](docs/learn/402-result.md)
        * [expect vs result](docs/learn/403-expect-result.md)
        * [EXPECT_SEQUENCE](docs/learn/404-expect_sequence.md)
        * [RUN_SCRIPT](docs/learn/405-run-script.md)
        * [UPLOAD](docs/learn/406-upload.md)
    * Events
        * [EVENT stop](docs/learn/501-stop-test.md)
        * [EVENT scores to zero](docs/learn/502-scores-to-zero.md)
        * [EVENT zero and stop](./docs/learn/503-zero-and-stop.md)
        * [EVENT all targets](./docs/learn/504-all-targets.md)
    * Tutorials
        * [How to test code](docs/learn/601-test-code.md)
        * [How to test SQL and database](docs/learn/602-test-sql.md)
    * Experimental
        * [Don't get params, just read vars](docs/learn/701-read-vars.md)
        * [ALIAS](docs/learn/702-alias.md)
        * [MACROS](docs/learn/703-macros.md)
4. [Configuration file](docs/config_file.md): Reserved params, configure hosts, etc.
5. [Language reference](docs/dsl/README.md). DSL used to define tests.
    * [expect](docs/dsl/expect.md): check run output with expectations.
    * [export](docs/dsl/export.md): save evaluation reports.
    * [event](docs/dsl/event.md): execute action when conditions are met.
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
7. [More information](docs/more.md)

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
