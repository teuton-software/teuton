[<< back](README.md)

# Moodle

As a teacher, probably you are using Moodle platform. So, you want to upload the results of the evaluation carried out by Teuton into Moodle.

Teuton generates a file called `moodle.csv` with the grades of each student into CSV format. This file is suitable to import into Moodle platform.

## tt_moodle_id

Add a new field called `tt_moodle_id` to each case in "config.yaml". Fill it with the student's Moodle identification. For example, registered email on or ID number on Moodle platform.

Example:

```
global:
cases:
- tt_members: Darth Vader
  tt_moodle_id: vader@starwars.com
- tt_members: Obiwan Kenobi
  tt_moodle_id: obiwan@starwars.com
```

Now, when after test execution, use "moodle.csv" output file to load students grades and feedback into your Moodle platform.
