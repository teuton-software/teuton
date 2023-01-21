[<< back](../README.md)

1. [Description](#description)
2. [Usage](#usage)
3. [Example](#example)

## Description

`set` create new temporaly param value for running configuration.

## Usage

```ruby
set(:param1, 'value')
```

## Example

```ruby
set(:greet, "Hello")
var = get(:greet)
```
So `var` value is "Hello".
