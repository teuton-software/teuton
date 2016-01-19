#SYSADMIN-GAME

#Introduction

With this tool, a teacher defines a practice activity for the students.
In some way, we have a check list, that define the required goals. 
The students do the classwork on their own Virtual Machines. 
And at the end, the teacher evaluate using this tool.
We obtain automaticaly, the results of every student

#Quick demo

Let's run our first demo activity doing `./check/demos/demo1-localhost.rb`.
You will see the resumed results on the screen.

Several output files are created into `/var/demo1-localhost/out/` directory, 
with the test results of every case/student.

We use a YAML configuration file `.check/demos/demo1-localhost.yaml`, 
that containts data configuration for every case. Modifing this configuration file
the same activity will work with diferents hosts into diferent situations.

#Documentation
* [Installation](./docs/en/installation.md)
* [Create our first activity](./docs/en/first-activity.md)
* [DSL Key words](./docs/en/dsl-key-words.md)
