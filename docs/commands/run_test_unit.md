
# Run Test Unit

We use `teuton play` command to run a Test Unit (or challenge).

This command executes challenge (Test Unit) from specified directory. By default, show progress on the screen.

## Help

Run `teuton help play` to see help.

Usage:
* teuton [play] [OPTIONS] DIRECTORY

Options:
* [--export=EXPORT], select output format.
* [--cname=CNAME], select other config file name.
* [--cpath=CPATH], select absolute path to config file.    
* [--case=CASE], select cases to be tested.      

## Usage

| ID | Command              | Descriptiont |
| -- | -------------------- | ------------ |
| 01 | teuton foo           | Run foo/start.rb, with config file foo/config.yaml |
| 02 | teuton play foo      | Run foo/start.rb, with config file foo/config.yaml |
| 03 | ruby teuton foo      | Same as 01 on Windows OS |
| 04 | ruby teuton play foo | Same as 02 on WIndows OS |
| 05 | teuton . | Run ./start.rb with ./config.yaml file |
| 06 | teuton play --export=json foo | Run foo/start.rb and force json format during exporting. Others output formats availables are: txt, colored_text, json, yaml |
| 07 | teuton play --cname=class foo | Run foo/start.rb with foo/class.yaml config file |
| 08 | teuton foo/demo42.rb | Run foo/demo42.rb with foo/demo42.yaml config file |
| 08 | teuton play --cpath=current/class.yaml foo | Run foo/start.rb with current/class.yaml config file |
| 10 | teuton play --case=6,16 foo | Run foo/start.rb with foo/config.yaml config file but only for case id 6 and 16 |

---

## Example

Running example 01:

```bash
$ teuton learn/learn-01-target
[INFO] ScriptPath => /home/david/proy/repos/teuton.d/challenges/learn/learn-01-target/start.rb
[INFO] ConfigPath => /home/david/proy/repos/teuton.d/challenges/learn/learn-01-target/config.yaml
[INFO] TestName   => learn-01-target

==================================
Executing [teuton] (version 2.1.0)
[INFO] Running in parallel (2019-10-04 23:44:19 +0100)
Starting case <anonymous>
* Processing <learn-01-target> .

[INFO] Duration = 0.006568696 (2019-10-04 23:44:19 +0100)
==================================

INITIAL CONFIGURATIONS
+---------------+-------------------------------------------------------+
| tt_title      | Executing [teuton] (version 2.1.0)                    |
| tt_scriptname | ...teuton.d/challenges/learn/learn-01-target/start.rb |
| tt_configfile | ...ton.d/challenges/learn/learn-01-target/config.yaml |
| tt_testname   | learn-01-target                                       |
| tt_sequence   | false                                                 |
+---------------+-------------------------------------------------------+

CASE RESULTS
+---------+-------+-------+-----------+
| CASE ID | GRADE | STATE | MEMBERS   |
| case_01 | 100.0 |       | anonymous |
+---------+-------+-------+-----------+

FINAL VALUES
+-------------+---------------------------+
| start_time  | 2019-10-04 23:44:19 +0100 |
| finish_time | 2019-10-04 23:44:19 +0100 |
| duration    | 0.006568696               |
+-------------+---------------------------+
```
