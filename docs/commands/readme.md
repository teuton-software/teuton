[<< back](README.md)

# readme

_Show test info as README file. Useful for create a readme file for the exercise._

Usage:
* `teuton readme DIRPATH`
* `teuton readme DIRPATH > README.md`

This function reads test and config files, and generate Markdown output with guidelines and target descriptions about the exercise.

Alias: `teuton r DIRPATH`, `teuton -r DIRPATH`, `teuton --readme DIRPATH`

## Example

Test content:
```
$ cat examples/02-target/start.rb

group "Learn about targets" do
  target "Create user obiwan", weight: 2
  run "id obiwan"
  expect ["uid=", "(obiwan)", "gid="]

  target "Delete user vader"
  run "id vader"
  expect_fail
end

start do
  show
  export
end
```

Generate test documentation: `teuton readme examples/02-target`

---
```
Date   : 2025-12-02 16:00:09 +0000
Teuton : 2.11.0
```

# Test name: 02-target

## Learn about targets

Go to [LOCALHOST](#required-hosts) host, and do next:
* (x2.0) Create user obiwan.
* (x1.0) Delete user vader.
---
