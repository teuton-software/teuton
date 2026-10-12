[<< back](README.md)

# config

Our tests use config file to write dinamic data into separated file.

By default, `config.yaml` is our config file. Example:

```yaml
global:
  tt_output_dir: var/04-config/default
cases:
- tt_members: student_1
  username: david
- tt_members: student_2
  username: fran
```

> **How to choose another config file?** Read this [document](../commands/run.md#3-choosing-config-file).

By default, `start.rb` it's our main execution file. Example:

```ruby
group "Reading params from config file" do

  target "Create user #{get(:username)}"
  run "id #{get(:username)}"
  expect [ "uid=", "("+get(:username)+")", "gid=" ]

end
```

* [get](../dsl/get.md) keyword read params values from configuration file. It's posible personalize tests with diferent values for every case.

## Example

```
$ teuton run examples/04-config

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | student_1 | 100.0 | ✔     |
| 02   | student_2 | 0.0   | ?     |
+------+-----------+-------+-------+
```

Reports:

```
var/04-config/default
├── case-01.txt
├── case-02.txt
├── moodle.csv
└── resume.txt
```

Let's see case 01 report.

```
$ more var/04-config/default/case-01.txt

CONFIGURATION
+----------------+--------------------------------+
| tt_config_path | examples/04-config/config.yaml |
| tt_members     | student_1                      |
| tt_output_dir  | var/04-config/default          |
| tt_script_path | examples/04-config/start.rb    |
| tt_sequence    | false                          |
| tt_skip        | false                          |
| username       | david                          |
+----------------+--------------------------------+


GROUPS
- Reading params from config file
    01 (1.0/1.0)
        Description : Create user david
        Command     : id david
        Output      : uid=1000(david) gid=1000(david) grupos=1000(david),478(wheel),...
        Duration    : 0.005 (local)
        Alterations : find(uid=) & find((david)) & find(gid=) & count
        Expected    : Greater than 0
        Result      : 1

RESULTS
+--------------+---------------------------+
| unique_fault | 0                         |
| case_id      | 01                        |
| start_time   | 2026-10-10 17:05:22 +0100 |
| finish_time  | 2026-10-10 17:05:22 +0100 |
| duration     | 0.005137538               |
| max_weight   | 1.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 0                         |
| fail_counter | 0                         |
| grade        | 100                       |
+--------------+---------------------------+
```

## Using differents configuration files

Execute the same test but using diferents config files. Config files available:

* config.yaml
* rock.yaml
* starwars.yaml

**Example 1**: Run test usign default config file (`config.yaml`). Output files saved in `tt_output_dir: var/04-config/defautl`.

```
$ teuton run examples/04-config

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | student_1 | 100.0 | ✔     |
| 02   | student_2 | 0.0   | ?     |
+------+-----------+-------+-------+
```

**Example 2**: Run test using `example/04-config/starwars.yaml` config file. Output files saved in `tt_output_dir: var/04-config/starwars`.

```
$ teuton run --cname=starwars examples/04-config

CASE RESULTS
+------+------------+-------+-------+
| CASE | MEMBERS    | GRADE | STATE |
| 01   | Yoda       | 0.0   | ?     |
| 02   | Darth Maul | 0.0   | ?     |
+------+------------+-------+-------+
```

**Example 3**: Run test using `example/04-config/rock.yaml` config file. Output files saved in `tt_output_dir: var/04-config/rock`.

```
$ teuton run --cpath=examples/04-config/rock.yaml examples/04-config

CASE RESULTS
+------+------------+-------+-------+
| CASE | MEMBERS    | GRADE | STATE |
| 01   | AC/DC band | 0.0   | ?     |
| 02   | Muse band  | 0.0   | ?     |
+------+------------+-------+-------+
```
