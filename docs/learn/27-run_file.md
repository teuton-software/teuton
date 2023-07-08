[<<back](README.md)

# DSL: run_file

You know the classic sequence `target/run/expect`, but sometimes you need to run our own script files on the remote computer. So you have to:

1. Upload a copy of the script file to the remote host
2. and then run it on remote host

**run_file** upload and execute your own local script on remote host.

## Example

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

Now we will define the `target/run_file/expect` sequence as follows:

```ruby
target "Upload script and execute on remote host"
run_file "bash show.sh Hello", on: :host1
expect "Hello"
```

## Running example

```
❯ teuton examples/27-run_file 
------------------------------------
Started at 2023-07-08 09:10:13 +0100
..Fuuu..u..u.u.u.u.u.uuu
Finished in 1.244 seconds
------------------------------------
 
CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | Localhost | 67.0  |       |
| 02   | Remote1   | 100.0 | ✔     |
| 03   | Remote2   | 100.0 | ✔     |
| 04   | Remote3   | 100.0 | ✔     |
+------+-----------+-------+-------+
```

Meaning of progress symbols:
* `.`: check ok
* `F`: check fail
* `!`: connection fail
* `u`: upload ok

In the above example, localhost does not complete its targets 100% because the last target is set to run remote only.

## Warning about remote names

Local `script/show.sh` file is copied to remote machine as `tt_script_show.sh`, and then `run_file` execute `tt_script_show.sh`.

* The `tt_` prefix is added to mark files that have been automatically uploaded as result of `run_file` action. When test finished these files can deleted.
* The folder name becomes part of the remote file name. Because at the moment it is not possible to create directories on the remote computer in a platform-agnostic way.

# DSL: upload

`upload` is a dsl instruction, whose purpose is to upload files to the remote host. 

```ruby
  upload "FILENAME1", remotefile: "FILENAME2", to: :host1
```

In this example, 
* `upload "FILENAME1"`, upload local file.
* `remotefile: "FILENAME2"`, rename remote file. This parameter is optional. When not defined the remote filename is equal to local filename.
* `to: :host1`, the remote host is identified by `host1`.

## Example

```ruby
  target "Upload file and then run it"
  upload "script/show.sh", remotefile: "show.sh", to: :host1
  run "bash show.sh HelloWorld2", on: :host1
  expect "HelloWorld2"
```

Example steps:
1. Describe target.
2. Upload local file to remote host.
3. Run script using Bash on remote host.
4. Evaluate script output.

## Warnings about remote folder

Example:`upload "script/show.sh", to :host1`

The local file `script/show.sh` will be copied into remote folder (`script`) on remote host (`host1`) but remote folder must already be created previously. Because at the moment it is not possible to create directories on the remote computer in a platform-agnostic way.
