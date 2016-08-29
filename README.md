
#SysadminGame

DSL to write `Host Unit Tests`. Check if a group of real or virtual Machines
satisfied a list of targets.

![logo](./docs/logo.png)

#Introduction

This is an Open Source tool, for use in computer laboratory.
*sysadmin-game* helps teachers to evaluate remotely and automaticaly
the workclass done by the students into their machines.

Steps:

1. **The teacher defines a practice activity** for the group of students.
This is a list of required goals and the way to check it.
1. **Every student does the classwork** into their own Virtual/Real Machines.
1. **The teacher runs the activity**. The tool automaticaly evaluates
and creates reports of every student.

I'm using *sysadmin-game* with my students. It's OK, but it could be improved
(as everything of course). I would like other users (interested in sysadmin
and teaching) to know it, and receive comments, suggestions or
collaborations to improve it.

Thanks!

#Quick demo

Every sysadmin-game activity consists of 2 files. Let's look at this demo:
* `./docs/examples/example-01.rb`: This is the script wich defines the activity.
* `./docs/examples/example-01.yaml`: This file contains the configuration for every
student machine (cases).

Run this demo with `./project docs/example/example-01.rb`.

> **Results**
> * You will see a brief *report on the screen* during execution.
> * The extended *output files* are saved into `./var/example-01/out/` directory.
> * There exists more activities into the `check` directory. This is a good place
where save your own activity scripts.

#Documentation
* [Installation](./docs/en/installation.md)
* [Examples](./docs/en/examples.md)
* [Create our first activity](./docs/en/first-activity.md)
* [DSL Key words](./docs/en/dsl-key-words.md)
* [TO-DO list](./TODO.md)
* ES - [Spanish documentation](./docs/es/README.md)
