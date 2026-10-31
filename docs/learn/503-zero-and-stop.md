[<<back](../../README.md)

# Event: scores to zero and stop

## Example

In this example, we have 4 targets, all of which will work fine except target 3.

```ruby
group "Events: scores_to_zero and stop" do
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
    stop
  end

  target "Target 4: ok"
  run "id root"
  expect_ok
end
```

An event is defined to trigger the several actions when the last target (target 3) fails: `scores_to_zero` and `stop`.

## Report output

```
$ teutonx examples/33-zero-and-stop 
 
 ☰ CASE RESULTS
┌──────┬──────────┬───────┬───────┐
│ CASE │ MEMBERS  │ GRADE │ STATE │
│ 01   │ TOCHANGE │ 0.0   │ ?     │
└──────┴──────────┴───────┴───────┘
```

Process:
* target 1 is Ok.
* target 2 is Ok.
* target 3 fails so several actions are triggered.
    * `score_to_zero` targets 1-3.
    * `stop`test. 
* target 4 is not evaluated because test was stopped.

```
$ cat var/33-zero-and-stop/case-01.txt 

 ⚒ CONFIGURATION
┌────────────────┬───────────────────────────────────────┐
│ tt_config_path │ examples/33-zero-and-stop/config.yaml │
│ tt_members     │ TOCHANGE                              │
│ tt_script_path │ examples/33-zero-and-stop/start.rb    │
│ tt_sequence    │ false                                 │
│ tt_skip        │ false                                 │
└────────────────┴───────────────────────────────────────┘

 🛈 LOGS
   [17:56:37]  INFO| Event[0] triggerd because target[3] failed
   [17:56:37]  INFO| Scores set to ZERO!
   [17:56:37]  INFO| Test STOPPED!

 ☰ GROUPS
 ▶ Events: scores_to_zero and stop
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
        Duration    │ 0.002 (local)
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
│ start_time   │ 2026-10-30 17:56:37 +0000 │
│ finish_time  │ 2026-10-30 17:56:37 +0000 │
│ duration     │ 0.007089159               │
│ max_weight   │ 4.0                       │
│ good_weight  │ 2.0                       │
│ fail_weight  │ 2.0                       │
│ fail_counter │ 2                         │
│ grade        │ 0                         │
└──────────────┴───────────────────────────┘
```