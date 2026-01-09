[<< back](README.md)

# readme

Create README files (with test instructions) from our test definition.

## Example

Take a look at our test definition section (Group):

```ruby
group "Customize readme output" do

  readme "This is our README example."
  readme "And here we'll see how to use readme keyword"

  target "Create user david."
  readme "Help: you can use 'useradd' command to create users."
  readme "Remember: Only root is permitted to create new users."

  run "id david"
  expect "david"

end
```

> In this example, localhost's OS must be GNU/Linux (any other compatible OS) because the command used is `id david`.

There exists some `readme` instructions after `group` and `target` lines.

## Execution

To generate automatically a README file from previous test, execute this:

```
$ teuton readme example/15-readme > example/15-readme/README.md
```

## Result

Content of `example/15-readme/README.md` file.

---

```
Date   : 2025-11-12 22:11:47 +0000
Teuton : 2.10.7
```

# Test: 15-readme

## Customize readme output
This is our readme example.
And here we'll see how to use readme keyword

Go to [LOCALHOST](#required-hosts) host, and do next:
* (x1.0) Create user david.
    * Help: you can use 'useradd' command to create users.
    * Remember: Only root is permitted to create new users.
