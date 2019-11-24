To define and run our activity test we use the next DSL key words:

## Definition instructions

These are the main DSL key words, usefull to define items to be evaluated.

| DSL                      | Description |
| :----------------------- | :---------- |
| [[group]] | Define a group of items to check. |
| [[target]] | Define a target. This is the item to be checked. |
| [[goto]]   | Execute command into remote host. |
| [[run]]     | Execute command into localhost. |
| [[result]] | Contain the output of previous `goto` order. |
| [[expect]] | Check the obtained result with the expected value. |

---

## Execution instructions

DSL key word related with reports and information.

| DSL        | Descripción                              |
| :--------- | :--------------------------------------- |
| [[play]]   | Run the challenge.                       |
| [[show]]   | Show the results on screen.              |
| [[export]] | Make reports with the results of every evaluation. |
| [[send]]   | Send copy of report file to remote host. |

---

## Setting instructions

| DSL     | Descripción |
| :------ | :---------------------------------------- |
| [[get]] | Read param value from configuration file. |
| [[set]] | Set new param value for running configuration. |

---

## Ruby language

It is possible to use ruby language programming structures, in the definition of challenges (iterators, arrays, etc.). Very useful when we have repetitive lines.

Example, how to create 4 target evaluation using an Array:
```ruby
users = ['Obiwan', 'Yoda', 'Maul', 'Vader']
users.each do |user|
  target "Exist user #{user}"
  goto :host1, :exec => "id #{user}"
  expect_one user
end
```
