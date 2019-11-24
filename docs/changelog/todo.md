
# TO-DO list

List of things to do, classified into 3 sections:
* (A) I know read and write.
* (B) I work as IT teacher
* (C) I want to program ruby language

> I write this list without any criteria.
> Only an unordered list of interesting/usefull things to be done.

## Section A

Documentation

* Revise Spanish docs (ES - Mejorar la documentación en español)
* Revise English documents. Update english version with changes done into spanish version.
* Make videos showing how to use this tool
    * Video about download and install this tool
    * Test installation scripts
    * Vídeo with Windows installation.
    * Video using examples 01 to 05...
* Write a special documentation for novice

## Section B

* Create your own (simple or complex) educational test.
* Upload your own educational test to this repository.

## Section C

* `goto :host1, :puppet => "Puppet instructions"`
* `goto :host1, :chef => "Chef instructions"`
* `result.test("...")`
* `send :email_to => :members_emails`

Gamification
* When students demand help they could recibe some advises.
* Define a loop of executions of our activity. For example:
  every 5 minutes, run the activity, and repeat this 10 times.
  `start :times=>10, :duration=>5 do`      
* More ideas: bonus, lives, etc.

Create 2 evaluation modes:
1. Evaluate targets (current mode): `start :score=>:targets do ...`
1. Evaluate task: `start :score=>:tasks do ...`
