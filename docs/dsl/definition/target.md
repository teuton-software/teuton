
## Description

`target` instruction is used to begin new target/goal definition, and sets its description.

## Usage

```ruby
target "Write here your description"
```

* Define target description. Use your own words to describe it, so everybody could understand what is going to be measured.
* This text will be shown into reports to help us understand output information easily.

## Alias

`goal` keyword is an alias of `target`. So it's the same:

```ruby
target "Write here your description"
```

or

```ruby
goal "Write here your description"
```

## Weight

By default weight is 1.0, but it's posible specified other value:

```ruby
target "Write here your description", :weight => 2.5
```
