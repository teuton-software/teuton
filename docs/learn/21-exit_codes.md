[<< back](README.md)

# Example: exit_codes

`result` stores information from the last command executed by a "run" action. [Offers many functions](../dsl/definition/result.md)) that transforms output data, and also exitcode is captured.

## Example

```ruby
  target "Exist user root"
  run "id root"
  expect_exit 0

  target "No user vader"
  run "id vader"
  expect_exit 1
```
