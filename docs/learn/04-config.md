[<< back](README.md)

# config

_It's good idea save dinamic data into config file._

By default, `config.yaml` is our config file. Example:

```yaml
global:
cases:
- tt_members: name_student_1
  username: david
- tt_members: name_student_2
  username: fran
```

> **How to choose another config file?** Read this [document](../commands/example_run.md#3-choosing-config-file).

By default, `start.rb` it's our main execution file. Example:

```ruby
group "Reading params from config file" do

  target "Create user #{get(:username)}"
  run "id #{get(:username)}"
  expect get(:username)

end
```

* [get](../dsl/get.md) keyword read params from configuration file. It's posible personalize tests with diferent values for every case.

## Example

```console
> teuton run examples/04-config

CASE RESULTS
+------+----------------+-------+-------+
| CASE | MEMBERS        | GRADE | STATE |
| 01   | name_student_1 | 100.0 | ✔     |
| 02   | name_student_2 | 0.0   | ?     |
+------+----------------+-------+-------+
```

Reports:

```
var/04-config
├── case-01.txt
├── case-02.txt
├── moodle.csv
└── resume.txt
```

Let's see case 01 report.

```
> more var/04-config/case-01.txt

CONFIGURATION
+-------------+----------------+
| tt_members  | name_student_1 |
| tt_sequence | false          |
| tt_skip     | false          |
| tt_testname | 04-config      |
| username    | david          |
+-------------+----------------+

GROUPS
- Reading params from config file
    01 (1.0/1.0)
        Description : Create user david
        Command     : id david
        Duration    : 0.002 (local)
        Alterations : find(david) & count
        Expected    : Greater than 0 (String)
        Result      : 1 (Integer)

RESULTS
+--------------+---------------------------+
| case_id      | 01                        |
| start_time   | 2023-01-25 20:46:13 +0000 |
| finish_time  | 2023-01-25 20:46:13 +0000 |
| duration     | 0.001778546               |
| unique_fault | 0                         |
| max_weight   | 1.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 0.0                       |
| fail_counter | 0                         |
| grade        | 100                       |
+--------------+---------------------------+```
```

## Using differents configuration files

Example with 3 config files (yaml files):

```
❯ tree examples/04-config

examples/04-config
├── config.yaml
├── rock.yaml
├── start.rb
└── starwars.yaml
```

Usign default config file (`config.yaml`):

```
❯ teuton run examples/04-config

CASE RESULTS
+------+----------------+-------+-------+
| CASE | MEMBERS        | GRADE | STATE |
| 01   | name_student_1 | 100.0 | ✔     |
| 02   | name_student_2 | 0.0   | ?     |
+------+----------------+-------+-------+
```

Using `example/04-config/starwars.yaml`:

```
❯ teuton run --cname=starwars examples/04-config

CASE RESULTS
+------+------------+-------+-------+
| CASE | MEMBERS    | GRADE | STATE |
| 01   | Yoda       | 0.0   | ?     |
| 02   | Darth Maul | 0.0   | ?     |
+------+------------+-------+-------+
```

Using `example/04-config/rock.yaml`:

```
❯ teuton run --cpath=examples/04-config/rock.yaml examples/04-config

CASE RESULTS
+------+------------+-------+-------+
| CASE | MEMBERS    | GRADE | STATE |
| 01   | AC/DC band | 0.0   | ?     |
| 02   | Muse band  | 0.0   | ?     |
+------+------------+-------+-------+
```
