[<< back](../../README.md)

1. [Description](#description)
2. [Usage](#usage)
3. [Parameters](#parameters)

## Description

When tests ends, `show` instruction shows on screen information about final results.

## Usage

```ruby
start do
  show
end
```

## Parameters

| Action         | Description                             |
| -------------- | --------------------------------------- |
| `show`         | Same as `show :resume`. Default option. |
| `show :resume` | Show resumed information on screen.     |
| `show :cases`  | Show information from every case on screen.|
| `show :all`    | Same as `show :resume` and `show :details`. |
