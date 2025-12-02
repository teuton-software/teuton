[<< back](README.md)

# new

_Create the skeleton of a new project._

Usage: `teuton new DIRECTORY`

Example:

```console
$ teuton new foo

Creating foo project
* Create dir        => foo
* Create file       => foo/config.yaml
* Create file       => foo/start.rb
```

This command will create the next structure:

```
foo
├── config.yaml
└── start.rb
```

| Type      | Path            | Description    |
| --------- | --------------- | -------------- |
| Directory | foo             | Base directory |
| File      | foo/start.rb    | Main file with test definitions |
| File      | foo/config.yaml | YAML configuration file |

Alias: `teuton n foo`, `teuton -n foo`, `teuton --new foo`
