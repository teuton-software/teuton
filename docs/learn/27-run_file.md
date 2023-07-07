[<<back](README.md)

# DSL: run_file

We already know the following sequence:

```ruby
target "Current user is member of docker group"
run "groups", on: :host1
expect "docker"
```

The `run` statement executes the specified command (groups) on the remote computer (:host1).

Sometimes we need to run our own script on the remote computer. To do this we have to:

1. Upload a copy of the script to the remote computer
2. and then run it. 

For this task we have created a new instruction called `run_file`.

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

