#Installation process and required software.

##Teacher host
One hosts must controll the process. It's the hosts used by the teacher.

* Software required on the teacher host:
   * SSH client software: Used to connect with the others hosts.
   * `ruby -v` => 2.1.3p242
   * `rake --version` =>10.4.2
* Installation process:
   * Install ruby (`apt-get install ruby` on Debian, `zypper in ruby` on OpenSUSE, etc)
   * Install rake (`gem install rake`)
   * Download this project.
   * `cd sysadmin-game`
   * `rake gems`: to install required ruby gems on your system.

> Example clone using `git` command:
> ![git-clone](../images/git-clone.png)
>
> Test `ruby`, `rake` versions, before gems (libraries) installation:
> ![ruby-rake-gems](../images/ruby-rake-gems.png)
>
> Error happens when we haven't `ruby` version >= 2.0:
> ![error-version](../images/error-version.png)

##Remote hosts
The remote hosts are every host used by the students to perform the activity.
Sometimes every student needs only one, but in other activities every student
must need more.

All this hosts need to be monitorized by the teacher hosts.

* Software required on every remote host:
   * SSH server software installed on remote every machine.
   * Superuser password must be known by the teacher.
