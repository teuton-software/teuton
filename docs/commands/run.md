
[<< back](../../README.md)

# Run test

Run test located into DIRPATH folder.

Usage: `teuton run DIRPATH`

Alias: `teuton foo`

1. [Example](#1-example)
2. [Options](#2-options)
3. [Choosing config file](#3-choosing-config-file)

# 1. Example

Running Teuton test located into `example/01-target` folder.

```
$ teuton run example/01-target

------------------------------------
Started at 2023-01-21 13:32:24 +0000
F
Finished in 0.004 seconds
------------------------------------

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | anonymous | 0.0   | ?     |
+------+-----------+-------+-------+
```

> Output files are saved into `var/01-target` folder.

# 2. Options

```
$ teuton help run

Usage:
  teuton [run] [OPTIONS] DIRECTORY

Options:
  [--export=EXPORT]        
  [--cname=CNAME]          
  [--cpath=CPATH]          
  [--case=CASE]            
  [--color], [--no-color]  
  [--quiet], [--no-quiet]     
```

| ID | Command              | Descriptiont |
| -- | -------------------- | ------------ |
| 01 | teuton foo           | Run foo/start.rb, with config file foo/config.yaml |
| 02 | teuton run foo      | Run foo/start.rb, with config file foo/config.yaml |
| 03 | teuton . | Run ./start.rb with ./config.yaml file |
| 04 | teuton run --export=json foo | Run foo/start.rb and force json format during exporting |
| 05 | teuton run --cname=rock foo | Run foo/start.rb with foo/rock.yaml config file |
| 06 | teuton foo/demo42.rb | Run foo/demo42.rb with foo/demo42.yaml config file |
| 07 | teuton run --cpath=starwars/jedi.yaml foo | Run foo/start.rb with starwars/jedi.yaml config file |
| 08 | teuton run --case=6,16 foo | Run foo/start.rb with foo/config.yaml config file but only for case id '06' and '16' |

# 3. Choosing config file

## 3.1 Default file names

By default, when you run `teuton run foo`, this will search for:
* `foo/start.rb` test file and
* `foo/config.yaml` config file.

## 3.2 Using `cname` option

It's posible execute `teuton run --cname=rock foo`, and choose diferent config file into projet folder:
* `foo/start.rb` test file and
* `foo/rock.yaml` config file.

> `cname` param searchs YAML config file into the same project folder.

## 3.3 Using `cpath` option

An also, it's posible execute `teuton run --cpath=/home/obiwan/startwars.yaml foo`, and choose config file using its absolute path:
* `foo/start.rb` test file and
* `/home/obiwan/starwars.yaml` config file.

> `cpath` param selects YAML config file, from the specified path.

## 3.4 Using diferent main rb name

When you execute `teuton run foo/mazingerz.rb`, this will search for:
* `foo/mazingerz.rb` test file and
* `foo/mazingerz.yaml` config file.
