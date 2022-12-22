[<< back](README.md)

# Example: readme

Create README files (with test instructions) from our test definition.

1. [Definition section](#definition-section)
2. [Execute command](#execute-command)
3. [Result](#result)

## Definition section

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

## Execute command

To generate automatically a README file from previous test, execute this:

```
teuton readme example/08-readme > example/08-readme/README.md
```

## Result

**Let's see the output**: Content of `example/08-readme/README.md` file.

---
# 08-readme

## Customize readme output

This is our README example.
And here we'll see how to use readme keyword

Go to [LOCALHOST](#required-hosts) host, and do next:
* Create user david.
    * Help: you can use 'useradd' command to create users.
    * Remember: Only root is permitted to create new users.
---
