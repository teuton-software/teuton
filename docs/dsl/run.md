[<< back](../README.md)

# Run

* [Local execution](#local-run)
* [Remote execution](#remote-run)

# Local run

Execute command on localhost and save output into result object.

```ruby
run "id COMMAND"
```

## Alias

In fact it's the same as doing next:

```ruby
run "COMMAND", on: :localhost
```

```ruby
run "COMMAND", on: 127.0.0.1
```

```ruby
run "COMMAND", on: 'localhost'
```

## Example

```ruby
run "id david"
```

* This instruction execute "id david" command on local machine, and save results into **result** object.
* Local machine is where the `Teuton` program is running.

---
# Remote run

Connect to remote host and executes command. The command output is saved into **result** object.

```ruby
run "COMMAND", on: :hostID
```

* This example connect to remote host identified by `hostID`. Then we execute the command into it and save the output commadn into result object.
* Label `hostID` identifies specific machine. Host information (ip, username, password, protocol) cames from config file.

## Alias

I know that programers dislike `goto` sentence, but this is diferent. Think of it as english speaker, not as developer.

```ruby
on :hostID, run: "COMMAND"
```

```ruby
goto :hostID, :exec => "COMMAND"
```

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
