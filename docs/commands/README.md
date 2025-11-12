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

Usage: 
* `teuton help`
* `teuton help FUNCTION_NAME`

Alias: `teuton h`,`teuton -h`, `teuton --help`

# 2. Show version

Show current version.

Usage: `teuton version`

Alias: `teuton v`, `teuton -v`, `teuton --version`

# 3. Create new test

Create test skeleton.

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

# 4. Check test

Check test and config files from DIRPATH folder.

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

Read about how to [run tests](run-tests.md)

# 6. Show test info as README file

Create a readme file for the exercise.

Usage: `teuton readme DIRPATH > README.md`

This function reads test and config files, and generate Markdown output with guidelines and target descriptions about the exercise.

Alias: `teuton r DIRPATH`, `teuton -r DIRPATH`, `teuton --readme DIRPATH`
