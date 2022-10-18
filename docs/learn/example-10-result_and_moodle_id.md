[<< back](README.md)

# Example: learn-10-result_and_moodle_id

> Example files at `examples/learn-10-result_and_moodle_id/` folder.

Sometimes it can be useful to look at the information returned by the "run" command. For this we use the "result" object.

## Object `result`

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

## Setting moodle_id

If you are a teacher and are using the Moodle platform, probably you will want to upload the results of the evaluation carried out by Teuton in Moodle.

Teuton generates a file called "moodle.csv" with the grades of each student. Only have to import the file into Moodle.

In the configuration file "config.yaml" add a field called "moodle_id" to each case. Fill it with the student's identification (For example, the email registered on the Moodle).

Example:
```
global:
cases:
- tt_members: Darth Vader
  tt_moodle_id: vader@starwars.com
- tt_members: Obiwan Kenobi
  tt_moodle_id: obiwan@starwars.com
```
