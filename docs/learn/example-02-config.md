[<< back](README.md)

# Example: learn-02-config

* Learn how to use config file.
* Tests use params defined into config files.
* It's good idea save variable data separated into external config file.

> This example is on GitHub repository at `examples/learn-02-config`.

---
## Config file

By default, `config.yaml` is our config file. Let's an example:

```yaml
---
:global:
:cases:
- :tt_members: Student-name-1
  :username: david
- :tt_members: Student-name-2
  :username: fran
```

## Definitions

By default, `start.rb` it's our main execution file.

```ruby
group "Using config file values" do

  target "Create user #{gett(:username)}"
  run "id #{get(:username)}"
  expect get(:username)

end
```

In this section we define targets using keywords: target, run, expect and get.

* **get** keyword is used to read param from configuracion file. It's posible personalize tests separated for every case.

> Localhost's OS must be GNU/Linux (any other compatible OS) because the command used is `id david`.

## Main execution block

```ruby
play do
  show
  export
end
```

Runing this example and see `show` keyword output:

```bash
> teuton run --no-color examples/learn-02-config
[INFO] ScriptPath => examples/learn-02-config/start.rb
[INFO] ConfigPath => examples/learn-02-config/config.yaml
[INFO] Pwd        => /mnt/home/leap/proy/repos/teuton.d/teuton
[INFO] TestName   => learn-02-config

==================================
Executing [teuton] (version 2.1.9)
[INFO] Running in parallel (2020-04-18 21:46:38 +0100)
id: «vargas»: no existe ese usuario
.F
[INFO] Duration = 0.004    (2020-04-18 21:46:38 +0100)
==================================

INITIAL CONFIGURATIONS
+---------------+-------------------------------------------+
| tt_title      | Executing [teuton] (version 2.1.9)        |
| tt_scriptname | examples/learn-02-config/start.rb         |
| tt_configfile | examples/learn-02-config/config.yaml      |
| tt_pwd        | /mnt/home/leap/proy/repos/teuton.d/teuton |
| tt_testname   | learn-02-config                           |
| tt_sequence   | false                                     |
+---------------+-------------------------------------------+

CASE RESULTS
+------+----------------+-------+-------+
| CASE | MEMBERS        | GRADE | STATE |
| 01   | Student-name-1 | 100.0 |       |
| 02   | Student-name-2 | 0.0   | ?     |
+------+----------------+-------+-------+

FINAL VALUES
+-------------+---------------------------+
| start_time  | 2020-04-18 21:46:38 +0100 |
| finish_time | 2020-04-18 21:46:38 +0100 |
| duration    | 0.003665655               |
+-------------+---------------------------+
```
---

## Results

Output reports are saved into `var/learn-02-config/` directory. Detail output report is created for every case.

```
var/learn-02-config
├── case-01.txt
├── case-02.txt
├── moodle.csv
└── resume.txt
```

Let's see `export` keyword output for case 01.

```
> more var/learn-02-config/case-01.txt
CONFIGURATION
+-------------+-----------------+
| tt_members  | Student-name-1  |
| tt_sequence | false           |
| tt_skip     | false           |
| tt_testname | learn-02-config |
| username    | root            |
+-------------+-----------------+

GROUPS
- Using config file values
    01 (1.0/1.0)
        Description : Create user root (username)
        Command     : id root
        Duration    : 0.003 (local)
        Alterations : find(root) & count
        Expected    : Greater than 0 (String)
        Result      : 1 (Integer)

RESULTS
+--------------+---------------------------+
| case_id      | 01                        |
| start_time   | 2020-04-18 21:46:38 +0100 |
| finish_time  | 2020-04-18 21:46:38 +0100 |
| duration     | 0.002899065               |
| unique_fault | 0                         |
| max_weight   | 1.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 0.0                       |
| fail_counter | 0                         |
| grade        | 100                       |
+--------------+---------------------------+
```

---
## Using others config file

**Default names:**:
By default, when you run `teuton run foo`, this will search for:
* `foo/start.rb` test file and
* `foo/config.yaml` config file.

**Using cname param:**
It's posible execute `teuton run --cname=rock foo`, and choose diferent config file into projet folder:
* `foo/start.rb` test file and
* `foo/rock.yaml` config file.

> `cname` param searchs YAML config file into the same project folder.

**Using cpath param:**
An also, it's posible execute `teuton run --cpath=/home/david/startwars.yaml foo`, and choose config file using its absolute path:
* `foo/start.rb` test file and
* `/home/david/starwars.yaml` config file.

> `cpath` param selects YAML config file, from the specified path.

**Using diferent main rb name:**
When you execute `teuton run foo/mazingerz.rb`, this will search for:
* `foo/mazingerz.rb` test file and
* `foo/mazingerz.yaml` config file.
