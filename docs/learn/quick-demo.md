
[<< back](README.md)

# Quick demo

Every TEUTON challenge (Test Unit) consists of 2 files.
Let's look at example [learn-03-remote-hosts](examples/learn-03-remote-hosts):

| File        | Description         |
| ----------- | ------------------- |
| start.rb    | Defines TEUTON test |
| config.yaml | Configuration file  |

## Running

* Run this demo with `teuton` command: `teuton examples/learn-03-remote-hosts`.
* During execution, progress is showed on screen.

```
$ teuton examples/learn-03-remote-hosts

[INFO] ScriptPath => examples/learn-03-remote-hosts/start.rb
[INFO] ConfigPath => examples/learn-03-remote-hosts/config.yaml
[INFO] TestName   => learn-03-remote-hosts

==================================
Executing [teuton] (version 2.1.0)
[INFO] Running in parallel (2019-11-06 17:35:46 +0000)
Skipping case <Darth Maul>
?FFF?FFF
[INFO] Duration = 10.184    (2019-11-06 17:35:57 +0000)
==================================

CASE RESULTS
+---------+---------------+-------+-------+
| CASE ID | MEMBERS       | GRADE | STATE |
| -       | -             | 0.0   |       |
| case_02 | R2D2          | 0.0   | ?     |
| case_03 | Obiwan Kenobi | 0.0   | ?     |
+---------+---------------+-------+-------+

CONN ERRORS
+---------+---------------+-------+------------------+
| CASE ID | MEMBERS       | HOST  | ERROR            |
| case_02 | R2D2          | host1 | host_unreachable |
| case_03 | Obiwan Kenobi | host1 | host_unreachable |
+---------+---------------+-------+------------------+
```

* Case is every remote host (or group of hosts) been tested.
* "case-01" has been configured "skip=true", so it hasn't been tested.

## Reports

* Detail reports are saved into `var/learn-03-remote-hosts/` output directory.
* Take a look at directory tree:

```bash
var
└── learn-03-remote-hosts
    ├── case-02.txt
    ├── case-03.txt
    └── resume.txt
```

* Only "case-02" and "case-03" has been tested.
* There are TXT output reports for every tested case.
* "resume" report is a resumed list with final results.
* Let's see our example:

```
$ more var/learn-03-remote-hosts/resume.txt

CONFIGURATION
+----------------+------------------------------------------------+
| tt_title       | Executing [teuton] (version 2.1.0)             |
| tt_scriptname  | examples/learn-03-remote-hosts/start.rb        |
| tt_configfile  | examples/learn-03-remote-hosts/config.yaml     |
| host1_username | root                                           |
| host1_password | profesor                                       |
| tt_testname    | learn-03-remote-hosts                          |
| tt_sequence    | false                                          |
+----------------+------------------------------------------------+

CASES
+---------+---------------+-------+-------+
| CASE ID | MEMBERS       | GRADE | STATE |
| -       | -             |     0 |       |
| case_02 | R2D2          |     0 | ?     |
| case_03 | Obiwan Kenobi |     0 | ?     |
+---------+---------------+-------+-------+

CONN ERRORS
+---------+---------------+-------+------------------+
| CASE ID | MEMBERS       | HOST  | ERROR            |
| case_02 | R2D2          | host1 | host_unreachable |
| case_03 | Obiwan Kenobi | host1 | host_unreachable |
+---------+---------------+-------+------------------+

RESULTS
+-------------+---------------------------+
| start_time  | 2019-11-06 17:35:46 +0000 |
| finish_time | 2019-11-06 17:35:57 +0000 |
| duration    | 10.183650893              |
+-------------+---------------------------+
```

* Our hosts are down, so it's not posible stablish connection.
* Let's see case-02 report to read details about test process:

```
$ more var/learn-03-remote-hosts/case-02.txt

CONFIGURATION
+----------------+-----------------------+
| host1_hostname | robots                |
| host1_ip       | 192.168.1.202         |
| host1_password | profesor              |
| host1_username | root                  |
| tt_members     | R2D2                  |
| tt_moodle_id   | r2d2@robot.sw         |
| tt_sequence    | false                 |
| tt_skip        | false                 |
| tt_testname    | learn-03-remote-hosts |
| username       | r2d2                  |
+----------------+-----------------------+

LOGS
   [17:35:50] ERROR: Host 192.168.1.202 unreachable!

GROUPS
- learn 03 remote hosts
   01 (0.0/1.0)
       Description : Update hostname with robots (host1_hostname)
       Command     : hostname
       Duration    : 3.078 (ssh)
       Alterations : find(robots) & count
       Expected    : 1 (String)
       Result      : 0 (Integer)
   02 (0.0/1.0)
       Description : Ensure network DNS configuration is working
       Command     : nslookup www.google.es
       Duration    : 0.0 (ssh)
       Alterations : find(Nombre:) & count
       Expected    : Greater than 0 (String)
       Result      : 0 (Integer)
   03 (0.0/1.0)
       Description : Create user r2d2 (username)
       Command     : net user
       Duration    : 0.0 (ssh)
       Alterations : find(r2d2) & count
       Expected    : Greater than 0 (String)
       Result      : 0 (Integer)

RESULTS
+--------------+---------------------------+
| case_id      | 2                         |
| start_time_  | 2019-11-06 17:35:46 +0000 |
| finish_time  | 2019-11-06 17:35:50 +0000 |
| duration     | 3.078811848               |
| unique_fault | 0                         |
| max_weight   | 3.0                       |
| good_weight  | 0.0                       |
| fail_weight  | 3.0                       |
| fail_counter | 3                         |
| grade        | 0                         |
+--------------+---------------------------+
```

* Final grade is 0, because tests hasn't been verified.
