
## Description

`get` read param value from configuration file.

## Usage

```ruby
get(:param1)
```

## Example

Suppose we have this `config.yaml` content:
```yaml
---
:global:
  :host1_username: root
  :host1_password: secret
:cases:
- :tt_members: Obiwan
  :host1_ip: 192.168.1.201
  :host1_hostname: jedis
  :username: obiwan
```

Then:
* `get(:username)` returns `obiwan`.
* `get(:host1_username)`, returns `root`.

We also can create new temporal params:
```ruby
set(:new_param, "Hello")
var = get(:new_param)
```
So `var` value will be "Hello".
