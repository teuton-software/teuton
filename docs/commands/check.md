[<< back](README.md)

# Check example

Options:

| Param            | Description                              | Default value |
| ---------------- | ---------------------------------------- | ------------- |
| --no-panelconfig | Show check information                   | Enabled       |
| --panelconfig    | Only show config file recomended content | Disabled      |
| --cpath          | Specify path to config file              | PATH/TO/config.yaml |
| --cname          | Specify name to config file              | config.yaml   |

Usage: `teuton check PATH-TO-TEST-FOLDER`

Example:

```
$ teuton check examples/02-target

+----------------------------+
| GROUP: Learn about targets |
+----------------------------+
(001) target      Create user obiwan
      weight      2.0
      run         'id obiwan' on localhost
      expect      ["uid=", "(obiwan)", "gid="] (Array)

(002) target      Delete user vader
      weight      1.0
      run         'id vader' on localhost
      expect_fail

+--------------+-------+
| DSL Stats    | Count |
+--------------+-------+
| Groups       | 1     |
| Targets      | 2     |
| Runs         | 2     |
|  * localhost | 2     |
+--------------+-------+
[WARN] Configfile not found
       .../examples/02-target/config.yaml
[INFO] Recomended content:
---
global:
cases:
- tt_members: VALUE
```

The check process notifies that
* This test hasn't config file
* and recommends content for our config file. But it isn't necessary for this example.
* exit_code 0 = Syntax ok.
* exit code 1 = Syntax ERROR.
