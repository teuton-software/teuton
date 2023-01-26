[<< back](README.md)

# 18-log

* `log TEXT`, save TEXT into output report.

Example

```ruby
group "Learning about log messages" do
  log "Using log messages."

  target "Create user david"
  run "id david"
  log result.value
  expect "david"

  log "Problem detected!", :error
  log "This is a warning", :warn
  log "Hi, there!", :info
end
```

Content of `var/18-log/case-01.txt` file.

```
CONFIGURATION
+-------------+-----------+
| tt_members  | anonymous |
| tt_sequence | false     |
| tt_skip     | false     |
| tt_testname | 18-log    |
+-------------+-----------+

LOGS
    [09:14:22]  INFO: Using log messages.
    [09:14:22]  INFO: uid=1000(david) gid=1000(david) grupos=495(cdrom),493(disk),487(video),474(wheel),464(wireshark),459(docker),456(vboxusers),1000(david)
    [09:14:22] ERROR: Problem detected!
    [09:14:22] WARN!: This is a warning
    [09:14:22]  INFO: Hi, there!

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
| start_time   | 2023-01-26 09:14:22 +0000 |
| finish_time  | 2023-01-26 09:14:22 +0000 |
| duration     | 0.002012326               |
| unique_fault | 0                         |
| max_weight   | 1.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 0.0                       |
| fail_counter | 0                         |
| grade        | 100                       |
+--------------+---------------------------+
