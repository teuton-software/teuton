[<< back](../../README.md)

# Language keywords

To define our targets, and to run our tests, we use the next DSL keywords:

Types:

* Definition: DSL keywords to define targets/items to be checked/evaluated.
* Execution: DSL keywords used to specify accions related with reports and showing information.
* Settings: DSL keyword to read and write config file.

| DSL                 | Type       | Descripción                       |
| :------------------ | :--------: | :-------------------------------- |
| [group](group.md)   | Definition | Define a group of items to check. |
| [target](target.md) | Definition | Define a target. This is the item to be checked. |
| Remote [run](run_remote.md)| Definition | Execute command into remote host. |
| Local [run](run_local.md)  | Definition | Execute command into local host. |
| [result](result.md) | Definition | Contain the output of previous `run` order. |
| [expect](expect.md) | Definition | Check the obtained result with the expected value. |
| [play](play.md)     | Execution  | Run the challenge.                       |
| [show](show.md)     | Execution  | Show the results on screen.              |
| [export](export.md) | Execution  | Make reports with the results of every evaluation. |
| [send](send.md)     | Execution  | Send copy of report file to remote host. |
| [get](get.md)       | Settings   | Read param value from configuration file.      |
| [set](set.md)       | Settings   | Set new param value for running configuration. |

## Ruby language

It is possible to use ruby language programming structures, in the definition of our test (iterators, arrays, etc.). Useful when we have repetitive lines, etc.

Example, how to create 4 target evaluation using a List/Array:

```ruby
users = ['Obiwan', 'Yoda', 'Maul', 'Vader']

users.each do |user|
  target "Exist user #{user}"
  run "id #{user}", on: :host1
  expect_one user
end
```
