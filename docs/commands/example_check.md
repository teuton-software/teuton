[<< back](README.md)

# Check Teuton Test

| Param            | Description            | Default value |
| ---------------- | ---------------------- | ------------- |
| --no-panelconfig | Show check information | Enabled |
| --panelconfig    | Only show config file recomended content | Disabled |
| --cpath          | Specify path to config file | TEST-FOLDER/config.yaml |
| --cname          | Specify name to config file | config.yaml |

Usage:

```
teuton check PATH-TO-TEST-FOLDER
```

Example:

```bash
❯ teuton check examples/02-target

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
| Runs         | 1     |
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
[WARN] Configfile not found
       /home/david/proy/repos/teuton.d/teuton/examples/02-target/config.yaml
[INFO] Recomended content:
---
:global:
:cases:
- :tt_members: VALUE

Check OK!
```

The check process notifies that
* This test hasn't config file
* and recommends content for our config file. But it isn't necessary for this example.
* Syntax is OK!
