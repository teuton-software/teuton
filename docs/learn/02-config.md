[<< back](README.md)

# Example: 02-config

* Learn how to use config file.
* Use params defined into config files.
* It's good idea save variable data separated into external config file.

1. [Config file](#config-file).
2. [Definition section](#definition-section).
3. [Execution section](#execution-section).
4. [Results](#results).

## Config file

By default, `config.yaml` is our config file. Let's an example:

```yaml
---
global:
cases:
- tt_members: Student-name-1
  username: root
- tt_members: Student-name-2
  username: vargas
```

## Definition section

By default, `start.rb` it's our main execution file.

```ruby
group "Reading params from config file" do

  target "Create user #{get(:username)}"
  run "id #{get(:username)}"
  expect get(:username)

end
```

In this section we define targets using keywords: target, run, expect and get.

* **get** keyword is used to read params from configuracion file. It's posible personalize tests with diferent values for every case.

> NOTE: In this example, we assume GNU/Linux as localhost's OS.

## Execution section

Main execution block:
```ruby
play do
  show
  export
end
```

Runing this example and see `show` keyword output:

```bash
> teuton run examples/02-config

CASE RESULTS
+------+----------------+-------+-------+
| CASE | MEMBERS        | GRADE | STATE |
| 01   | Student-name-1 | 100.0 | ✔     |
| 02   | Student-name-2 | 0.0   | ?     |
+------+----------------+-------+-------+
```

## Results

Output reports are saved into `var/02-config/` directory. Detail output report is created for every case.

```
var/02-config
├── case-01.txt
├── case-02.txt
├── moodle.csv
└── resume.txt
```

Let's see `export` keyword output for case 01.

```
> more var/02-config/case-01.txt
CONFIGURATION
+-------------+----------------+
| tt_members  | Student-name-1 |
| tt_sequence | false          |
| tt_skip     | false          |
| tt_testname | 02-config      |
| username    | root           |
+-------------+----------------+

GROUPS
- Reading params from config file
    01 (1.0/1.0)
        Description : Create user root
        Command     : id root
        Duration    : 0.002 (local)
        Alterations : find(root) & count
        Expected    : Greater than 0 (String)
        Result      : 1 (Integer)

RESULTS
+--------------+---------------------------+
| case_id      | 01                        |
| start_time   | 2022-12-24 13:33:49 +0000 |
| finish_time  | 2022-12-24 13:33:49 +0000 |
| duration     | 0.001777756               |
| unique_fault | 0                         |
| max_weight   | 1.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 0.0                       |
| fail_counter | 0                         |
| grade        | 100                       |
+--------------+---------------------------+
```

> **How to choose another config file?** Read this [document](../commands/example_run.md#3-choosing-config-file).
