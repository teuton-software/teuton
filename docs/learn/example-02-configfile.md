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
group "learn 02 config" do

  target "Create user " + get(:username)
  run "id " + get(:username)
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
 $ teuton learn/learn-02-config
[INFO] ScriptPath => learn/learn-02-config/start.rb
[INFO] ConfigPath => learn/learn-02-config/config.yaml
[INFO] TestName   => learn-02-config
==================================
Executing [teuton] (version 2.0.1)
[INFO] Running in parallel (2019-06-20 11:20:49 +0100)
.id: «darth-maul»: no existe ese usuario
F
[INFO] Duration = 0.008375141 (2019-06-20 11:20:49 +0100)


==================================
INITIAL CONFIGURATIONS
+---------------+------------------------------------------------------------------------------+
| tt_title      | Executing [teuton] (version 2.0.1)                                           |
| tt_scriptname | learn/learn-02-config/start.rb    |
| tt_configfile | learn/learn-02-config/config.yaml |
| tt_testname   | learn-02-config                                              |
| tt_sequence   | false                                                                        |
+---------------+------------------------------------------------------------------------------+
CASE RESULTS
+---------+-------------+----------------+
| Case ID | % Completed | Members        |
| Case_01 | 100%        | Student-name-1 |
| Case_02 |   0% ?      | Student-name-2 |
+---------+-------------+----------------+
FINAL VALUES
+-------------+---------------------------+
| start_time  | 2019-06-20 11:20:49 +0100 |
| finish_time | 2019-06-20 11:20:49 +0100 |
| duration    | 0.008375141               |
+-------------+---------------------------+
HALL OF FAME
+-----+---+
| 100 | * |
| 0   | * |
+-----+---+

```
---

## Results

Output reports are saved into `var/learn-02-config/` directory. Detail output report is created for every case.

```
var/learn-02-config
├── case-01.txt
├── case-02.txt
└── resume.txt
```

Let's see `export` keyword output for case 01.

```
$ more var/learn-02-config/case-01.txt

CONFIGURATIONS
+------------+----------------+
| tt_members | Student-name-1 |
| username   | root           |
| tt_skip    | false          |
+------------+----------------+

TEST
======================
GROUP: learn 02 config
 01 (1.0/1.0)
     Description : Checking user <root>
     Command     : id root
     Duration    : 0.003 (local)
     Alterations : find(root) & count
     Expected    : Greater than 0 (String)
     Result      : 1 (Integer)

RESULTS
+--------------+---------------------------+
| case_id      | 1                         |
| start_time_  | 2019-06-20 12:29:41 +0100 |
| finish_time  | 2019-06-20 12:29:42 +0100 |
| duration     | 0.003650038               |
| unique_fault | 0                         |
| max_weight   | 1.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 0.0                       |
| fail_counter | 0                         |
| grade        | 100                       |
+--------------+---------------------------+
```

---
## Using other config file names

**Default names:**:
By default, when you run `teuton run foo`, this will search for:
* `foo/start.rb` test file and
* `foo/config.yaml` config file.

**Using cname param:**
But it's posible run `teuton run --cname=rock foo`, and choose diferent config file into projet folder:
* `foo/start.rb` test file and
* `foo/rock.yaml` config file.

`cname` param searchs YAML config file into the same project folder.

**Using cpath param:**
An also, it's posible run `teuton run --cpath=/home/david/startwars.yaml foo`, and choose config file using its absolute path:
* `foo/start.rb` test file and
* `/home/david/starwars.yaml` config file.

`cpath` param selects YAML config file, from the specified path.

**Using diferent main rb name:**
When you run `teuton run foo/mazingerz.rb`, this will search for:
* `foo/mazingerz.rb` test file and
* `foo/mazingerz.yaml` config file.
