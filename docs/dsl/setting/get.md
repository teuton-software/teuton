[<< back](../README.md)

1. [Description](#description)
2. [Usage](#usage)
3. [Examples](#examples)

## Description

`get` read param value from configuration file.

## Usage

```ruby
get(PARAM)
```

## Examples

**Reading example**: Suppose we have this `config.yaml` content:

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
set(:greet, "Hello")
var = get(:greet)
```

So `var` value is "Hello".

**Simpler reading example**: Other ways or reading param values:

```ruby
var = greet?
```

So `var` value is "Hello" too. `greet?` is an alias of `get(:greet)`.
