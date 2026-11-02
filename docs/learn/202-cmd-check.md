
[<<back](../../README.md)

# check test

`teuton check DIRPATH` is a command function that checks syntax and show statistics. It is very useful for locating syntax errors in test files.

## Example

```
$ teuton check examples/05-use 

┌─────────────────────────┐
│ USE: external libraries │
└─────────────────────────┘
      1. examples/05-use/lib/users.rb
      2. examples/05-use/lib/network.rb

┌──────────────────────────┐
│ GROUP: Using file: users │
└──────────────────────────┘
(001) target      Create user get(username)
      weight      1.0
      run         'id get(username)' on host1
      expect      ["uid=", "(get(username))", "gid="] (Array)

┌────────────────────────────┐
│ GROUP: Using file: network │
└────────────────────────────┘
(002) target      Update computer name with get(hostname)
      weight      1.0
      run         'hostname' on host1
      expect_one  get(hostname) (String)

(003) target      Ensure DNS is properly configured
      weight      1.0
      run         'host www.google.es' on host1
      expect      www.google.es has address  (String)

┌─────────────┬───────┐
│ DSL Stats   │ Count │
├─────────────┼───────┤
│ Uses        │ 2     │
│ Groups      │ 2     │
│ Targets     │ 3     │
│ Runs        │ 3     │
│  * host1    │ 3     │
│ Gets        │ 5     │
│  * username │ 3     │
│  * hostname │ 2     │
└─────────────┴───────┘
```
