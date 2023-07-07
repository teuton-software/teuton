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

> * **run_file**: will upload `show.sh` to `host1` and then will execute it on remote host.
> * `teuton example`: to run this example test.

