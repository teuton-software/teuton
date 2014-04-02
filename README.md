CHECKER TOOL
============

**Introduction**
================

With this tool, a teacher defines a practice activity for the students.
In some way, we have a check list, that define the needed activity goals. 
The students do the classwork on their own Virtual Machines. 
And at the end, the teacher evaluate using this tool.
We obtain automaticaly, the results of every student

**Installation**
================
Required: 
* rake --version =>10.1.0
* ruby -v => 1.9.3p194

Use the next command to install the required software on Debian OS:
 
  rake debian_install

TODO:
* rake suse_install, rake windows_install, rake mac_install, etc.

**Getting started**
===================
To run one example test, do this *./check/demos/demo1.rb*.

You will see the results on the screen.
A file *./var/out/default.xml* is created with the results into XML format.

There exists a file *.tests/samples/demo1.yaml*, that containts information
of data cases. We can modify this file and configure the test to work with
more hosts.

**Define our first activity check**
===================================
Now we will define your own activity, in four steps:

**STEP 1**
Create an instance of Teacher class. This class do all the hard job.
It is the core of *checker-tool*.

**STEP 2**
Define one o more testXX_XXXX methods. This methods will contain our
tests, so it will define our activity targets. We must use a very simple
and special words to define our test.

Let's see, an example where we check if 'david' user exists, on our 
localhost. Define the command that will be execute into the host:

	command "cat /etc/passwd|grep david|wc -l"

Describe the action or the target we want to evaluate with our words,
so every body could easily understant:

	description "Checking user <david>"

Now we execute the command defined into the host:

	run_from :localhost
	
At the end we need to check the obtained result with our expectives:

	check result.to_i.equal?(1)

**STEP 3**
Init the process with our own YAML config file.

**STEP 4**
Show the results. At the end we need the results so you can do:
* t.report.show: Show the results on the screen.
* t.report.export :txt: Export the results to txt format file.
* t.report.export :xml: Export the results to xml format file.
* t.report.export :html: Export the results to html format file.
* t.report.export :csv: Export the results to csv format file.


Take a look at this example. The file *./tests/samples/demo1.rb*.

	#!/usr/bin/ruby
	# encoding: utf-8
	require_relative '../../sys/teacher1'

	#STEP 1: Create an instance of Teacher class
	t = Teacher.new

	#SETP 2: Define one o more testXX_XXXX methods.
	def t.test01_localhost
		command "cat /etc/passwd|grep ':"+get(:username)+"'|wc -l"
		description "Checking user <"+get(:username)+">"
		run_from :localhost
		check result.to_i.equal?(1)

		command "cat /etc/passwd|grep #{get(:username)}|cut -d: -f6"
		description "Checking home directory"
		run_from '127.0.0.1'
		weight 0.5
		check result.to_s.equal?(get(:homedir))

		command "df -h|grep sda"
		description "Number of sda devices, must be 3"
		run_from :host1
		check result.content.count==3
	
		log "Tests finished!"
	end

	#STEP 3: Init the process with our own YAML config file
	t.process 'tests/samples/demo1.yaml'

	#STEP 4: Show the results
	t.report.show
	t.report.export :xml


**Technology Stack**
====================
* Ruby 1.9
* Gems: net-ssh, net-sftp

