
## Description

`set` create new temporaly param value for running configuration.

## Usage

```ruby
set(:param1, 'value')
```

## Example

```ruby
set(:new_param, "Hello")
var = get(:new_param)
```
So `var` value will be "Hello".
