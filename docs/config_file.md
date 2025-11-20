[<< back](../README.md)

# Config file

By default, Teuton projects use `config.yaml` as configuration file.

## Creating new project

* Create a new project `teuton new foo`.
```
Creating foo project
* Create dir        => foo
* Create file       => foo/config.yaml
* Create file       => foo/start.rb
```

* We now have the following files.
```
foo
├── config.yaml
└── start.rb
```

* Contents of the configuration file `foo/config.yaml`.
```yaml 
---
global:
cases:
- tt_members: TOCHANGE
```

The configuration file is in YAML format with two main sections: `global` y `cases`. The `global` section can be empty. Parameters defined in the `global` section will be accessible to all cases.
The `cases` section contains specific parameters for each case.

## Global section vs cases section

Let's see the file `examples/03-remote_hosts/config.yaml`.
```yaml
---
global:
  host1_username: root
cases:
- tt_members: student_1
  host1_ip: 192.168.1.201
  host1_password: secret_1
- tt_members: student_2
  host1_ip: 192.168.1.202
  host1_password: secret_2
- tt_members: student_3
  host1_ip: 127.0.0.1
  host1_password: secret_3
```

The parameter `host1_username` is defined in the global section, so all cases will read the same value (`get(:host1_username) == " root"`).

The parameters `tt_members`, `host1_ip`, and `host1_password` are defined in each case. Therefore, case number 1 will have one value, case number 2 another, and so on.

## Predefined params

tt_members