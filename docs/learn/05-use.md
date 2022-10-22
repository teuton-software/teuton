[<< back](README.md)

# Example: 05-use

Learn how to:
* Organize huge amount of groups/targets into several files.
* Checking Windows OS infrastructure (host1).

1. [Tree directory](#tree-directory)
2. [Execution section](#execution-section)
3. [Users file](#users-file)
4. [Network file](#network-file)

## Tree directory

This example has more files:

```bash
$ tree example/learn-04-use
example/learn-04-require
├── config.yaml
├── network.rb
├── README.md
├── start.rb
└── users.rb
```

* `README.md` and `config.yaml` are the same as previous example.

## Execution section

Previous `start.rb` file is now splited in: start.rb, users.rb and network.rb.

Let's see current `start.rb` file:

```ruby
use 'users'
use 'network'

play do
  show
  export
end
```

* `use`, indicates external rb file that will be included/imported into main rb file. It's a good idea to organize project files, when the number of groups/targets is high.

## Users file

> Require Windows OS on remote machine.

Let's see `users.rb` file

```ruby
group "Use file: User configuration" do

  target "Create user #{gett(:username)}"
  run "net user", on: :host1
  expect get(:username)

end
```

## Network file

> Require Windows OS on remote machine.

Let's see `network.rb` file:

```ruby
group "Use file: Network configuracion" do

  target "Update computer name with #{gett(:host1_hostname)}"
  run "hostname", on: :host1
  expect_one get(:host1_hostname)

  target "Ensure DNS Server is working"
  run "nslookup www.google.es", on: :host1
  expect "Nombre:"

end
```
