[<< back](../../README.md)

# show

When all tests are finished, the `show` command displays information on the screen about the final results.

```ruby
play do
  show
end
```

## Verbosity

| Action               | Description                       |
| -------------------- | --------------------------------- |
| `show`               | Same as `show level: 0` (Default) |
| `show verbose: NUMBER` | NUMBER is the value of the verbose level |

```ruby
play do
  show verbose: 1
end
```

| Verbosity level | Description |
| :-------------: | ----------- |
| 0               | No output   |
| 1               | Default output messages |
| 2               | Show hall of fame |
| 3               | Show final values |
| 4               | Show Initial values |
