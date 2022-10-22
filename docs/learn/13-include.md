[<< back](README.md)

# Example: 13-include

Until now, all the tests we have seen came with a configuration file (`config.yaml`) that contained all the parameters that will later be used in the test. It is also possible to have the information distributed among several configuration files.

Suppose we have the following file structure.

```
├── config.yaml
├── include_this_files
│   ├── 02
│   │   └── file02.yaml
│   ├── file01.yaml
│   └── file03.yml
└── start.rb
```

`config.yaml` will be the main config file. Using `tt_include` parameter, we define a folder where the rest of the configuration files will be.

In this example the contents of the files in the include_this_files folder will be included in the configuration:

```yaml
---
# Fiel: config.yaml
:global:
  :tt_include: include_this_files
:cases:
```

If we execute the test we will see that 3 cases are processed. Which are defined in the files `file01.yaml`, `02/file02.yaml` and `file03.yml`.


```
CASE RESULTS
+------+---------+-------+-------+
| CASE | MEMBERS | GRADE | STATE |
| 01   | file02  | 0.0   | ?     |
| 02   | file01  | 100.0 | ✔     |
| 03   | file03  | 0.0   | ?     |
+------+---------+-------+-------+
```

Config files into `include_this_files` folder:

```yaml
:tt_members: file01
:username: root
```

```yaml
:tt_members: file02
:username: quigon
```

```yaml
:tt_members: file03
:username: vader
```
