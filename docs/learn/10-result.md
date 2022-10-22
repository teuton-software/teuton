[<< back](README.md)

# Example: 10-result

Sometimes it can be useful to look at the information returned by the "run" command. For this we use the **"result" object**.

**Example 1:**  In this example we run the "hostname" command on the machine and capture its output using "result". We'll use that value to make sure there isn't a user named as host name.

```ruby
group "Using result object" do
  # Capturing hostname value
  run "hostname"
  hostname = result.value

  target "No #{hostname} user"
  run "id hostname"
  expect_none hostname
end
```

**Example 2:** When we are debugging our test and we want to see the content of the "result" object on the screen, we will use `result.debug`.

```
group "Checking users" do
  users = ["root", "vader"]

  users.each do |name|
    target "Exists username #{name}"
    run "id #{name}"
    result.debug
    expect "(#{name})"
  end
end
```

> More information about [result](../dsl/definition/result.md) keyword.
