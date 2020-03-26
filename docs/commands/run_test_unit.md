
[<< back](README.md)

# Run Test Unit

Use `teuton run DIRECTORY` command to run a Teuton Test.

This command executes Test from specified directory, and by default, show progress on the screen.

## Help

Run `teuton help run` to show help.

Usage:
* teuton [run] [OPTIONS] DIRECTORY

Options:
* [--export=EXPORT], select output format.
* [--cname=CNAME], select other config file name.
* [--cpath=CPATH], select absolute path to config file.    
* [--case=CASE], select cases to be tested.      

## Usage

| ID | Command              | Descriptiont |
| -- | -------------------- | ------------ |
| 01 | teuton foo           | Run foo/start.rb, with config file foo/config.yaml |
| 02 | teuton run foo      | Run foo/start.rb, with config file foo/config.yaml |
| 03 | ruby teuton foo      | Same as 01 on Windows OS |
| 04 | ruby teuton run foo | Same as 02 on WIndows OS |
| 05 | teuton . | Run ./start.rb with ./config.yaml file |
| 06 | teuton run --export=json foo | Run foo/start.rb and force json format during exporting. Others output formats availables are: txt, colored_text, json, yaml |
| 07 | teuton run --cname=rock foo | Run foo/start.rb with foo/rock.yaml config file |
| 08 | teuton foo/demo42.rb | Run foo/demo42.rb with foo/demo42.yaml config file |
| 08 | teuton run --cpath=starwars/jedi.yaml foo | Run foo/start.rb with starwars/jedi.yaml config file |
| 09 | teuton run --case=6,16 foo | Run foo/start.rb with foo/config.yaml config file but only for case id '06' and '16' |

---

## Example

Running example 01:

```bash
$ teuton examples/learn-01-target

[INFO] ScriptPath => .../teuton.d/teuton/examples/learn-01-target/start.rb
[INFO] ConfigPath => ...uton.d/teuton/examples/learn-01-target/config.yaml
[INFO] TestName   => learn-01-target

==================================
Executing [teuton] (version 2.1.8)
[INFO] Running in parallel (2020-03-26 09:16:27 +0000)
.
[INFO] Duration = 0.004    (2020-03-26 09:16:27 +0000)
==================================

INITIAL CONFIGURATIONS
+---------------+-------------------------------------------------------+
| tt_title      | Executing [teuton] (version 2.1.8)                    |
| tt_scriptname | .../teuton.d/teuton/examples/learn-01-target/start.rb |
| tt_configfile | ...uton.d/teuton/examples/learn-01-target/config.yaml |
| tt_testname   | learn-01-target                                       |
| tt_sequence   | false                                                 |
+---------------+-------------------------------------------------------+

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | anonymous | 100.0 |       |
+------+-----------+-------+-------+

FINAL VALUES
+-------------+---------------------------+
| start_time  | 2020-03-26 09:16:27 +0000 |
| finish_time | 2020-03-26 09:16:27 +0000 |
| duration    | 0.003855361               |
+-------------+---------------------------+
```
