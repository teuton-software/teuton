
# DSL key words

To define and run our activity test we use the next DSL key words:

## Define instructions

These are the main DSL key words, usefull to define items to be evaluated.

| DSL                  | Description |
| :------------------- | :---------- |
| [task](./task.md)    | Define a group of targets. |
| [target](./target.md)| Define a target. This is the item to be checked. |
| [goto](./goto.md)    | Execute command into remote host. |
| [result](./result.md)| Contain the output of previous `goto` order. |
| [expect](./expect.md)| Check the obtained result with the expected value. |

## Execution instructions

`start`is the DSL key word that starts execution of all defined tasks. Example:

```
    start do
      ...
    end
```

* We write this instruction at the end of the rb script, to indicate that it's the moemnt to start the evaluation process.
* The `task` instructions define the test we want to do, but `start` instruction is used to start execution of all the tasks/targets into every remote hosts of every case.
* If you don't write this instruccion, your tests will never be executed.

# Report instructions

Other DSL key word related with reports and information.

| DSL                  | Descripción |
| :------------------- | :---------- |
| [show](./show.md)    | Show the results on screen. |
| [export](./export.md)| Make reports with the results of every evaluation. |
| [send](./send.md)    | Send copy of report file to remote host. |

---

##check

* `check :testname do ... end`: Define a group of items to check.

##desc, description
* `desc "Write text description for your action"`
* Describe the action or the target with your own words, so every one
could easily understand what we are trying to do.

##goto, on
* `goto :host1, :execute => "id david|wc -l"`
* Execute the command into the specified host.

##expect
* `expect result.to_i.equal?(1)`
* After command execution we check the obtained result with our expectations.

##start
We put this action at the end of every script, so it is the timr to begin
running the tests over the machines.

* `start do ... end`

##show
* `show`, it's the same as `show :resume`
* `show :resume`, show a resume on the screen when the script finish.
* `show :details`, show details of every case when the script finish.
* `show :all`, it's the same as `show :resume` and `show :details`.

##export
* `export`, it's the same as `export :all`
* `export :all`, create ouput file with the results of every single case.
By default use TXT format ouput.
* `export :all, :format => :txt`, create ouput text file with the results of every single case.

Other values for `:format` option are:
* `:txt`, plain text
* `:colored_text`, plain text with color
* `:html`, HTML
* `:xml`, XML
