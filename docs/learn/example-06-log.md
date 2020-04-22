[<< back](README.md)

1. [Definition section](#definition-section)
2. [Run test](#execution-section)
3. [Result](#result)

# Example: learn-06-log

Let's learn how to create log messages.

> This example is on GitHub repository at `examples/learn-06-log/`.

## Definition section

Test definition section (Group):
```ruby
group "Learning about log messages" do
  log 'Using log messages...'

  target "Create user david"
  run    "id david"
  expect "david"

  log 'Problem detected!', :error
end
```

> In this example, localhost's OS must be GNU/Linux (any other compatible OS) because the command used is `id david`.

## Result

**Let's see example**: Content of `var/learn-06-log/case-01.txt` file.

```bash
CONFIGURATION
+-------------+--------------+
| tt_members  | anonymous    |
| tt_sequence | false        |
| tt_skip     | false        |
| tt_testname | learn-06-log |
+-------------+--------------+

LOGS
    [19:23:20] : Using log messages...
    [19:23:20] ERROR: Problem detected!

GROUPS
- Learning about log messages
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
| start_time   | 2020-04-22 19:23:20 +0100 |
| finish_time  | 2020-04-22 19:23:20 +0100 |
| duration     | 0.003096755               |
| unique_fault | 0                         |
| max_weight   | 1.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 0.0                       |
| fail_counter | 0                         |
| grade        | 100                       |
+--------------+---------------------------+
```
