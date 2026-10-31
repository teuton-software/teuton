[<<back](../../README.md)

# Target

A [target](../dsl/target.md) is a feature you want to check. Targets are defined into `group` sections.

## Target definition

Every evaluation has 3 parts:
* [target](dsl/target.md): Description of the element to be tested.
* [run](../dsl/run.md): Execute a command on local or remote host.
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

> In this example, our localhost's OS is GNU/Linux (or any other compatible OS), so the command executed is `id obiwan`.

When the user exists, we expect this words: `uid=, (obiwan), gid=`.

```
$ id obiwan
uid=1000(obiwan) gid=1000(obiwan) grupos=1000(obiwan)
```

But when user does not exist, we expect command fail.

```
$ id vader
id: «vader»: no such user

>$ echo $?
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

```
$ teuton examples/102-target       
 
 ☰ CASE RESULTS
┌──────┬───────────┬───────┬───────┐
│ CASE │ MEMBERS   │ GRADE │ STATE │
│ 01   │ anonymous │ 67.0  │       │
└──────┴───────────┴───────┴───────┘
```

Report files are created into `var/102-target/` folder:

```
var
└── 102-target
    ├── case-01.txt
    ├── moodle.csv
    └── resume.txt
```

Let's see one report:

```
$ cat var/102-target/case-01.txt 

 ⚒ CONFIGURATION
┌────────────────┬─────────────────────────────────┐
│ tt_config_path │ examples/102-target/config.yaml │
│ tt_members     │ anonymous                       │
│ tt_script_path │ examples/102-target/start.rb    │
│ tt_sequence    │ false                           │
│ tt_skip        │ false                           │
└────────────────┴─────────────────────────────────┘

 ☰ GROUPS
 ▶ Practicing targets
   ✖ 01 (0.0/1.0)   ┌──
        Description │ Create user obiwan
        Command     │ id obiwan
        Output      │ id: «obiwan»: no existe ese usuario
        Duration    │ 0.002 (local)
        Alterations │ find(uid=) & find((obiwan)) & find(gid=) & count
        Expected    │ Greater than 0
        Result      │ 0
   ✔ 02 (2.0/2.0)   ├──
        Description │ Delete user vader
        Command     │ id vader
        Output      │ id: «vader»: no existe ese usuario
        Duration    │ 0.002 (local)
        Alterations │ Read exit code
        Expected    │ Greater than 0
        Result      │ 1
                    └──
 🗹 RESULTS
┌──────────────┬───────────────────────────┐
│ unique_fault │ 0                         │
│ case_id      │ 01                        │
│ start_time   │ 2026-10-26 12:20:01 +0000 │
│ finish_time  │ 2026-10-26 12:20:01 +0000 │
│ duration     │ 0.003806668               │
│ max_weight   │ 3.0                       │
│ good_weight  │ 2.0                       │
│ fail_weight  │ 1.0                       │
│ fail_counter │ 1                         │
│ grade        │ 67                        │
└──────────────┴───────────────────────────┘
```