
# Installation process and required software.

## Teacher host

One hosts must controll the process. It's the hosts used by the teacher.

Software required on the teacher host:
* SSH client software: Used to connect with the others hosts.
* `ruby -v` => 2.1.3p242
* `rake --version` =>10.4.2

Installation process:
* Install ruby (`apt-get install ruby` on Debian, `zypper in ruby` on OpenSUSE, etc)
* Install rake (`gem install rake`)
* Get the project by:
    * Downloading it or
    * Cloning with git `git clone https://github.com/dvarrui/teuton.git`
* `cd teuton`

Choose between:
* `rake opensuse`: for OpenSUSE installation
* `rake debian`: for Debian installation
* `rake gems`: to install required ruby gems on your system.

---

## Remote hosts

The remote hosts are every host used by the students to perform the activity.
Sometimes every student needs only one, but in other activities every student
must need more.

All this hosts need to be monitorized by the teacher hosts.

Software required on every remote host:
* SSH server software installed on remote every machine.
* Superuser password must be known by the teacher.
