[<< back](README.md)

# debug

`result.debug` is an instrucction used to debug your tests.

## Introduction

Tests grows and becames huge, with a lot of targets (That isn't a problem). Then, we organize them spliting into several files and invoke `use` keywork from our main rb file to load other files (That's good idea).

```
$ tree examples/10-debug

examples/10-debug
├── config.yaml
├── external.rb
├── internal.rb
└── start.rb
```

Sometimes we need to verify or check rb file consistency and syntax, and we will do it with `teuton check DIRPATH`.

## Explication

Every time we invoke `run` keywork, an OS command is executed. The output is showed on screen and saved into **result** internal object.

We could debug it invoking `result.debug` into our tests. Let's see an example from `external.rb` file:

```ruby
# File: external.rb

group "Windows: external configuration from localhost" do

  target "From localhost, check if exist connectivity with #{get(:windows_ip)}"
  run    "ping #{get(:windows_ip)} -c 1"
  result.debug
  expect_one "0% packet loss"
  result.debug

  target "From localhost, check if Netbios-ssn service working on #{get(:windows_ip)}"
  run    "nmap -Pn #{get(:windows_ip)}"
  expect "139/tcp", "open"

end
```

`result.debug` it's usefull when you are verifying command output captured by Teuton.
