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
