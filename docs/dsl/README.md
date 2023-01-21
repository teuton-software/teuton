[<< back](../../README.md)

# Language keywords

To define our targets, and to run our tests, we use the next DSL keywords:

Types:

* **Definition DSL**: keywords to define targets/items to be checked/evaluated.
* **Execution DSL**: keywords used to specify accions related with reports and showing information.
* **Settings DSL**: keyword to read and write config file.

## Keyword table

| DSL                 | Type       | Descripción                       |
| :------------------ | :--------: | :-------------------------------- |
| [expect](expect.md) | Definition | Check the obtained result with the expected value. |
| [export](export.md) | Execution  | Make reports with the results of every evaluation. |
| [get](get.md)       | Settings   | Read param value from configuration file. |
| [group](group.md)   | Definition | Define a group of items to check. |
| [play](play.md)     | Execution  | Run the challenge.                |
| [result](result.md) | Definition | Contain the output of previous `run` order. |
| [run](run.md)| Definition | Execute command into remote host or localhost. |
| [target](target.md) | Definition | Define a target. This is the item to be checked. |
| [send](send.md)     | Execution  | Send copy of report file to remote host. |
| [set](set.md)       | Settings   | Set new param value for running configuration. |
| [show](show.md)     | Execution  | Show the results on screen.       |

### Programming language

It is possible to use Ruby language programming into Teuton tests. For example, in the definition of our test (iterators, arrays, etc.). Useful when we have repetitive lines, etc.

Example, how to create 4 target evaluation using a List/Array:

```ruby
users = ['Obiwan', 'Yoda', 'Maul', 'Vader']

for name in users do
  target "Exist user #{name}"
  run "id #{name}", on: :host1
  expect_one name
end
```
