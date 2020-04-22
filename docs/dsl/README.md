[<< back](../../README.md)

# Teuton language

To define and run our activity test we use the next DSL keywords:
1. [Definition instructions](#definition-instructions)
2. [Execution instructions](#execution-instructions)
3. [Setting instructions](#setting-instructions)
4. [Ruby language](#ruby-language)

## Definition instructions

These are the main DSL key words, usefull to define items to be evaluated.

| DSL                            | Description |
| :----------------------------- | :---------- |
| [group](definition/group.md)   | Define a group of items to check. |
| [target](definition/target.md) | Define a target. This is the item to be checked. |
| [run](definition/run.md)       | Execute command into localhost or remote host. |
| [goto](definition/goto.md)     | Execute command into remote host or local host. |
| [result](definition/result.md) | Contain the output of previous `goto` order. |
| [expect](definition/expect.md) | Check the obtained result with the expected value. |

## Execution instructions

DSL key word related with reports and information.

| DSL                           | Descripción                              |
| :---------------------------- | :--------------------------------------- |
| [play](execution/play.md)     | Run the challenge.                       |
| [show](execution/show.md)     | Show the results on screen.              |
| [export](execution/export.md) | Make reports with the results of every evaluation. |
| [send](execution/send.md)     | Send copy of report file to remote host. |

## Setting instructions

| DSL                   | Descripción                                    |
| :-------------------- | :--------------------------------------------- |
| [get](setting/get.md) | Read param value from configuration file.      |
| [set](setting/set.md) | Set new param value for running configuration. |

## Ruby language

It is possible to use ruby language programming structures, in the definition of our test (iterators, arrays, etc.). Useful when we have repetitive lines, etc.

Example, how to create 4 target evaluation using an Array:
```ruby
users = ['Obiwan', 'Yoda', 'Maul', 'Vader']

users.each do |user|
  target "Exist user #{user}"
  run "id #{user}", on: :host1
  expect_one user
end
```
