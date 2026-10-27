[<<back](../../README.md)

# readme

Create README files (with test instructions) from our test definition.

## Example

Take a look at our test definition section (Group):

```ruby
group "Customize readme output" do

  doc "This is our README example."
  doc "And here we'll see how to use readme keyword"

  target "Create user david."
  doc "Help: you can use 'useradd' command to create users."
  doc "Remember: Only root is permitted to create new users."

  run "id david"
  expect "david"

end
```

> In this example, localhost's OS must be GNU/Linux (any other compatible OS) because the command used is `id david`.

There exists some `doc` instructions after `group` and `target` lines.

## Execution

To generate automatically a Markdown file from previous test, execute this:

```
$ teuton doc example/15-doc > example/15-doc/README.md
```

## Result

Content of `example/15-doc/README.md` file.

---

```
Date   : 2026-10-21 21:54:49 +0100
Teuton : 3.2.1
```

# Test: 15-readme

## Customize doc output
This is our readme example.
And here we'll see how to use readme keyword

Go to [LOCALHOST](#required-hosts) host, and do next:
* (x1.0) Create user david.
    * Help: you can use 'useradd' command to create users.
    * Remember: Only root is permitted to create new users.
