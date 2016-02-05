#Installation process and required software.

##Teacher host
One hosts must controll the process. It's the hosts used by the teacher.

* Software required on the teacher host: 
   * SSH client software: Used to connect with the others hosts.
   * `rake --version` =>10.4.2
   * `ruby -v` => 2.1.3p242
* Installation process:
   * Download this project.
   * `cd sysadmin-game`
   * `rake install_gems`: to install required ruby gems on your system.

##Remote hosts
The remote hosts are every host used by the students to perform the activity.
Sometimes every student needs only one, but in other activities every student
must need more.

All this hosts need to be monitorized by the teacher hosts.

* Software required on every remote host:
   * SSH server software installed on remote every machine.
   * Superuser password must be known by the teacher.
