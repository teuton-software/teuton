[<< back](README.md)

# target

A [target](../dsl/target.md) is a feature you want to check. Targets are defined into `group` sections and every evaluation has 3 parts:

## Target definition

* [target](dsl/target.md): Description of the element to be tested.
* [run](../dsl/run.md): Execute a command `id david` on localhost.
* [expect](../&dsl/expect.md): Verify that the result contains expected value.

```ruby
group "Learn about targets" do

  target "Create user david"
  run "id david"
  expect "david"

end
```

> In this example, our localhost's OS is GNU/Linux (or any other compatible OS) because the command executed is `id david`.

## Execution section

When we run this teuton test, the execution section (`play`) is processed. This seccion now contains this:

* [show](../dsl/show.md): display process information on screen.
* [export](../dsl/export.md): build output reports.

```ruby
play do
  show
  export
end
```

## Example

Execute this command to run the test:

```console
> teuton run examples/01-target

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | anonymous | 100.0 | ✔     |
+------+-----------+-------+-------+
```

Report files are created into `var/02-target/` folder:

```console
var
└── 01-target
    ├── case-01.txt
    ├── moodle.csv
    └── resume.txt
```

Let's see one report:

```
> more var/02-target/case-01.txt

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
