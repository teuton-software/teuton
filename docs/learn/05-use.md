[<< back](README.md)

# use

`use` keyword allow us organize huge amount of groups/targets into several files.

## Example

> This example requires Windows OS on remote machine.

```bash
❯ tree examples/05-use
examples/05-use
├── lib
│   ├── network.rb
│   └── users.rb
├── config.yaml
└── start.rb
```

* `start.rb` file is now splited into: `start.rb`, `users.rb` and `network.rb`.

```ruby
# File: start.rb
use 'lib/users'
use 'network'

play do
  show
  export
end
```

* `use`, indicates that we require external file, that will be imported into our start.rb file.
* Notice that you can specify relative route `use 'lib/users'`, or only filename `use 'network'`. In the second case, teuton will search a file with that name into project folders.

> It's a good idea to organize project files, when the number of groups/targets is high.

```ruby
# File: users.rb

group "Using file: users" do
  target "Create user #{get(:username)}"
  run "net user", on: :host1
  expect get(:username)
end
```

```ruby
# File: network.rb

group "Using file: network" do
  target "Update computer name with #{get(:hostname)}"
  run "hostname", on: :host1
  expect_one get(:hostname)

  target "Ensure DNS Server is working"
  run "host www.google.es", on: :host1
  expect "www.google.es has address "
end
```
