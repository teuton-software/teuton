[<< back](../../README.md)

# Commands

Available command functions:
1. Show help
2. Show version
3. Create new test skeleton
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

# 2. Show version

Usage:

```bash
teuton version
```

Example:

```bash
$ teuton version                               
teuton (version 2.1.9)
```

Alias:
* `teuton v`
* `teuton -v`
* `teuton --version`

# 3. Create new test skeleton

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
* Create file       => foo/.gitignore
```

This command will create the next structure:

| File/Directory  | Description    |
| --------------- | -------------- |
| foo             | Base directory |
| foo/start.rb    | Main Script    |
| foo/config.yaml | YAML configuration file |
| foo/.gitignore  | By default, ignore YAML files to be upload on git repository |

# 5. Check teuton test

Usage:

```bash
teuton check DIRPATH
```

Description: this command check teuton test source files,located into DIRPATH folder.

[Example](example_check.md)

# 4. Run teuton test

Usage:

```bash
teuton run DIRPATH
```

Description: this command run teuton test located into DIRPATH folder.

[Example](example_run.md)
