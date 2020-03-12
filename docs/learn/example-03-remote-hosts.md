
[<< back](README.md)

# Example: learn-03-remote-hosts

Learn how to:
* Check a group of remote hosts.
* Export reports using other output formats.
* Checking remote machine (host1) with Windows OS.

> This example is on GitHub repository at `examples/learn-03-remote-hosts`.

## Config file

`config.yaml` file:

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
group "learn 03 remote hosts" do

  target "Hostname is <#{get(:host1_hostname)}>"
  goto   :host1, :exec => "hostname"
  expect_one get(:host1_hostname)

  target "DNS Server OK"
  goto   :host1, :exec => "nslookup www.google.es"
  expect "Nombre:"

  target "Exist user <#{get(:username)}>"
  goto   :host1, :exec => "net user"
  expect get(:username)

end
```

> Remote machine (host1) OS must be Windows.

## Execution (play section)

```ruby
play do
  show
  # export using other output formats
  export :format => :colored_text
  export :format => :json
  send :copy_to => :host1
end
```

* `show`, show process log on screen.
* `export :format => :json`, create output reports into `var/learn-03-remote-host/` directory. We can use diferents format to export: txt, colored_text, json and yaml.
* `send :copy_to => :host1` keyword copy output report into remote machine (host1).

## Output reports

```
 $ tree var
var
└── learn-03-remote-hosts
    ├── case-01.colored_text
    ├── case-01.json
    ├── case-02.colored_text
    ├── case-02.json
    ├── case-03.colored_text
    ├── case-03.json
    ├── resume.colored_text
    └── resume.json
```

* `case-01`, report with details about case 01 (maul)
* `case-02`, report with details about case 02 (r2d2)
* `case-03`, report with details about case 03 (obiwan)
* `resume`, report with global resumed information about all cases.
