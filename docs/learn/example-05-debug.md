
[<< back](README.md)

# Example: learn-05-debug

Learn how to:
* Check test syntax.
* Debug your tests.

> This example is on GitHub repository at `examples/learn-05-debug`.

## Tree directory

```bash
$ tree learn/learn-05-debug
learn/learn-05-debug
├── config.yaml
├── external.rb
├── internal.rb
├── README.md
└── start.rb
```

## Execution (play section)

The `start.rb`  is main execution rb file, and uses `external` and `internal` rb files.

Let's see current `start.rb` file:

```ruby
use 'external'
use 'internal'

play do
  show
  export :format => :colored_text
end
```

## Debugging: Testing rb files

Tests grows and becames huge, with a lot of targets (That isn't a problem). Then, we organize them spliting into several files and invoke `use` keywork from our main rb file to load other files (That's good idea) .

When this happend, sometimes we need to verify or check rb file consistency and syntax, and we will do it with `teuton check PATH/TO/PROJECT/FOLDER`. Let's see an example:

```bash
teuton check examples/learn-01-target
[INFO] ScriptPath => .../teuton.d/teuton/examples/learn-01-target/start.rb
[INFO] ConfigPath => ...uton.d/teuton/examples/learn-01-target/config.yaml
[INFO] TestName   => learn-01-target

+------------------------+
| GROUP: learn-01-target |
+------------------------+
(001) target      Create user <david>
      weight      1.0
      goto        localhost and {:exec=>"id david"}
      expect      david (String)

+--------------+-------+
| DSL Stats    | Count |
+--------------+-------+
| Groups       | 1     |
| Targets      | 1     |
| Goto         | 1     |
|  * localhost | 1     |
| Uniques      | 0     |
| Logs         | 0     |
|              |       |
| Gets         | 0     |
| Sets         | 0     |
+--------------+-------+
+----------------------+
| Revising CONFIG file |
+----------------------+
[WARN] File ./examples/learn-01-target/config.yaml not found!
[INFO] Recomended content:
---
:global:
:cases:
- :tt_members: VALUE
```

In this case, Teuton detects that there isn't exist config file, and propose us content for `config.yaml`.

## Debugging: Result content

Every time we invoke `goto` or `run` keywork, an OS command is executed and the output showed on screen is captured by Teuton and saved into `result` internal object.

We could debug it invoking `result.debug` into our rb file. Let's see an example from `external.rb.rb` file:

```ruby
group "Windows: external configuration" do

  target "Localhost: Verify connectivity with #{gett(:windows1_ip)}"
  run "ping #{get(:windows1_ip)} -c 1"
  result.debug
  expect_one "0% packet loss"
  result.debug

  target "Localhost: netbios-ssn service working on #{gett(:windows1_ip)}"
  run "nmap -Pn #{get(:windows1_ip)}"
  expect "139/tcp", "open"

end
```

`result.debug` it's usefull when you are verifying command output captured by Teuton.
