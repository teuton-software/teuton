[<< back](README.md)

# Example: 14-alias

By using aliases we can adapt a configuration file, so that it can be used with many different tests.

## Exanation

Suppose we have a test like the following:

```ruby
group "Using alias" do
  target "Verify user #{get(:super)} with key alias."
  run "id #{get(:super)}"
  expect get(:super)

  target "Verify user #{_username} with method alias."
  run "id #{_username}"
  expect _username
end
```

> REMEMBER:
> * We only have 2 targets but we could have many more.
> * `_username` is equivalent to `get(:username)`

Our test requires the `super` parameter but the configuration file has named it as `superuser`. Our configuration file define values for `supername` and `username` parameters. Let's see:

```yaml
# First version
# File: config.yaml
global:
cases:
- tt_members: Anonymous
  superuser: root
  username: obiwan
```

We would like to take advantage of a configuration file that we already had from another test, without big changes. So we add an `alias`:

```yaml
# Alias Version
# File: config.yaml
alias:
  super: :superuser
global:
cases:
- tt_members: Anonymous
  superuser: root
  username: obiwan
```

Now our test will work correctly. Calling `get(:super)` will return the same value as doing `get(:superuser).
