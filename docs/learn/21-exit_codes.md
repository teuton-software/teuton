[<< back](README.md)

# Example: exit_codes

`result` stores information from the last command executed by a "run" action. [Offers many functions](../dsl/result.md)) that transforms output data, and also exitcode is captured.

## Example 1: ok and fail

```ruby
  target "Exist user root (exit code ok)"
  run "id root"
  expect_exit 0

  target "No user vader (exit code fail)"
  run "id vader"
  expect_exit 1
```

## Example 2: range and array

```ruby
  target "Using a range"
  run "id vader"
  expect_exit 1..3

  target "Using a list"
  run "id vader"
  expect_exit [1, 3, 7]
```
