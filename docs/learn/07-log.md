[<< back](README.md)

# Example: 07-log

Let's learn how to create log messages.

1. [Definition section](#definition-section)
2. [Run test](#execution-section)
3. [Result](#result)

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

**Let's see example**: Content of `var/07-log/case-01.txt` file.

```
CONFIGURATION
+-------------+-----------+
| tt_members  | anonymous |
| tt_sequence | false     |
| tt_skip     | false     |
| tt_testname | 07-log    |
+-------------+-----------+

LOGS
    [13:45:02] : Using log messages...
    [13:45:02] ERROR: Problem detected!

GROUPS
- Learning about log messages
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
| start_time   | 2022-12-24 13:45:02 +0000 |
| finish_time  | 2022-12-24 13:45:02 +0000 |
| duration     | 0.001900685               |
| unique_fault | 0                         |
| max_weight   | 1.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 0.0                       |
| fail_counter | 0                         |
| grade        | 100                       |
+--------------+---------------------------+
```
