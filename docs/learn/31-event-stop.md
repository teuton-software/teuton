[<<back](../../README.md)

# Event: stop

Sometimes it may be necessary to trigger an action when a specific condition occurs; for this, we can use events.

Events are defined with the following structure:

```ruby
event on: OBJECT, when: CONDITION do
  ACTION
end
```

| Keyword   | Values                          |
| --------- | ------------------------------- |
| OBJECT    | `:last_target`, `all_targets`   |
| CONDITION | `:failed`, `:passed`            |
| ACTION    | `stop`, `scores_to_zero`, `log` |

## Example

In this example, we have 4 targets, all of which will function correctly except for target 3.

```ruby
group "Events: stop" do
  target "Target 1: ok"
  run "id root"
  expect_ok

  target "Target 2: ok"
  run "id root"
  expect_ok

  target "Target 3: fail"
  run "id vader"
  expect_ok

  event on: :last_target, when: :failed do
    stop
  end

  target "Target 4: ok"
  run "id root"
  expect_ok
end
```

An event is defined to trigger the `stop` action when the last target (target 3) fails.

The "stop" action halts the test, setting the number of targets yet to be evaluated to zero, while the rest retain their current assessment.

## Report output

```
$ teuton examples/31-event-stop 
 
 🗹 CASE RESULTS
┌──────┬──────────┬───────┬───────┐
│ CASE │ MEMBERS  │ GRADE │ STATE │
│ 01   │ TOCHANGE │ 50.0  │       │
└──────┴──────────┴───────┴───────┘
```

Process:
* target 1 is Ok.
* target 2 is Ok.
* target 3 fails so the `stop` action is triggered.
* target 4 is not evaluated because test was stopped.

```
$ cat var/31-event-stop/case-01.txt

 ⚒ CONFIGURATION
┌────────────────┬────────────────────────────────────┐
│ tt_config_path │ examples/31-event-stop/config.yaml │
│ tt_members     │ TOCHANGE                           │
│ tt_script_path │ examples/31-event-stop/start.rb    │
│ tt_sequence    │ false                              │
│ tt_skip        │ false                              │
└────────────────┴────────────────────────────────────┘

 🛈 LOGS
   [16:27:43]  INFO| Event[0] triggered because target[3] failed
   [16:27:43]  INFO| Test STOPPED!

 ☰ GROUPS
 ▶ Events: stop
   ✔ 01 (1.0/1.0)   ┌──
        Description │ Target 1: ok
        Command     │ id root
        Output      │ uid=0(root) gid=0(root) grupos=0(root)
        Duration    │ 0.002 (local)
        Alterations │ Read exit code
        Expected    │ 0
        Result      │ 0
   ✔ 02 (1.0/1.0)   ├──
        Description │ Target 2: ok
        Command     │ id root
        Output      │ uid=0(root) gid=0(root) grupos=0(root)
        Duration    │ 0.001 (local)
        Alterations │ Read exit code
        Expected    │ 0
        Result      │ 0
   ✖ 03 (0.0/1.0)   ├──
        Description │ Target 3: fail
        Command     │ id vader
        Output      │ id: «vader»: no existe ese usuario
        Duration    │ 0.002 (local)
        Alterations │ Read exit code
        Expected    │ 0
        Result      │ 1
   ✖ 04 (0.0/1.0)   ├──
        Description │ TEST STOPPED!
        Command     │ 
        Output      │ 
        Duration    │ ? (?)
        Alterations │ 
        Expected    │ 
        Result      │ 
                    └──
 🗹 RESULTS
┌──────────────┬───────────────────────────┐
│ unique_fault │ 0                         │
│ case_id      │ 01                        │
│ start_time   │ 2026-10-30 16:27:43 +0000 │
│ finish_time  │ 2026-10-30 16:27:43 +0000 │
│ duration     │ 0.006686742               │
│ max_weight   │ 4.0                       │
│ good_weight  │ 2.0                       │
│ fail_weight  │ 2.0                       │
│ fail_counter │ 2                         │
│ grade        │ 50                        │
└──────────────┴───────────────────────────┘
```