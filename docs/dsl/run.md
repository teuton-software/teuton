[<< back](../README.md)

# Run

* [Local execution](#local-run)
* [Remote execution](#remote-run)

# Local run

Execute command on localhost and save output into result object.

```ruby
run "id COMMAND"
```

Alias:
```ruby
run "COMMAND", on: :localhost
run "COMMAND", on: 127.0.0.1
run "COMMAND", on: 'localhost'
```

* This instruction execute "COMMAND" command on local machine, and save results into **result** object.
* Local machine is where the Teuton program is running.

# Remote run

Connect to remote host and executes command. The command output is saved into **result** object.

```ruby
run "COMMAND", on: :HOSTID
```

* This example connect to remote host identified by `HOSTID`. Then we execute the command into it and save the output commadn into result object.
* Label `HOSTID` identifies specific machine. Host information (ip, username, password, protocol) cames from config file.

**Example**:
```ruby
# Execute `id obiwan` comand into remote host `:tatooine`.
run "id obiwan", on: :tatooine
```

## Protocols

### SSH connection

Invoking `run` sentence, will open SSH session with remote host by default.

**Example 1**. By default, SSH connection is established with remote host:

```yaml
---
:config:
---
:global:
:cases:
- :tt_members: Student1
  :host1_ip: 1.1.1.1
  :host1_username: student
  :host1_password: secret
```

**Example 2**. `host1_protocol: ssh` force SSH connection with remote host:

```yaml
---
:config:
---
:global:
:cases:
- :tt_members: Student1
  :host1_ip: 1.1.1.1
  :host1_username: student
  :host1_password: secret
  :host1_protocol: ssh
```

### Telnet connection

Open Telnet session with remote host.

`host1_protocol: telnet` force Telnet connection with remote host:

```yaml
---
:global:
:cases:
- :tt_members: Student2
  :host1_ip: 2.2.2.2
  :host1_username: student
  :host1_password: secret
  :host1_protocol: telnet
```

### Localhost

When host is "localhost", or `host_ip: 127.0.0.*` , then Teuton will assume that you want to run your command on local system, and no remote session is opened.

Examples:
```
run "id david"
run "id david", on: :localhost
run "id david", on: 'localhost'
```

### SSH to localhost

Force SSH session to localhost.

Iw you need to force SSH connection to localhost, then set param `host1_protocol: ssh`.

Example:
```yaml
---
:global:
:cases:
- :tt_members: Student3
  :host1_ip: 127.0.0.1
  :host1_username: student
  :host1_password: secret
  :host1_protocol: ssh
```
