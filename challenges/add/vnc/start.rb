
=begin
 State       : In progress...
 Course name : ADD1516
 Activity    : Remote access using VNC
 MV OS       : GNU/Linux OpenSUSE, Windows7 and Windows2012server
 Spanish URL : https://github.com/dvarrui/libro-de-actividades/blob/master/actividades/add/vnc/README.md

TODO:
* netstat -ntap
* nmap -Pn
* zypper se
=end

task "Ensuring that very HOST is unique" do
  goto :host1, :exec => "ifconfig| grep HWaddr| tr -s ' ' '%'| cut -d % -f 5"
  unique "MAC[host1]", result.value

  goto :host2, :exec => "ifconfig| grep HWaddr| tr -s ' ' '%'| cut -d % -f 5"
  unique "MAC[host2]", result.value
end

task "Configuring Debian host" do
  target "Time zone <WET #{get(:year)}>"
  goto   :host1, :exec => "date | grep WET | grep #{get(:year)} | wc -l"
  expect result.equal(1)

  target "OS Debian 64 bits"
  goto   :host1, :exec => "uname -a| grep Debian| grep 64| wc -l"
  expect result.equal(1)

  target "Hostname => "+get(:host1_hostname)
  goto   :host1, :exec => "hostname -a"
  expect result.equal(get(:host1_hostname))

  target "Domainname => "+get(:lastname)
  goto   :host1, :exec =>  "hostname -d"
  expect result.equal(get(:lastname))

  target "Username => "+get(:firstname)
  goto   :host1, :exec => "cat /etc/passwd|"
  expect result.grep!(get(:firstname)).count!.equal(1)

  target "Checking groupname <"+get(:groupname)+">"
  goto   :host1,  :exec => "cat /etc/group|grep '"+get(:groupname)+"'|wc -l"
  expect result.equal(1)

  target "User member of group <"+get(:groupname)+">"
  goto :host1, :exec => "id "+get(:firstname)+"| tr -s ' ' ':'| cut -d : -f 2| grep "+get(:groupname)+"|wc -l"
  expect result.equal(1)
end

task "Configure Debian SSH" do
  target "Claves privada y pública en usuario <#{get(:firstname)}>"
  goto   :host1, :exec => "vdir /home/#{get(:firstname)}/.ssh/id_*| wc -l"
  expect result.equal(2)

  goto :host1, :exec => "cat /home/#{get(:firstname)}/.ssh/id_rsa.pub", :tempfile => "mv1_idrsapub.tmp"
  @filename1 = tempfile

  target "Host2 hostname defined on Host1"
  goto :host1, :exec => "cat /etc/hosts| grep #{get(:host2_hostname)}| grep #{get(:host2_ip)}| wc -l"
  expect result.equal(1)
end

task "Configure OpenSUSE host" do
  target "Zona horaria <WET #{get(:year)}>"
  goto :host2, :exec => "date | grep WET | grep #{get(:year)} | wc -l"
  expect result.equal(1)

  target "OS OpenSuse 64 bits"
  goto :host2, :exec => "uname -a| grep opensuse| grep x86_64| wc -l"
  expect result.equal(1)

  target "Value hostname == "+get(:host2_hostname)+" "
  goto :host2, :exec => "hostname -a"
  expect result.equal(get(:host2_hostname))

  target "Value domainname == "+get(:lastname)+" "
  goto :host2, :exec => "hostname -d"
  expect result.equal(get(:lastname))

  target "Exist username <"+get(:firstname)+">"
  goto :host2, :exec => "cat /etc/passwd|grep '"+get(:firstname)+"'|wc -l"
  expect result.equal(1)

  target "Checking groupname <"+get(:groupname)+">"
  goto :host1, :exec => "cat /etc/group|grep '"+get(:groupname)+"'|wc -l"
  expect result.equal(1)

  target "User maingroup == "+get(:groupname)+" "
  goto :host1, :exec => "id "+get(:firstname)+"| tr -s ' ' ':'| cut -d : -f 2| grep "+get(:groupname)+"|wc -l"
  expect result.equal(1)
end

task "Configure Debian VNC server" do
  target "Tightvncserver installed on <#{get(:host1_ip)}>"
  goto :host1, :exec => "dpkg -l tightvncserver| grep 'ii'| wc -l"
  expect result.equal(1)

  goto :localhost, :exec => "nmap -Pn #{get(:host1_ip)}", :tempfile => 'mv1_nmap.tmp'
  filename = tempfile

  #command "ps -ef| grep tightvnc| grep geometry| wc -l", :tempfile => 'tightvnc.tmp'
  #vncserver :1

  target "Services 'vnc' on <#{get(:host1_ip)}>"
  goto :localhost, :exec => "cat #{filename}|grep 'vnc'| wc -l"
  expect result.equal(1)

  target "Services active on ip/port #{get(:host1_ip)}/6001"
  goto :localhost, :exec => "cat #{filename} |grep '6001'| wc -l"
  expect result.equal(1)
end

start do
	show
	export
end

=begin
---
:global:
  :groupname: udremote
  :host1_username: root
  :host1_hostname: debian
  :host2_username: root
  :host2_hostname: opensuse
  :year: '2015'
:cases:
- :tt_members: David Vargas
  :firstname: david
  :lastname: vargas
  :host1_ip: 172.16.109.101
  :host1_password: toor
  :host2_ip: 172.16.109.201
  :host2_password: toor
...
=end
