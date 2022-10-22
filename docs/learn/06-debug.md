
[<< back](README.md)

# Example: 06-debug

Learn how to:
* Check test syntax.
* Debug your tests.

1. [Tree directory](#tree-directory)
2. [Execution section](#execution-section)
3. [Check test](#check-test)
4. [Debug](#debug)

## Tree directory

```bash
$ tree learn/learn-06-debug
example/learn-06-debug
├── config.yaml
├── external.rb
├── internal.rb
├── README.md
└── start.rb
```

## Execution section

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

## Check test

Tests grows and becames huge, with a lot of targets (That isn't a problem). Then, we organize them spliting into several files and invoke `use` keywork from our main rb file to load other files (That's good idea) .

When this happend, sometimes we need to verify or check rb file consistency and syntax, and we will do it with `teuton check PATH/TO/PROJECT/FOLDER`.

Let's see example `teuton check examples/learn-01-target`:

```bash
[INFO] ScriptPath => examples/learn-01-target/start.rb
[INFO] ConfigPath => examples/learn-01-target/config.yaml
[INFO] Pwd        => /mnt/home/leap/proy/repos/teuton.d/teuton
[INFO] TestName   => learn-01-target

+----------------------------+
| GROUP: Learn about targets |
+----------------------------+
(001) target      Create user david
      weight      1.0
      run         'id david' on localhost
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

## Debug

Every time we invoke `run` or `goto` keywork, an OS command is executed. The output is showed on screen and saved into **result** internal object.

We could debug it invoking `result.debug` into our tests. Let's see an example from `external.rb` file:

```ruby
group "Windows: external configuration" do

  target "Localhost: Verify connectivity with #{gett(:windows1_ip)}"
  run    "ping #{get(:windows1_ip)} -c 1"
  result.debug
  expect_one "0% packet loss"
  result.debug

  target "Localhost: netbios-ssn service working on #{gett(:windows1_ip)}"
  run    "nmap -Pn #{get(:windows1_ip)}"
  expect "139/tcp", "open"

end
```

`result.debug` it's usefull when you are verifying command output captured by Teuton.
