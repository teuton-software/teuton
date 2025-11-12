[<<back](README.md)

# DSL: run_script

You know the classic sequence `target/run/expect`, but sometimes you need to run our own script files on the remote computer. So you have to:

1. Upload a copy of the script file to the remote host
2. and then run it on remote host

**run_script** upload and execute your own local script on remote host.

> Example files at [examples/27-run_file](../../examples/27-run_script)

## Example files

Suppose we have the following files:
```
example
├── config.yaml
├── show.sh
└── start.rb
```

Contents of the `show.sh` script:
```bash
#!/usr/bin/env bash
MESSAGE=$1
echo $MESSAGE
exit 0
```

## Usage

`run_script` is the DSL keyword in charge of uploading the script to the remote computer and executing it. When invoking run_script we have two styles: compact or separate components. Let's see

### Compact invocation

The "command" string executed contains the interpreter, the script, and the arguments. Example: `"bash show.sh Hello"`.

```ruby
target "Mode 1: Upload script and execute on remote host"
run_script "bash show.sh Hello", on: :host1
expect "Hello"
```

### Separate components

Pass the script name, interpreter, and its arguments using separate parameters.

```ruby
target "Mode 2: Upload script and execute on remote host"
run_script "show.sh", shell: "bash", args: "Hello", on: :host1
expect "Hello"
```

### Separate components and defaut shell

Or setting shell default value:

```ruby
set(:shell, "bash")

target "Mode 3: Upload script and execute on remote host"
run_script "show.sh", args: "Hello", on: :host1
expect "Hello"
```

## Running example

```
------------------------------------
Started at 2023-07-23 13:46:11 +0100
....uu..u.u.u.uu..u.!F!F!F!F
Finished in 30.457 seconds
------------------------------------

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | Localhost | 100.0 | ✔     |
| 02   | Remote1   | 100.0 | ✔     |
| 03   | Remote2   | 100.0 | ✔     |
| 04   | Remote3   | 0.0   | ?     |
+------+-----------+-------+-------+

CONN ERRORS
+------+---------+-------+------------------+
| CASE | MEMBERS | HOST  | ERROR            |
| 04   | Remote3 | host1 | host_unreachable |
+------+---------+-------+------------------+
```

Meaning of progress symbols:
* `.`: check ok
* `F`: check fail
* `!`: connection fail
* `u`: upload ok
