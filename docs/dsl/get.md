[<< back](../README.md)

# get

`get` reads param value from configuration file.

```ruby
get(PARAM)
```

## Example

**Reading Example**. Suppose we have this `config.yaml` content:

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

Supossing we are **case 01**, then:
* `get(:username)` returns `obiwan`.
* `get(:host1_username)`, returns `root`.

**Writting example**: We also can create new temporal params:

```ruby
set(:name, "Obiwan")
var = get(:name)
```

So `var` value is "Obiwan".

**Simpler reading example**: Other ways or reading param values:

```ruby
var = _name
```

So `var` value is "Obiwan" too. `_name` is an alias of `get(:name)`.
