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

> Example files as `examples/504-all-targets`.

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
$ teuton examples/504-all-targets 
  
 ☰ CASE RESULTS
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
$ cat var/504-all-targets/case-01.txt

 ⚒ CONFIGURATION
┌────────────────┬─────────────────────────────────────────────┐
│ tt_config_path │ examples/events/504-all-targets/config.yaml │
│ tt_members     │ TOCHANGE                                    │
│ tt_script_path │ examples/events/504-all-targets/start.rb    │
│ tt_sequence    │ false                                       │
│ tt_skip        │ false                                       │
└────────────────┴─────────────────────────────────────────────┘

 🛈 LOGS
   [16:02:47]  INFO| Event[0] cancelled. Not all targets[1, 3] failed

 ☰ GROUPS
 ▶ All targets event
   ✖ 01 (0.0/1.0)   ┌──
        Description │ Target 1: fail
        Command     │ id vader
        Output      │ id: «vader»: no existe ese usuario
        Duration    │ 0.002 (local)
        Alterations │ Read exit code
        Expected    │ 0
        Result      │ 1
   ✔ 02 (1.0/1.0)   ├──
        Description │ Target 2: ok
        Command     │ id root
        Output      │ uid=0(root) gid=0(root) grupos=0(root)
        Duration    │ 0.002 (local)
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
   ✔ 04 (1.0/1.0)   ├──
        Description │ Target 4: ok
        Command     │ id root
        Output      │ uid=0(root) gid=0(root) grupos=0(root)
        Duration    │ 0.001 (local)
        Alterations │ Read exit code
        Expected    │ 0
        Result      │ 0
                    └──

 🗹 RESULTS
┌──────────────┬───────────────────────────┐
│ unique_fault │ 0                         │
│ case_id      │ 01                        │
│ start_time   │ 2026-10-31 16:02:47 +0000 │
│ finish_time  │ 2026-10-31 16:02:47 +0000 │
│ duration     │ 0.00671773                │
│ max_weight   │ 4.0                       │
│ good_weight  │ 2.0                       │
│ fail_weight  │ 2.0                       │
│ fail_counter │ 2                         │
│ grade        │ 50                        │
└──────────────┴───────────────────────────┘
```