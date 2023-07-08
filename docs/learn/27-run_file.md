[<<back](README.md)

# DSL: run_file

You know the classic sequence `target/run/expect`, but sometimes you need to run our own script files on the remote computer. So you have to:

1. Upload a copy of the script file to the remote host
2. and then run it on remote host

For this task you use a new instruction called `run_file`.

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

> Resume:
> * **run_file**: will upload and execute `show.sh` on remote host.
> * `teuton example`: to run this example test.

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