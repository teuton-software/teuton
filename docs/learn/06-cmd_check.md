
[<< back](README.md)

# check test

Check Teuton check syntax and show statistics.

```
❯ teuton check examples/05-use     

+--------------------------+
| GROUP: Using file: users |
+--------------------------+
(001) target      Create user get(username)
      weight      1.0
      run         'id get(username)' on host1
      expect      ["uid=", "(get(username))", "gid="] (Array)

+----------------------------+
| GROUP: Using file: network |
+----------------------------+
(002) target      Update computer name with get(hostname)
      weight      1.0
      run         'hostname' on host1
      expect_one  get(hostname) (String)

(003) target      Ensure DNS Server is working
      weight      1.0
      run         'host www.google.es' on host1
      expect      www.google.es has address  (String)

+-------------+-------+
| DSL Stats   | Count |
+-------------+-------+
| Uses        | 2     |
| Groups      | 2     |
| Targets     | 3     |
| Runs        | 3     |
|  * host1    | 3     |
| Uniques     | 0     |
| Logs        | 0     |
|             |       |
| Gets        | 5     |
|  * username | 3     |
|  * hostname | 2     |
| Sets        | 0     |
+-------------+-------+
```
