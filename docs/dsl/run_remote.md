[<< back](../README.md)

1. [Description](#description)
2. [Usage](#usage)
3. [Examples](#examples)
4. [Protocol](#protocol)

## Description

Connect to remote host and executes command. The command output is saved into **result** object.

## Usage

```ruby
run "COMMAND", on: :hostID
on :hostID, run: "COMMAND"
goto :hostID, :exec => "COMMAND"
```
> ADVISE: I know that programers dislike `goto` sentence, but this is diferent. Think of it as english speaker, not as developer.

* This example connect to remote host identified by `hostID`. Then we execute the command into it and save the output commadn into result object.
* Label `hostID` identifies specific machine. Host information (ip, username, password, protocol) cames from config file.

## Examples

Execute `id obiwan` comand into remote host `:linux1`.

```Ruby
run "id obiwan", on: :linux1
run "id obiwan", :on => :linux1
on :linux1, run: "id obiwan"
on :linux1, :run => "id obiwan"
goto :linux1, exec: "id obiwan"
goto :linux1, :exec => "id obiwan"
```

Execute `id yoda` command into `localhost`.

```Ruby
run "id yoda"
run "id yoda", on: :localhost
run "id yoda", :on => :localhost
on :localhost, run: "id yoda"
on :localhost, :run => "id yoda"
goto :localhost, :exec => "id yoda"
goto :localhost, :execute => "id yoda"
```

## Protocol

**SSH connection**

Invoking `run` sentence, will open SSH session with remote host by default.
This config files examples do the same:

Sample 1. By default, SSH connection is established with remote host:

```
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

Sample 2. `host1_protocol: ssh` force SSH connection with remote host:

```
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

**Telnet connection**: Open Telnet remote session.

`host1_protocol: telnet` force Telnet connection with remote host:

```
---
:global:
:cases:
- :tt_members: Student2
  :host1_ip: 2.2.2.2
  :host1_username: student
  :host1_password: secret
  :host1_protocol: telnet
```

**Localhost**: When hostname value is "localhost", or host IP is "127.0.0.X", then
Teuton will assume that you want to run your command on local system, and no remote session is opened.
This examples are the same:

```
run "id david"
```

And

```
goto :localhost, :exec => "id david"
```

**SSH to localhost**: Force SSH session to localhost:

```
---
:global:
:cases:
- :tt_members: Student3
  :host1_ip: 127.0.0.1
  :host1_username: student
  :host1_password: secret
  :host1_protocol: ssh
```
