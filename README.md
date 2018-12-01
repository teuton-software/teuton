
# TEUTON Software (SysadminGame)

```
TEUTON are test units for machines (everything).
TEUTON tests tons of goals on tons of machines.
```

DSL to write test units for machines (and everything).
Easily check if a group of real/virtual machines satisfies a list of targets/goals.

![logo](./docs/logo.png)

---

# Introduction

This is an Free Software tool, we use with computers in classroom (STEM laboratory).
This tool helps teachers to evaluate remotely and automaticaly
the workclass done by the students into their machines.

I'm using this application with my students. It's OK, but it could be improved
(as everythieng of course). I would like other users (interested in sysadmin
and teaching) to know it, and receive comments, suggestions or
collaborations to improve it.

Thanks!

---

# Description

Steps to use this tool:

1. **The teacher defines a practice activity** for the group of students.
This is a list of required targets/goals and the way to check it.
1. **Every student does the classwork** into their own Virtual/Real Machines.
1. **The teacher runs TEUTON tool**. The tool automaticaly evaluates
and creates reports of every student.

Nice!

> NOTE
>
> * The student's machines must be remote conection from teacher computer.
> * For now we could use SSH and Telnet protocol.
> * The teacher must has an user/password to get into students machines.

---

# Quick demo

Every TEUTON challenge/activity consists of 2 files. Let's look at this demo:
* `./docs/examples/example-01.rb`: This defines the activity (DSL script).
* `./docs/examples/example-01.yaml`: This file configure every student machine (cases).

Run this demo with:
* `./teuton docs/example/example-01.rb`, or
* `./teuton start docs/example/example-01.rb`.

> **Results**
> * You will see a brief *report on the screen* during execution.
> * The extended *output files* are saved into `./var/example-01/out/` directory.
> * There exists more activities into the `challenges` directory. This is a good place where save your own challenge/activity scripts.

---

# Documentation

* [Videos](./doc/en/videos.md)
* [Installation](./docs/en/installation.md)
* [Examples](./docs/en/examples.md)
* [Create your first activity](./docs/en/first-activity.md)
* [DSL Key words](./docs/en/dsl/README.md)
* [TO-DO list](./TODO.md)

Other languages:
* ES - [Spanish documentation](./docs/es/README.md)

---

# Contact

* **Email**: `teuton.software@protonmail.com`
* **Twitter**: `@teuton`
