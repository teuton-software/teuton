#SYSADMIN-GAME

#Introduction

This is an Open Source program, for use in computer laboratory. 
*Sysadmin* helps teachers to evaluate remotely and automaticaly 
the workclass done into students machines.

Steps:

1. **Define** a practice **activity** for the group of students. 
Teacher defines a list of required goals and the way to check it.
1. **Every student does the classwork** on their own Virtual/Real Machines. 
1. The teacher **execute the tool**, that automaticaly evaluate and create results report of every student.

I'm using *sysadmin* with my students but it could be improved (as everything of course).
I would like other users (interested in sysadmin and teaching) to know this and
receive comments, suggestions or collaborations to improve it.

Thanks!

#Quick demo

Look at this demo files:
* `./check/demos/demo1-localhost.rb`: This is the script wich defines the activity.
* `./check/demos/demo1-localhost.yaml`: This file contains the configuration for every case (student machine).

To run our first demo activity we do:

`./check/demos/demo1-localhost.rb`.

> You will see the brief *report on the screen*, and the extended *output files* are 
saved into `./var/demo1-localhost/out/` directory.

#Documentation
* [Installation](./docs/en/installation.md)
* [Create our first activity](./docs/en/first-activity.md)
* [DSL Key words](./docs/en/dsl-key-words.md)
