[<< back](../../README.md)

# Commands

```
$ teuton
Commands:
  teuton [run] [OPTIONS] DIRECTORY   # Run test from directory
  teuton check [OPTIONS] DIRECTORY   # Check test and config file content
  teuton config [OPTIONS] DIRECTORY  # Suggest configuration or run server
  teuton help [COMMAND]              # Describe available commands or one specific command
  teuton new DIRECTORY               # Create skeleton for a new project
  teuton readme DIRECTORY            # Show README extracted from test contents
  teuton version                     # Show the program version
```

Available command functions:
1. [run](run.md)
2. [check](#2-check)
3. [config](config.md)
4. [help](#4-help)
5. [new](#5-new)
6. [readme](#6-readme)
7. [version](#7-version)

# 2. check

Check test and config files from DIRPATH folder.

Usage: `teuton check DIRPATH`

[Example](check.md)

| Command                      | Description |
| ---------------------------- | ----------- |
| teuton check PATH/TO/DIR/foo | Test content of start.rb and config.yaml files. |
| teuton check PATH/TO/DIR/foo --cname=demo | Test content of start.rb and demo.yaml files. |
| teuton check PATH/TO/FILE/foo.rb | Test content of foo.rb and foo.yaml files. |
| teuton check PATH/TO/FILE/foo.rb --cname=demo | Test content of foo.rb and demo.yaml files.|

Alias: `teuton c foo`, `teuton -c foo`, `teuton --check foo`

# 4. help

Show help about command functions.

Usage: 
* `teuton help`
* `teuton help FUNCTION_NAME`

Alias: `teuton h`,`teuton -h`, `teuton --help`

# 5. new

Create the skeleton of a new project.

Usage: `teuton new foo`

Example:

```console
$ teuton new foo

Creating foo project
* Create dir        => foo
* Create file       => foo/config.yaml
* Create file       => foo/start.rb
```

This command will create the next structure:

| File/Directory  | Description    |
| --------------- | -------------- |
| foo             | Base directory |
| foo/start.rb    | Main file with test definitions |
| foo/config.yaml | YAML configuration file |

Alias: `teuton n foo`, `teuton -n foo`, `teuton --new foo`

# 6.  readme

Show test info as README file. Useful for create a readme file for the exercise.

Usage: `teuton readme DIRPATH > README.md`

This function reads test and config files, and generate Markdown output with guidelines and target descriptions about the exercise.

Alias: `teuton r DIRPATH`, `teuton -r DIRPATH`, `teuton --readme DIRPATH`

# 7. version

Show current version.

Usage: `teuton version`

Alias: `teuton v`, `teuton -v`, `teuton --version`
