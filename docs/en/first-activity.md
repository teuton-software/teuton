
#Creating our first activity

How to create our own activity test, in four steps:

##STEP 1
Create an empty file with execution permission, and include a 
reference to our tool (`lib/tool.rb`).

    require_relative '../../lib/tool'

This file will be called, for example, `./check/demos/my_demo.rb`.

##STEP 2
Second, write tests using the key words: `desc`, `on` and `expect`.
Let's see an example:

```
check :test_name do

	desc "Checking user david"
	on :host1, :execute => "id david |wc -l"
	expect result.to_i.equal?(1)

	log "Tests finished!"
	
end
```

The above example checks if 'david' user exists, on *host1* system.

Let's see the key words used:
* `desc "Checking user <david>"`, Describe the action or the target 
with our words, so every one could easily understand what we are trying
to check.
* `on :host1, :execute => "cat /etc/passwd|grep david|wc -l"`: Execute the command 
into the target host.
* `expect result.to_i.equal?(1)`: At the end we need to check the obtained 
result with our expectations.

##STEP 3
At the end of our example script we add this lines:
```
start do
	show :resume
	export :all, :format => :txt
end
```
The above lines order:
* Start the process of testing every case.
* Showing a resume on the screen when finish, and 
* Create reports for every case in txt format.

##STEP 4
We need a YAML configuration file, where define the params and hosts used
by our script. Let's see:

```
---
:global:
:cases:
- :tt_members: Student1
  :host1_ip: 1.1.1.1
  :host1_password: password4student1
- :tt_members: Student2
  :host1_ip: 2.2.2.2
  :host1_password: passowrd4student2
```
The above file configures 2 diferents cases with their own params. The script
use this information when execute every case.
