
## Description

Connect to remote host and executes command. The command output is saved into **result** object.

## Usage

```ruby
run "id fran", on: :host1
on :host1, run: "id fran"
goto :host1, :exec => "id fran"
goto :host1, :execute => "id fran"
```
> ADVISE: I know that programers dislike `goto` sentence, but this is diferent. Think of it as english speaker, not as developer.

* This example connect to remote host identified by `host1`. Then we execute the command into it and save the output commadn into result object.
* `host1` is a lbal that identifies specific machine. Host information (ip, username, password, protocol) cames from config file.

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

Invoking `run` or `goto` sentence, Teuton opens SSH remote session by default. This config files examples do the same:

Sample 1:
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

Sample 2:
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

For example:
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

**Localhost**: When hostname is localhost, or host IP is 127.0.0.X, then Teuton will assume that you want to run your command on local system, and no session is opened. This examples are the same:

```
run "id david"
```

And

```
goto :localhost, :exec => "id david"
```

**SSH to localhost**: Force SSH session to localhost, then:

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
