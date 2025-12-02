[<< back](README.md)

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
  teuton config [OPTIONS] DIRECTORY  # Suggest configuration or run server
  teuton help [COMMAND]              # Describe available commands or one specific command
  teuton new DIRECTORY               # Create skeleton for a new project
  teuton readme DIRECTORY            # Show README extracted from test contents
  teuton version                     # Show the program version
```

**Example**: `teuton help config`
```
Usage:
  teuton config [OPTIONS] DIRECTORY

Options:
  [--server], [--no-server], [--skip-server]  

Description:
  config DIRECTORY, "Suggest the content of the configuration file based on the test"

  config --server DIRECTORY, "Init Config Server. Students connect and help to build config file content"
```
