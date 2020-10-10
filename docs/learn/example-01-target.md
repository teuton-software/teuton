[<< back](README.md)

# Example: learn-01-target

Let's learn how to create our first target.
A target is a feature you want to measure or check.

> This example is on GitHub repository at `examples/learn-01-target/`.

1. [Definition section](#definition-section)
2. [Execution section](#execution-section)
3. [Run test](#run-test)
4. [Output reports](#output-reports)

## Definition section

Test definition section (Group):
```ruby
group "Learn about targets" do

  target "Create user david"
  run "id david"
  expect "david"

end
```

Define targets using these lines:
* **target**: Description of the element to be tested.
* **run**: Execute a command `id david` on localhost.
* **expect**: Ensure the result contains expected value.

> In this example, localhost's OS must be GNU/Linux (any other compatible OS) because the command used is `id david`.

## Execution section

Test execution section (Play):

```ruby
play do
  show
  export
end
```

DSL keywords:
* **show**: display process information on screen.
* **export**: build output reports.

## Run test

**Let's see example**: Executing ` teuton run examples/learn-01-target` command.

```bash
[INFO] ScriptPath => examples/learn-01-target/start.rb
[INFO] ConfigPath => examples/learn-01-target/config.yaml
[INFO] Pwd        => /mnt/home/leap/proy/repos/teuton.d/teuton
[INFO] TestName   => learn-01-target

==================================
Executing [teuton] (version 2.1.9)
[INFO] Running in parallel (2020-04-18 21:32:16 +0100)
.
[INFO] Duration = 0.003    (2020-04-18 21:32:16 +0100)
==================================

INITIAL CONFIGURATIONS
+---------------+-------------------------------------------+
| tt_title      | Executing [teuton] (version 2.1.9)        |
| tt_scriptname | examples/learn-01-target/start.rb         |
| tt_configfile | examples/learn-01-target/config.yaml      |
| tt_pwd        | /mnt/home/leap/proy/repos/teuton.d/teuton |
| tt_testname   | learn-01-target                           |
| tt_sequence   | false                                     |
+---------------+-------------------------------------------+

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | anonymous | 100.0 |       |
+------+-----------+-------+-------+

FINAL VALUES
+-------------+---------------------------+
| start_time  | 2020-04-18 21:32:16 +0100 |
| finish_time | 2020-04-18 21:32:16 +0100 |
| duration    | 0.003310235               |
+-------------+---------------------------+
```

## Output reports

**Output directory**: reports created into `var/learn-01-target/` output directory.

```bash
var
└── learn-01-target
    ├── case-01.txt
    ├── moodle.csv
    └── resume.txt
```

**Let's see example**: Executing `more var/learn-01-target/case-01.txt` command.

```bash
CONFIGURATION
+-------------+-----------------+
| tt_members  | anonymous       |
| tt_sequence | false           |
| tt_skip     | false           |
| tt_testname | learn-01-target |
+-------------+-----------------+

GROUPS
- Learn about targets
    01 (1.0/1.0)
        Description : Create user david
        Command     : id david
        Duration    : 0.003 (local)
        Alterations : find(david) & count
        Expected    : Greater than 0 (String)
        Result      : 1 (Integer)

RESULTS
+--------------+---------------------------+
| case_id      | 01                        |
| start_time   | 2020-04-18 21:32:16 +0100 |
| finish_time  | 2020-04-18 21:32:16 +0100 |
| duration     | 0.002835857               |
| unique_fault | 0                         |
| max_weight   | 1.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 0.0                       |
| fail_counter | 0                         |
| grade        | 100                       |
+--------------+---------------------------+
```
