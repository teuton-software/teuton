[<< back](../../README.md)

# Commands

Available command functions:
1. [Show help](#1-show-help)
2. [Show version](#2-show-version)
3. [Create new test](#3-create-new-test)
4. [Check test](#4-check-test)
5. [Run test](#5-run-test)
6. [Show test info as README file](#6-show-test-info-as-readme-file)

# 1. Show help

Show help about command functions.

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

Alias: `teuton h`,`teuton -h`, `teuton --help`

# 2. Show version

Show current version.

Usage: `teuton version`

Example:

```bash
$ teuton version                               
teuton (version 2.9.5)
```

Alias: `teuton v`, `teuton -v`, `teuton --version`

# 3. Create new test

Create test skeleton.

Usage: `teuton new foo`

Example:

```console
$ teuton new foo

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

Alias: `teuton n foo`, `teuton -n foo`, `teuton --new foo`

# 4. Check test

Check test and config files located into DIRPATH folder.

Usage: `teuton check DIRPATH`

[Example](check-example.md)

| Command                      | Description |
| ---------------------------- | ----------- |
| teuton check path/to/dir/foo | Test content of start.rb and config.yaml files. |
| teuton check path/to/dir/foo --cname=demo | Test content of start.rb and demo.yaml files. |
| teuton check path/to/file/foo.rb | Test content of foo.rb and foo.yaml files. |
| teuton check path/to/file/foo.rb --cname=demo | Test content of foo.rb and demo.yaml files.|

Alias: `teuton c foo`, `teuton -c foo`, `teuton --check foo`

# 5. Run test

Read about [how to run tests](howto-run-tests.md)

# 6. Show test info as README file

Create a readme file for the exercise.

Usage: `teuton readme DIRPATH > README.md`

This function reads test and config files, and generate Markdown output with guidelines and target descriptions.

Students will need this information to resolv the proposed problem/exercise into their machines.

Alias:
* `teuton r DIRPATH`
* `teuton -r DIRPATH`
* `teuton --readme DIRPATH`
