[<< back](../README.md)

# get

`get(PARAM)` keyword reads param value from configuration file.

## Example 1: reading params

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

Supossing we are **case 01**, then:
* `get(:username)` returns `obiwan`.
* `get(:host1_username)`, returns `root`.

## Example 2: writting and reading params

We also can create new temporal params:

```ruby
set(:name, "Obiwan")
jediname = get(:name)
```

So `jediname` value is "Obiwan".

## Example 3: reading alias

Other ways or reading param values:

```ruby
jediname = _name
```

So `jediname` value is "Obiwan" too. `_name` is an alias of `get(:name)`.
