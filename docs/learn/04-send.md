[<< back](README.md)

# Remote hosts

To run test on remote host we have to define them into config file.

Let's see an example with:
* 2 global params.
* 3 cases.
* 4 case params.

```yaml
---
global:
  host1_username: root
  host1_password: profesor
cases:
- tt_members: Darth Maul
  host1_ip: 192.168.1.201
  host1_hostname: siths
  username: maul
- tt_members: R2D2
  host1_ip: 192.168.1.202
  host1_hostname: robots
  username: r2d2
- tt_members: Obiwan Kenobi
  host1_ip: 192.168.1.203
  host1_hostname: jedis
  username: obiwan
```

Every remote host definition require some params:

| Param | Description    | Value |
| ----- | -------------- | ------------- |
| ip    | Remote host IP | |
| port  | Remote host port | 22 is default value |
| username | Remote user account | Not required with public SSH id |
| password | Remote user pasword | Not required with public SSH id |
| protocol | SSH or Telner | SSH is defautl value |
| route | Gateway | Defines host2 used as gateway to reach host |  

## Definition section

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

## Execution section

```ruby
play do
  show
  # export using other output formats
  export format: :txt
  export format: :html
  send copy_to: :host1
end
```

* `show`, show process log on screen.
* `export format: :txt`, create output reports files into `var/learn-03-remote-host/` directory using `txt` format.
* `export format: :html`, create output reports into `var/learn-03-remote-host/` directory using `html` format.

> Several output formats available: txt, colored_text, html, json and yaml.

* `send copy_to: :host1` keyword copy output report into remote machine (host1).

## Screen output

```
CASE RESULTS
+------+---------------+-------+-------+
| CASE | MEMBERS       | GRADE | STATE |
| 01   | Darth Maul    | 0.0   | ?     |
| -    | -             | 0.0   |       |
| 03   | Obiwan Kenobi | 0.0   | ?     |
+------+---------------+-------+-------+

CONN ERRORS
+------+---------------+-------+------------------+
| CASE | MEMBERS       | HOST  | ERROR            |
| 01   | Darth Maul    | host1 | host_unreachable |
| 03   | Obiwan Kenobi | host1 | host_unreachable |
+------+---------------+-------+------------------+
```

## Results

```
var
└── 03-remote-hosts
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
