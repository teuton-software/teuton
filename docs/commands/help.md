[<< back](../../README.md)

# help

_Show help about command functions._

Usage: 
* `teuton help`
* `teuton help FUNCTION_NAME`

Alias: `teuton h`,`teuton -h`, `teuton --help`

**Example**: `teuton help`
```
Commands:
  teuton [run] [OPTIONS] DIRECTORY   # Run test from directory
  teuton check [OPTIONS] DIRECTORY   # Check test and config file content
  teuton config [OPTIONS] DIRECTORY  # Suggest configuration.
  teuton help [COMMAND]              # Describe available commands or one specific command
  teuton new DIRECTORY               # Create skeleton for a new project
  teuton readme DIRECTORY            # Show README extracted from test contents
  teuton tree                        # Print a tree of all available commands
  teuton version                     # Show the program version
```

**Example**: `teuton help check`

```
Usage:
  teuton check [OPTIONS] DIRECTORY

Options:
  [--onlyconfig], [--no-onlyconfig], [--skip-onlyconfig]  
  [--color], [--no-color], [--skip-color]                 
  [--cname=CNAME]                                         
  [--cpath=CPATH]                                         

Description:
  (1) teuton check PATH/TO/DIR , Check content of start.rb and config.yaml files.

  (2) teuton check PATH/TO/DIR --cname=demo , Check content of start.rb and demo.yaml files:

  (3) teuton check PATH/TO/DIR --onlyconfig , Only show config file recomendations

  (4) teuton check PATH/TO/DIR/foo.rb , Check content of foo.rb and foo.yaml files.

  (5) teuton check PATH/TO/DIR/foo.rb --cname=demo , Check content of foo.rb and demo.yaml files.```
