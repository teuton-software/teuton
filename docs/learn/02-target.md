[<< back](README.md)

# target

A [target](../dsl/target.md) is a feature you want to check. Targets are defined into `group` sections and every evaluation has 3 parts:

## Target definition

* [target](dsl/target.md): Description of the element to be tested.
* [run](../dsl/run.md): Execute a command `id obiwan` on localhost.
* [expect](../dsl/expect.md): Verify that the result contains expected value.

```ruby
group "Learn about targets" do

  target "Exist user obiwan"
  run "id obiwan"
  expect ["uid=", "(obiwan)", "gid="]

  target "Delete user vader"
  run "id vader"
  expect_fail
end
```

> In this example, our localhost's OS is GNU/Linux (or any other compatible OS) because the command executed is `id obiwan`.

When the user exists, we expect this words: `uid=, (obiwan), gid=`.

```
> id obiwan
uid=1000(obiwan) gid=1000(obiwan) grupos=1000(obiwan)
```

But when user does not exist, we expect different words: `id:, vader, no exist`.

```
> id vader
id: «vader»: no such user

> echo $?
1

```

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
> teuton run examples/02-target

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | anonymous | 100.0 | ✔     |
+------+-----------+-------+-------+
```

Report files are created into `var/02-target/` folder:

```console
var
└── 02-target
    ├── case-01.txt
    ├── moodle.csv
    └── resume.txt
```

Let's see one report:

```
❯ cat var/02-target/case-01.txt
CONFIGURATION
+-------------+-----------+
| tt_members  | anonymous |
| tt_sequence | false     |
| tt_skip     | false     |
| tt_testname | 02-target |
+-------------+-----------+


GROUPS
- Learn about targets
    01 (0.0/1.0)
        Description : Create user obiwan
        Command     : id obiwan
        Output      : id: «obiwan»: no existe ese usuario
        Duration    : 0.002 (local)
        Alterations : find(uid=) & find((obiwan)) & find(gid=) & count
        Expected    : Greater than 0
        Result      : 0
    02 (1.0/1.0)
        Description : Delete user vader
        Command     : id vader
        Output      : id: «vader»: no existe ese usuario
        Duration    : 0.002 (local)
        Alterations : Read exit code
        Expected    : Greater than 0
        Result      : 1

RESULTS
+--------------+---------------------------+
| case_id      | 01                        |
| start_time   | 2023-06-16 08:42:13 +0100 |
| finish_time  | 2023-06-16 08:42:13 +0100 |
| duration     | 0.004527443               |
| unique_fault | 0                         |
| max_weight   | 2.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 1.0                       |
| fail_counter | 1                         |
| grade        | 50                        |
+--------------+---------------------------+
```
