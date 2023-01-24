[<< back](README.md)

# use

`use` keyword allow us organize huge amount of groups/targets into several files.

## Example

> This example requires Windows OS on remote machine.

```bash
> tree example/04-use

example/04-require
├── config.yaml
├── network.rb
├── README.md
├── start.rb
└── users.rb
```

`start.rb` file is now splited in: start.rb, users.rb and network.rb.

```ruby
# File: start.rb
use 'users'
use 'network'

play do
  show
  export
end
```

* `use`, indicates that we are using an external file that will be imported into our start.rb file.

> It's a good idea to organize project files, when the number of groups/targets is high.


```ruby
# File: users.rb

group "Use file: User configuration" do

  target "Create user #{gett(:username)}"
  run "net user", on: :host1
  expect get(:username)

end
```

```ruby
# File: network.rb

group "Use file: Network configuracion" do

  target "Update computer name with #{gett(:host1_hostname)}"
  run "hostname", on: :host1
  expect_one get(:host1_hostname)

  target "Ensure DNS Server is working"
  run "nslookup www.google.es", on: :host1
  expect "Nombre:"

end
```
