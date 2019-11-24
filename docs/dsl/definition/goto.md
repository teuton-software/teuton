
## Description

Connect to remote host and executes command. The commadn output is saved into result object.

## Usage

```ruby
goto :host1, :exec => "id fran"
goto :host1, :execute => "id fran"
```

> ADVISE: I know that programers dislike `goto` sentence, but this is diferent. Think of it as english speaker, not as developer.

* This example connect to remote host identified by `host1`. Then we execute the command into it and save the output commadn into result object.
* `host1` is a lbal that identifies specific machine. Host information (ip, username, password, protocol) cames from config file.

## Examples

Execute `id obiwan` comand into remote host `linux1`.
```Ruby
  goto :linux1, :exec => "id obiwan"
  goto :linux1, :execute => "id obiwan"
  goto :linux1, exec: "id obiwan"
  goto :linux1, execute: "id obiwan"
```

Execute `id david` command into `localhost`.

```Ruby
  goto :localhost, :exec => "id david"
  goto :localhost, :execute => "id david"
  run "id david"
```

## Protocol

**SSH connection**

By default, when invoking `goto :host1` sentence, Teuton try to open remote SSH session. This config files examples do the same:

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

**Telnet connection**

If you need to use telnet, then it's necessary specified that into config file. For example:
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

**Localhost**

If our hostname is localhost, or the IP is 127.0.0.X, then Teuton will assume that you want to run your command on local system, and no session is opened. This examples are the same:

```
goto :localhost, :exec => "id david"
```

And

```
run "id david"
```

**SSH to localhost**

> NOTE: Only works on Teuton version >= 2.1.X

If you want to open SSH session to your localhost, then force SSH protocol into your config file, like this:

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
