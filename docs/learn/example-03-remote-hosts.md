
[<< back](README.md)

# Example: learn-03-remote-hosts

This example is on GitHub repository at `examples/learn-03-remote-hosts`.

Summary:
* Check a group of remote hosts.
* Export reports using other output formats.
* Checking remote machine (host1) with Windows OS.

## Config file

This configuration file contains:
* 2 global params denitions.
* 3 cases.
* 4 specific case params definitions.

```yaml
---
:global:
  :host1_username: root
  :host1_password: profesor
:cases:
- :tt_members: Darth Maul
  :host1_ip: 192.168.1.201
  :host1_hostname: siths
  :username: maul
- :tt_members: R2D2
  :host1_ip: 192.168.1.202
  :host1_hostname: robots
  :username: r2d2
- :tt_members: Obiwan Kenobi
  :host1_ip: 192.168.1.203
  :host1_hostname: jedis
  :username: obiwan
```

## Definitions (group section)

Define 3 targets (items to be checked):

```ruby
group "How to test remote Windows hosts" do

  target "Update hostname with #{gett(:host1_hostname)}"
  run "hostname", on: :host1
  expect_one get(:host1_hostname)

  target "Ensure network DNS configuration is working"
  run "nslookup www.google.es", on: :host1
  expect "Nombre:"

  target "Create user #{gett(:username)}"
  run "net user", on: :host1
  expect get(:username)

end
```

> NOTE: This example requires Windows OS on remote machine (host1).

## Execution (play section)

```ruby
play do
  show
  # export using other output formats
  export :format => :txt
  export :format => :json
  send :copy_to => :host1
end
```

* `show`, show process log on screen.
* `export :format => :json`, create output reports into `var/learn-03-remote-host/` directory. We can use diferents format to export: txt, colored_text, json and yaml.
* `send :copy_to => :host1` keyword copy output report into remote machine (host1).

## Output reports

```
var
└── learn-03-remote-hosts
    ├── case-01.json
    ├── case-01.txt
    ├── case-03.json
    ├── case-03.txt
    ├── moodle.csv
    ├── resume.json
    └── resume.txt
```

* `case-01`, report with details about case 01 (maul)
* Case 02 (r2ds) is skipped. So there are no report `case-02`.
* `case-03`, report with details about case 03 (obiwan)
* `resume`, report with global resumed information about all cases.
* `moodle.csv`, CVS file with required fields to upload grades into Moodle eLearning platform.
