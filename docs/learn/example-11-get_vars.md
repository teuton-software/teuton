[<< back](README.md)

# Example: learn-11-get_vars

> Example files at `examples/learn-11-get_vars/` folder.

To read the variables from the configuration file we already have the `get` statement. Example, to read `dirname` we do `get(:dirname)`.

**Example 1:** Using `get` to read vars.

```ruby
  # "get(:dirname)" reads dirname var from config file
  target "Exist #{get(:dirname)} directory"
  run "file #{get(:dirname)}"
  expect_none "No such file or directory"
```

Since the "get" instruction is frequently used, It is good to have a fast path. Let's see another shorter way to read variables using the "_" operator.

**Example 2:** Using `_` to read vars.

```ruby
  # "_dirname" is equivalet to "get(:dirname)"
  target "Exist #{_dirname} directory"
  run "file #{_dirname}"
  expect_none "No such file or directory"
```

The Teuton language is a DSL built on top of the Ruby programming language, so we can also use variables like any programming language.

**Example 3:** Using variables.

```ruby
  # "dirname" is a variable
  dirname = get(:dirname)
  target "Exist #{dirname} directory"
  run "file #{dirname}"
  expect_none "No such file or directory"
```
