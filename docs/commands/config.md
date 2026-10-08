[<< back](../../README.md)

# config

_Help to create config file._

Usage:
* `teuton config DIRECTORY`

## Suggest config content

* This is our test file content.

```ruby
# File: examples/03-remote_hosts/start.rb`

group "Remote host" do
  target "Create user root"
  run "id root", on: :host1
  expect ["uid=", "(root)", "gid="]

  target "Delete user vader"
  run "id vader", on: :host1
  expect_fail
end

play do
  show
  export
end
```

* Run `teuton config examples/03-remote_hosts` to suggest config file content:

``` 
---
global:
cases:
- tt_members: TOCHANGE
  host1_ip: TOCHANGE
  host1_username: TOCHANGE
  host1_password: TOCHANGE
```
