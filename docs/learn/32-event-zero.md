[<<back](../../README.md)

# Event: scores to zero

We are going to create an event that triggers when the last target fails, and which sets all the scores for the targets already evaluated to zero.

```ruby
event on: :last_target, when: failed do
  scores_to_zero
end
```

## Example

In this example, we have 4 targets, all of which will function correctly except for target 3.

```ruby
group "Events: scores_to_zero" do
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
    scores_to_zero
  end

  target "Target 4: ok"
  run "id root"
  expect_ok
end
```

The event, before target 3, is defined to trigger the `scores_to_zero` action when target fails.

The action resets the values ​​of all already-evaluated targets to zero.

## Report output

```
$ teuton examples/32-event-zero

 ☰ CASE RESULTS
┌──────┬──────────┬───────┬───────┐
│ CASE │ MEMBERS  │ GRADE │ STATE │
│ 01   │ TOCHANGE │ 25.0  │ ?     │
└──────┴──────────┴───────┴───────┘
```

Process:
* target 1 is Ok.
* target 2 is Ok.
* target 3 fails so the `scores_to_zero` action is triggered. Targets 1 and 2 are reset to zero.
* target 4 is Ok.

```
$ cat var/32-event-zero/case-01.txt

 ⚒ CONFIGURATION
┌────────────────┬────────────────────────────────────┐
│ tt_config_path │ examples/32-event-zero/config.yaml │
│ tt_members     │ TOCHANGE                           │
│ tt_script_path │ examples/32-event-zero/start.rb    │
│ tt_sequence    │ false                              │
│ tt_skip        │ false                              │
└────────────────┴────────────────────────────────────┘

 🛈 LOGS
   [12:44:21]  INFO| Event on: last_target (target 3), when: failed
   [12:44:21]  WARN| Scores READJUSTED!

 ☰ GROUPS
 ▶ Events: scores_to_zero
   ✔ 01 (0.0/1.0)   ┌──
        Description │ Target 1: ok (SCORE TO ZERO)
        Command     │ id root
        Output      │ uid=0(root) gid=0(root) grupos=0(root)
        Duration    │ 0.002 (local)
        Alterations │ Read exit code
        Expected    │ 0
        Result      │ 0
   ✔ 02 (0.0/1.0)   ├──
        Description │ Target 2: ok (SCORE TO ZERO)
        Command     │ id root
        Output      │ uid=0(root) gid=0(root) grupos=0(root)
        Duration    │ 0.001 (local)
        Alterations │ Read exit code
        Expected    │ 0
        Result      │ 0
   ✖ 03 (0.0/1.0)   ├──
        Description │ Target 3: fail (SCORE TO ZERO)
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
│ start_time   │ 2026-10-26 12:44:21 +0000 │
│ finish_time  │ 2026-10-26 12:44:21 +0000 │
│ duration     │ 0.006700903               │
│ max_weight   │ 4.0                       │
│ good_weight  │ 3.0                       │
│ fail_weight  │ 1.0                       │
│ fail_counter │ 1                         │
│ grade        │ 25                        │
└──────────────┴───────────────────────────┘
```