[<< back](../../README.md)

# Commands

Available command functions:
1. Show help
2. Show version
3. Create new test
4. Check teuton test
5. Run teuton test
    * Running Teuton test
    * Command options
    * Choosing other config file name

# 1. Show help

Usage:

```bash
teuton
```

Example:

```bash
> teuton
Commands:
  teuton [run] [OPTIONS] DIRECTORY  # Run challenge from directory
  teuton check [OPTIONS] DIRECTORY  # Test or check challenge contents
  teuton help [COMMAND]             # Describe available commands or one specific command
  teuton new DIRECTORY              # Create skeleton for a new project
  teuton readme DIRECTORY           # Create README.md file from challenge contents
  teuton version                    # Show the program version

```

Alias:
* `teuton h`
* `teuton -h`
* `teuton --help`

# 2. Show version

Usage:

```bash
teuton version
```

Example:

```bash
$ teuton version                               
teuton (version 2.2.0)
```

Alias:
* `teuton v`
* `teuton -v`
* `teuton --version`

# 3. Create new test

Usage:

```bash
teuton new foo
```

Example:

```bash
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
| foo/start.rb    | Main Script    |
| foo/config.yaml | YAML configuration file |

Alias:
* `teuton n foo`
* `teuton -n foo`
* `teuton --new foo`

# 5. Check teuton test

Usage:

```bash
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

# 4. Run teuton test

Usage:

```bash
teuton run DIRPATH
```

Description: this command run teuton test located into DIRPATH folder.

[Example](example_run.md)

Alias:
* `teuton r foo`
* `teuton -r foo`
* `teuton --run foo`
