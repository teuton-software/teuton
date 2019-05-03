
# TEUTON Software

_(SysadminGame was his older name)_

```
TEUTON are test units for machines (everything).
TEUTON tests tons of goals on tons of machines.
```

Write test units for machines (and everything). Check a group of real/virtual machines to satisfied a list of targets/goals.

![logo](./docs/logo.png)

---

# Introduction

There are three ways of using this software:

| Name | Description |
| -------------- | ---------------------------- |
| **Classroom mode** | This tool helps teachers to evaluate remotely and automaticaly the workclass done by the students into their machines (STEM laboratory) |
| **Conquest mode** | Also is usefull for sysadmins conquest or compettions. Where every participant complete goals and targets on their own real/virtual machines. At the end the judges only have to run TEUTON and inmediately (Well, perhaps after a few seconds) will get the results of every one. |
| **Challenge mode** | So you can do a local installation and use TEUTON to complete challenges on our local machine. |

I'm using this application with my students. It's OK, but it could be improved (as everythieng of course).

I would like other users (interested in sysadmin and teaching) to know it, and receive comments, suggestions or
collaborations to improve it.

Thanks!

---

# Brief description

Steps to use this tool in **Classroom mode**:

1. **The teacher defines a TEUTON activity** for the group of students.
This is a list of required targets/goals and the way to check it.
1. **Every student does the classwork** into their own Virtual/Real Machines.
1. **The teacher runs TEUTON tool**. The tool automaticaly evaluates
and creates reports of every student.

> NOTE
>
> * The student's machines must be configured as remote conection from teacher computer.
> * It uses SSH connections.
> * The teacher must be allow to get into students machines.

---

# Quick demo

Every TEUTON challenge/activity consists of 2 files. Let's look at this [demo](https://github.com/dvarrui/teuton-challenges/tree/master/docs/examples):

| File                          | Description |
| ----------------------------- | ----------- |
| [docs/examples/example-01.rb](https://github.com/dvarrui/teuton-challenges/blob/master/docs/examples/example-01.rb)   | Defines TEUTON activity (DSL) |
| [docs/examples/example-01.yaml](https://github.com/dvarrui/teuton-challenges/blob/master/docs/examples/example-01.yaml) | Configuration file with every student machine |

**Run this demo** with [Teuton](./docs/en/command.md) command:

`teuton docs/example/example-01.rb`

**Results**
* You will see a brief *report on the screen* during execution.
* The extended *output files* are saved into `var/example-01/out/` directory.
* There exists more activities into [teuton-challenges](https://github.com/dvarrui/teuton-challenges) GitHub repository. This is a good place where save your own TEUTON challenges.

---

# Documentation

* [Let's go to the Wiki for more information](https://github.com/teuton-software/teuton/wiki)

* [Installation](./docs/en/installation.md)
* [Examples](./docs/en/examples.md)
* [HOWTO to create your first activity](./docs/en/first-activity.md)
* [Key words reference](./docs/en/dsl/README.md)

Other languages:
* ES - [Spanish documentation](./docs/es/README.md)

---

# Contact

* **Email**: `teuton.software@protonmail.com`
* **Twitter**: `@SoftwareTeuton`
