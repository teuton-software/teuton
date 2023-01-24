[<< back](../README.md)

# set

`set` create new temporaly param value for running configuration.

```ruby
set(:param1, 'value')
```

## Example

```ruby
set(:greet, "Hello")
var = get(:greet)
```
So `var` value is "Hello".
