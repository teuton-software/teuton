[<<back](README.md)

# Test SQL and database

**Example:**

* Ask students to make a Sqlite Database. Create a table called `characters` with `name` varchar, and `rol` varchar.
* Define targets:

```ruby
group "Test SQL and database" do
  database = "#{get(:folder)}/#{get(:database)}"
  query = "#{get(:folder)}/#{get(:query)}"

  target "Database schema"
  run "sqlite3 #{database} '.schema characters'"
  expect "name varchar", "rol varchar"

  target "Query Jedi"
  run "sqlite3 #{database} '.read #{query}'"
  expect "Obiwan", "Jedi"
end
```

* Configure params:

```yaml
---
global:
  folder: examples/24-test-sql
cases:
- tt_members: student_1_name
  database: database_01.db
  query: query_01.sql
```

* Test output:

```
❯ teuton examples/24-test-sql                                   

CASE RESULTS
+------+----------------+-------+-------+
| CASE | MEMBERS        | GRADE | STATE |
| 01   | student_1_name | 100.0 | ✔     |
+------+----------------+-------+-------+
```
