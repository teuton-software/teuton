
#DSL key words

To define and run our activity test we use the next DSL ktheey words:


##check

* `check :test_name do ... end`: Define a group of things to check with
their own name.

##desc, description
* `desc "Write text description for your action"`
* Describe the action or the target with your own words, so every one 
could easily understand what we are trying to do.

##on
* `on :host1, :execute => "id david|wc -l"`
* Execute the command into the specified host.

##expect
* `expect result.to_i.equal?(1)`
* After command execution we check the obtained result with our expectations.

##start

* `start do ... end`
* At the end of every script we must put the start order.

##show
* `show :resume`
* Showing a resume on the screen when the script finish.

##export
* `export :all`
* Export data results from every case, creating reports into de output directory.
