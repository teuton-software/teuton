[<< back](README.md)

# Example: 11-moodle_id

If you are a teacher and are using the Moodle platform, probably you will want to upload the results of the evaluation carried out by Teuton in Moodle.

Teuton generates a file called "moodle.csv" with the grades of each student. Only have to import the file into Moodle.

In the configuration file "config.yaml" add a field called "moodle_id" to each case. Fill it with the student's identification (For example, the email registered on the Moodle).

Example:
```
global:
cases:
- tt_members: Darth Vader
  tt_moodle_id: vader@starwars.com
- tt_members: Obiwan Kenobi
  tt_moodle_id: obiwan@starwars.com
```
