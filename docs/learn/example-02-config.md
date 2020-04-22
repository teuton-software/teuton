[<< back](README.md)

# Example: learn-02-config

This example is on GitHub repository at `examples/learn-02-config`.

Summary:
* Learn how to use config file.
* Tests use params defined into config files.
* It's good idea save variable data separated into external config file.

## Config file

By default, `config.yaml` is our config file. Let's an example:

```yaml
---
:global:
:cases:
- :tt_members: Student-name-1
  :username: root
- :tt_members: Student-name-2
  :username: vargas
```

## Definitions

By default, `start.rb` it's our main execution file.

```ruby
group "Reading params from config file" do

  target "Create user #{gett(:username)}"
  run "id #{get(:username)}"
  expect get(:username)

end
```

In this section we define targets using keywords: target, run, expect and get.

* **get** keyword is used to read params from configuracion file. It's posible personalize tests with diferent values for every case.

> NOTE: In this example, we assume GNU/Linux as localhost's OS.

## Main execution block

```ruby
play do
  show
  export
end
```

Runing this example and see `show` keyword output:

```bash
> teuton run --no-color examples/learn-02-config
[INFO] ScriptPath => examples/learn-02-config/start.rb
[INFO] ConfigPath => examples/learn-02-config/config.yaml
[INFO] Pwd        => /mnt/home/leap/proy/repos/teuton.d/teuton
[INFO] TestName   => learn-02-config

==================================
Executing [teuton] (version 2.1.9)
[INFO] Running in parallel (2020-04-18 21:46:38 +0100)
id: «vargas»: no existe ese usuario
.F
[INFO] Duration = 0.004    (2020-04-18 21:46:38 +0100)
==================================

INITIAL CONFIGURATIONS
+---------------+-------------------------------------------+
| tt_title      | Executing [teuton] (version 2.1.9)        |
| tt_scriptname | examples/learn-02-config/start.rb         |
| tt_configfile | examples/learn-02-config/config.yaml      |
| tt_pwd        | /mnt/home/leap/proy/repos/teuton.d/teuton |
| tt_testname   | learn-02-config                           |
| tt_sequence   | false                                     |
+---------------+-------------------------------------------+

CASE RESULTS
+------+----------------+-------+-------+
| CASE | MEMBERS        | GRADE | STATE |
| 01   | Student-name-1 | 100.0 |       |
| 02   | Student-name-2 | 0.0   | ?     |
+------+----------------+-------+-------+

FINAL VALUES
+-------------+---------------------------+
| start_time  | 2020-04-18 21:46:38 +0100 |
| finish_time | 2020-04-18 21:46:38 +0100 |
| duration    | 0.003665655               |
+-------------+---------------------------+
```

## Results

Output reports are saved into `var/learn-02-config/` directory. Detail output report is created for every case.

```
var/learn-02-config
├── case-01.txt
├── case-02.txt
├── moodle.csv
└── resume.txt
```

Let's see `export` keyword output for case 01.

```
> more var/learn-02-config/case-01.txt
CONFIGURATION
+-------------+-----------------+
| tt_members  | Student-name-1  |
| tt_sequence | false           |
| tt_skip     | false           |
| tt_testname | learn-02-config |
| username    | root            |
+-------------+-----------------+

GROUPS
- Using config file values
    01 (1.0/1.0)
        Description : Create user root (username)
        Command     : id root
        Duration    : 0.003 (local)
        Alterations : find(root) & count
        Expected    : Greater than 0 (String)
        Result      : 1 (Integer)

RESULTS
+--------------+---------------------------+
| case_id      | 01                        |
| start_time   | 2020-04-18 21:46:38 +0100 |
| finish_time  | 2020-04-18 21:46:38 +0100 |
| duration     | 0.002899065               |
| unique_fault | 0                         |
| max_weight   | 1.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 0.0                       |
| fail_counter | 0                         |
| grade        | 100                       |
+--------------+---------------------------+
```

> **How to choose another config file?** Read this [document](../commands/example_run.md#3-choosing-config-file).
