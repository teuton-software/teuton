[<<back](README.md)

# DSL: upload

`upload` is a dsl instruction, whose purpose is to upload files to the remote host.

```ruby
  upload "FILENAME", to: :host1
```

* `upload "FILENAME"`, upload local file to remote.
* `to: :host1`, specifies remote host.

> Example files at [examples/28-upload](../../examples/28-upload)

## Other options

* Upload "LOCALDIR/FILENAME" to default remote dir into remote host:

```ruby
  upload "LOCALDIR/FILENAME", to: :host1
```

* Upload "LOCALDIR/FILENAME" to remote dir into remote host:

```ruby
  upload "LOCALDIR/FILENAME", remotedir: "REMOTEDIR", to: :host1
```

* Upload several local files from "LOCALDIR" to default remote dir into host:

```ruby
  upload "LOCALDIR/*", to: :host1
```

* Upload several local files from "LOCALDIR" to remote host:

```ruby
  upload "LOCALDIR/*", remotedir: "REMOTEDIR", to: :host1
```

## Example

```ruby
  target "Upload file and then run it"
  upload "script/show.sh", remotedir: "sh", to: :host1
  run "bash sh/show.sh HelloWorld", on: :host1
  expect "HelloWorld"
```

Example steps:
1. Describe target.
2. Upload local file to remote host.
3. Run script using Bash on remote host.
4. Evaluate script output.
