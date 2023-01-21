[<< back](README.md)

# Check Teuton Test

Objective: Revise Teuton test located into `example\01-target`.

Usage:

```
teuton check examples/01-target
```

Example:

```bash
❯ teuton check examples/01-target

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
[WARN] File .../examples/01-target/config.yaml not found!
[INFO] Recomended content:
---
:global:
:cases:
- :tt_members: VALUE
```

> The check process notifies that this Test Unit hasn't config file, and Teuton recommends content for config file. But it isn't necessary for this example.
