
## Description

When tests ends, `show` instruction shows on screen information about final results.

## Usage

```ruby
start do
    show
end
```

## Other uses

| Action          | Description                             |
| --------------- | --------------------------------------- |
| `show`          | Same as `show :resume`. Default option. |
| `show :resume`  | Show resumed information on screen.     |
| `show :details` | Show details from every cases on screen.|
| `show :all`     | Same as `show :resume` and `show :details`. |
