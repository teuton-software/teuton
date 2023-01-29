[<< back](README.md)

# Macros

Macros is a technique to make it easier to write and reuse code.

**Example**

* We start from a set of repeated targets.

```ruby
target "Exist user fran"
run "id fran"
expect_one "root"

target "Exist user root"
run "id root"
expect_one "root"

target "Exist user david"
run "id david"
expect_one "david"
```

* Define a macro with the repeated block:

```ruby
define_macro "user_exists", :name do
  target "Exist user #{get(:name)}"
  run "id #{get(:name)}"
  expect_one get(:name)
end
```

* Replace the previous targets with macro calls. There are 3 ways to invoke the macro:

```ruby
user_exists(name: "fran")
user_exists(name: "root")
user_exists(name: "david")
```

**Notice**: There are 3 ways to invoke the macro:

```ruby
user_exists(name: "fran")
macro "user_exists", name: "fran"
macro_user_exists(name: "fran")
```
