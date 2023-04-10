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
  expect ["uid=", "(david)", "gid="]

  target "Delete user vader"
  run "id vader"
  expect ["id:", "vader", "no exist"]

end
```

> In this example, our localhost's OS is GNU/Linux (or any other compatible OS) because the command executed is `id david`.

When the user exists, we expect this words: `uid=, (david), gid=`.

```
❯ id david
uid=1000(david) gid=1000(david) grupos=1000(david)
```

But when user does not exist, we expect different words: `id:, vader, no exist`.

```
❯ id vader
id: «vader»: no existe ese usuario
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
    01 (1.0/1.0)
        Description : Create user david
        Command     : id david
        Duration    : 0.002 (local)
        Alterations : find(uid=) & find((david)) & find(gid=) & count
        Expected    : Greater than 0 (String)
        Result      : 1 (Integer)
    02 (1.0/1.0)
        Description : Delete user vader
        Command     : id vader
        Duration    : 0.002 (local)
        Alterations : find(id:) & find(vader) & find(no exist) & count
        Expected    : Greater than 0 (String)
        Result      : 1 (Integer)

RESULTS
+--------------+---------------------------+
| case_id      | 01                        |
| start_time   | 2023-04-10 09:09:30 +0100 |
| finish_time  | 2023-04-10 09:09:30 +0100 |
| duration     | 0.003863242               |
| unique_fault | 0                         |
| max_weight   | 2.0                       |
| good_weight  | 2.0                       |
| fail_weight  | 0.0                       |
| fail_counter | 0                         |
| grade        | 100                       |
+--------------+---------------------------+
```
