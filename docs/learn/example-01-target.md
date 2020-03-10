[<< back](README.md)

# Example: learn-01-target

Let's learn how to create our first target.
A target is a feature you want to measure or check.

> This example is on GitHub repository at `examples/learn-01-target/`.

## Definitions (Group section)

```ruby
group "learn-01-target" do

  target "Exist <david> user"
  run "id david"
  expect "david"

end
```

We define targets using these words:
* **target**: Description of the goal to be tested.
* **run**: Execute a command `id david` on localhost machine.
* **expect**: Evaluate if the result contains expected value.

> In this example, localhost's OS must be GNU/Linux (any other compatible OS) because the command used is `id david`.

## Main execution block (Play section)

```ruby
play do
  show
  export
end
```

Runing this example:

```bash
 $ teuton learn/learn-01-target
[INFO] ScriptPath => /home/david/proy/repos/teuton.d/challenges/learn/learn-01-target/start.rb
[INFO] ConfigPath => /home/david/proy/repos/teuton.d/challenges/learn/learn-01-target/config.yaml
[INFO] TestName   => learn-01-target
==================================
Executing [teuton] (version 2.0.0)
[INFO] Running in parallel (2019-06-20 01:37:57 +0100)
.
[INFO] Duration = 0.013580866 (2019-06-20 01:37:58 +0100)


==================================
INITIAL CONFIGURATIONS
+---------------+------------------------------------------------------------------------------+
| tt_title      | Executing [teuton] (version 2.0.0)                                           |
| tt_scriptname | /home/david/proy/repos/teuton.d/challenges/learn/learn-01-target/start.rb    |
| tt_configfile | /home/david/proy/repos/teuton.d/challenges/learn/learn-01-target/config.yaml |
| tt_testname   | learn-01-target                                                              |
| tt_sequence   | false                                                                        |
+---------------+------------------------------------------------------------------------------+
CASE RESULTS
+---------+-------------+-----------+
| Case ID | % Completed | Members   |
| Case_01 | 100%        | anonymous |
+---------+-------------+-----------+
FINAL VALUES
+-------------+---------------------------+
| start_time  | 2019-06-20 01:37:57 +0100 |
| finish_time | 2019-06-20 01:37:58 +0100 |
| duration    | 0.013580866               |
+-------------+---------------------------+
```

## Results

Output reports are saved into `var/learn-01-target/` directory.

```bash
var/learn-01-targets
├── case-01.txt
└── resume.txt
```

Let's see `export` keyword output.

```bash
$ more var/learn-01-target/case-01.txt

CONFIGURATIONS
+------------+-----------+
| tt_members | anonymous |
| tt_skip    | false     |
+------------+-----------+

TEST
======================

GROUP: learn-01-target

  01 (1.0/1.0)
  		Description : Exist <david> user
  		Command     : id david
  		Duration    : 0.004 (local)
  		Alterations : find(david) & count
  		Expected    : Greater than 0 (String)
  		Result      : 1 (Integer)
RESULTS
+--------------+---------------------------+
| case_id      | 1                         |
| start_time_  | 2019-06-20 12:27:50 +0100 |
| finish_time  | 2019-06-20 12:27:50 +0100 |
| duration     | 0.004641837               |
| unique_fault | 0                         |
| max_weight   | 1.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 0.0                       |
| fail_counter | 0                         |
| grade        | 100                       |
+--------------+---------------------------+
```
