
# Revise Test Unit

## Example 01

Revising Test Unit called `learn\learn-01-target`:

```bash
$ teuton test learn/learn-01-target
[INFO] ScriptPath => /home/david/proy/repos/teuton.d/challenges/learn/learn-01-target/start.rb
[INFO] ConfigPath => /home/david/proy/repos/teuton.d/challenges/learn/learn-01-target/config.yaml
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
[WARN] File /home/david/proy/repos/teuton.d/challenges/learn/learn-01-target/config.yaml not found!
[INFO] Recomended content:
---
:global:
:cases:
- :tt_members: VALUE
```

Notice that this Test Unit hasn't config file, and Teuton suggests us content for our config.file. But it isn't necessary for this example.
