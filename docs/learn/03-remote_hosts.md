[<< back](README.md)

# Remote hosts

To run test on remote host we have to define them into config file.

## Example

Let's see an example with:
* 1 global param.
* 3 cases with 3 params.

```yaml
---
global:
  host1_username: root
cases:
- tt_members: student_1
  host1_ip: 192.168.1.201
  host1_password: secret_1
- tt_members: student_2
  host1_ip: 192.168.1.202
  host1_password: secret_2
- tt_members: student_3
  host1_ip: 127.0.0.1
  host1_password: secret_3
```

Every remote host definition require some params:

| Param | Description    | Default value |
| ----- | -------------- | ------------- |
| ip    | Remote host IP | |
| port  | Remote host port | 22 |
| username | Remote user account | Not required with public SSH id |
| password | Remote user pasword | Not required with public SSH id |
| protocol | SSH or Telner | SSH |
| route | Defines host2 used as gateway to reach host | |

## Definition section

Define 1 target (item to be checked):

```ruby
group "Remote hosts" do
  target "Create user david"
  run "id david", on: :host1
  expect [ "uid=", "(david)", "gid=" ]
end
```

> NOTE: This example requires GNU/Linux OS on remote machine (host1).

Execution:

```
$ teuton run examples/03-remote_hosts

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | student_1 | 0.0   | ?     |
| 02   | student_2 | 0.0   | ?     |
| 03   | student_3 | 100.0 | ✔     |
+------+-----------+-------+-------+

CONN ERRORS
+------+-----------+-------+------------------+
| CASE | MEMBERS   | HOST  | ERROR            |
| 01   | student_1 | host1 | host_unreachable |
| 02   | student_2 | host1 | host_unreachable |
+------+-----------+-------+------------------+
```

Notice that case-03 is 100% and conection works. It is running on localhost because has localhost IP (127.0.0.1).

Results:

```
$ tree var/03-remote_hosts

var/03-remote_hosts
├── case-01.txt
├── case-02.txt
├── case-03.txt
├── moodle.csv
└── resume.txt
```

## tt_skip param

To disable a case, add skip param to config file. Example: `tt_skip: true`.
* `tt_skip` it is false by default.
* `tt_skip: false` ignore this case.
* `tt_skip: true`, evaluate this case.
