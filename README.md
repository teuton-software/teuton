#SYSADMIN-GAME

#Introduction

This program helps teachers to evaluate a group of students classwork, done on their own machines.

Steps:

1. Define a practice activity for the group of students. 
Teacher defines a list of required goals and the way to check it.
1. Every student does the classwork on their own Virtual/Real Machines. 
1. The teacher execute the tool, that automaticaly evaluate and create results report of every student.

#Quick demo

Look at this demo files:
* `./check/demos/demo1-localhost.rb`: This is the script to run. With the tests or defined activity.
* `./check/demos/demo1-localhost.yaml`: This is the configuration file used by the script.
This file contains the params for every case (student machine).

To run our first demo activity we do:

`./check/demos/demo1-localhost.rb`.

You will see the resumed results on the screen, and the output files are 
created into `/var/demo1-localhost/out/` directory.

#Documentation
* [Installation](./docs/en/installation.md)
* [Create our first activity](./docs/en/first-activity.md)
* [DSL Key words](./docs/en/dsl-key-words.md)
