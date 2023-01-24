[<< back](../README.md)

# target

`target` instruction is used to begin every new target and sets its description.

```ruby
target "Write here your description"
```

Describe your targets so everybody could understand what is going to be measured. This text will be shown into reports to help us understand output information easily.

## Weight

By default weight is `1.0`, but it's posible specified other values:

```ruby
target "Write here your description", weight: 2.5
```

## [DEPRECATED] Alias

`goal` keyword is an alias of `target`. So it's the same:

```ruby
target "Write here your description"
```

or

```ruby
goal "Write here your description"
```
