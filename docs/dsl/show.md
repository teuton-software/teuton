[<< back](../../README.md)

1. [Description](#description)
2. [Usage](#usage)
3. [Parameters](#parameters)

## Description

When all tests are finished, the `show` command displays information on the screen about the final results.

## Usage

```ruby
start do
  show
end
```

or

```ruby
start do
  show verbose: 1
end
```

## Parameters

| Action               | Description                       |
| -------------------- | --------------------------------- |
| `show`               | Same as `show level: 0` (Default) |
| `show verbose: NUMBER` | NUMBER is the value of the verbose level |


| Verbosity level | Description |
| :-------------: | ----------- |
| 0               | No output   |
| 1               | Default output messages |
| 2               | Show hall of fame |
| 3               | Show final values |
| 4               | Show Initial values |
