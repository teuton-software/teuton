
[<< back](README.md)

# Example: learn-04-use

Learn how to:
* Organize huge amount of groups/targets into several files.
* Checking Windows OS infrastructure (host1).

> This example is on GitHub repository at `examples/learn-04-use`.

## Tree directory

This example has more files:

```bash
$ tree learn/learn-04-use
learn/learn-04-require
├── config.yaml
├── network.rb
├── README.md
├── start.rb
└── users.rb
```

* `README.md` and `config.yaml` are the same as previous examples.

## Execution (play section)

Previous `start.rb` file is splited in: start.rb, users.rb and network.rb.

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

## Definitions (user section)

> Require Windows OS on remote machine.

Let's see `users.rb` file
```ruby
group "User configuration" do
  target "Exist user <#{get(:username)}>"
  goto   :host1, :exec => "net user"
  expect get(:username)
end

```

## Definitions (network section)

> Require Windows OS on remote machine.

Let's see `network.rb` file:

```ruby
group "Network configuracion" do

  target "Hostname is <#{get(:host1_hostname)}>"
  goto   :host1, :exec => "hostname"
  expect_one get(:host1_hostname)

  target "DNS Server OK"
  goto   :host1, :exec => "nslookup www.nba.es"
  expect "Nombre:"

end
```
