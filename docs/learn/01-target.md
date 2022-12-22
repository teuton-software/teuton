[<< back](README.md)

# Example: 01-target

Let's learn how to create our first target.
A target is a feature you want to measure or check.

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

**Let's see example**: Executing ` teuton run examples/01-target` command.

```bash
CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | anonymous | 100.0 | ✔     |
+------+-----------+-------+-------+
```

## Output reports

**Output directory**: reports created into `var/01-target/` output directory.

```bash
var
└── 01-target
    ├── case-01.txt
    ├── moodle.csv
    └── resume.txt
```

**Let's see example**: Executing `more var/01-target/case-01.txt` command.

```bash
CONFIGURATION
+-------------+-----------+
| tt_members  | anonymous |
| tt_sequence | false     |
| tt_skip     | false     |
| tt_testname | 01-target |
+-------------+-----------+

GROUPS
- Learn about targets
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
| start_time   | 2022-12-24 13:31:28 +0000 |
| finish_time  | 2022-12-24 13:31:28 +0000 |
| duration     | 0.001880141               |
| unique_fault | 0                         |
| max_weight   | 1.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 0.0                       |
| fail_counter | 0                         |
| grade        | 100                       |
+--------------+---------------------------+
```
