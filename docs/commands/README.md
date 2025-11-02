[<< back](../../README.md)

# Commands

Available command functions:
1. [Show help](#1-show-help)
2. [Show version](#2-show-version)
3. [Create new test](#3-create-new-test)
4. [Check test](#4-check-test)
5. [Run test](#5-run-test)
6. [Show test info as README file](#5-show-test-info-as-readme-file)

# 1. Show help

Show help about teuton command functions.

Example:
```bash
$ teuton help
Commands:
  teuton [run] [OPTIONS] DIRECTORY  # Run test from directory
  teuton check [OPTIONS] DIRECTORY  # Check test and config file content
  teuton config DIRECTORY           # Suggest configuration
  teuton help [COMMAND]             # Describe available commands or one specific command
  teuton new DIRECTORY              # Create skeleton for a new project
  teuton readme DIRECTORY           # Show README extracted from test contents
  teuton version                    # Show the program version
```

Execute `teuton help FUNCTION_NAME` for more information.

Alias:
* `teuton h`
* `teuton -h`
* `teuton --help`

# 2. Show version

Show current version.

```bash
teuton version
```

Example:

```bash
$ teuton version                               
teuton (version 2.9.5)
```

Alias:

* `teuton v`
* `teuton -v`
* `teuton --version`

# 3. Create new test

Create teuton test skeleton.

```bash
teuton new foo
```

Example:

```console
> teuton new foo

[INFO] Creating foo project skeleton
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

Alias:

* `teuton n foo`
* `teuton -n foo`
* `teuton --new foo`

# 4. Check test

```console
teuton check DIRPATH
```

Description: this command check teuton test and config files located into DIRPATH folder.

[Example](example_check.md)

| Command                      | Description |
| ---------------------------- | ----------- |
| teuton check path/to/dir/foo | Test content of start.rb and config.yaml files. |
| teuton check path/to/dir/foo --cname=demo | Test content of start.rb and demo.yaml files. |
| teuton check path/to/file/foo.rb | Test content of foo.rb and foo.yaml files. |
| teuton check path/to/file/foo.rb --cname=demo | Test content of foo.rb and demo.yaml files.|

Alias:

* `teuton c foo`
* `teuton -c foo`
* `teuton --check foo`

# 5. Run test

```bash
teuton run DIRPATH
```

Description: this command run teuton test located into DIRPATH folder.

[Example](example_run.md)

Alias:

* `teuton foo`

# 6. Show test info as README file

```bash
teuton readme DIRPATH
```

Read test and config files content, and display information about
what kind of problem/exercise it is going to be evaluated. The students need this
information to resolv the problem/exercise into their machines.

The teacher could write this information or may use this command to generate automaticaly.

Alias:
* `teuton r DIRPATH`
* `teuton -r DIRPATH`
* `teuton --readme DIRPATH`
