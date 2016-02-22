
#DSL key words

To define and run our activity test we use the next DSL key words:


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
