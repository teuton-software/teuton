[<< back](README.md)

# include

Use `tt-include` to include several config files into your main config file.

Until now, all the examples we have seen use one configuration file (`config.yaml`) that contain all the parameters required by the test. It is possible to save configuration distributed among several files.

Suppose we have the following file structure.

```
├── config.yaml
├── moreconfigfiles
│   ├── 02
│   │   └── file02.yaml
│   ├── file01.yaml
│   └── file03.yml
└── start.rb
```

`config.yaml` will be the main config file. We have defined `tt_include` parameter with a folder wich contains more configuration files.

In this example the contents of all files in `moreconfigfiles` folder will be included when reading the config parameters:

```yaml
---
# Fiel: config.yaml
:global:
  :tt_include: moreconfigfiles
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

Config files into `moreconfigfiles` folder:

```yaml
# moreconfigfiles/file01.yaml
:tt_members: file01
:username: root
```

```yaml
# moreconfigfiles/02/file02.yaml
:tt_members: file02
:username: quigon
```

```yaml
# moreconfigfiles/file03.yml
:tt_members: file03
:username: vader
```
