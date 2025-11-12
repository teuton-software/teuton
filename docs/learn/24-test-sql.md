[<<back](README.md)

# Test SQL and database content

## Exercise

* Ask students to make a Sqlite Database. 
* Create a table called `characters` with `name` varchar, and `rol` varchar.

Database example:
```
$ sqlite3 examples/24-test-sql/database_01.db

sqlite> .schema characters
CREATE TABLE characters ( name varchar(255), rol varchar(255));

sqlite> select * from characters;
Obiwan|Jedi
```

* Ask students to create SQL queries inside a file. For example: select all Jedi characters.

```
$ cat examples/24-test-sql/query_01.sql

select * from characters where rol='Jedi';
```

## Teuton test

Define targets (start.rb file):

```ruby
group "Test SQL and database content" do
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

Configure params (config.yaml file):

```yaml
---
global:
  folder: examples/24-test-sql
cases:
- tt_members: student_1
  database: database_01.db
  query: query_01.sql
```

## Run test

```
$ teuton examples/24-test-sql                                   

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | student_1 | 100.0 | ✔     |
+------+-----------+-------+-------+
```
