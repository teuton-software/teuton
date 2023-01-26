[<< back](README.md)

# Unique value

* `unique NAME, VALUE` keyword defines unique values.
* All cases that do not comply with this requirement will obtain a score of 0 and it will be reflected in the reports.

Example:

```ruby
# File: lib/unique.rb

group "Unique value: hostname" do
  run "hostname -f", on: :host1

  unique "Host name", result.value
end
```

Cheking test:

```
❯ teuton check examples/08-unique_values

+--------------------------+
| GROUP: Using file: users |
+--------------------------+
(001) target      Create user get(username)
      weight      1.0
      run         'id get(username)' on host1
      expect      get(username) (String)

+----------------------------+
| GROUP: Using file: network |
+----------------------------+
(002) target      Update computer name with get(hostname)
      weight      1.0
      run         'hostname' on host1
      expect_one  get(hostname) (String)

(003) target      Ensure DNS Server is working
      weight      2.0
      run         'host www.google.es' on host1
      expect      www.google.es has address  (String)

+-------------------------------+
| GROUP: Unique value: hostname |
+-------------------------------+
      run         'hostname -f' on host1
    ! Unique      value for <Host name>

+-------------+-------+
| DSL Stats   | Count |
+-------------+-------+
| Groups      | 3     |
| Targets     | 3     |
| Runs        | 4     |
|  * host1    | 4     |
| Uniques     | 1     |
| Logs        | 1     |
|             |       |
| Gets        | 5     |
|  * username | 3     |
|  * hostname | 2     |
| Sets        | 0     |
+-------------+-------+
+----------------------+
| Revising CONFIG file |
+----------------------+
```
