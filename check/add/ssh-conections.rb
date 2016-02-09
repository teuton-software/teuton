#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Course name : ADD1516
 Activity    : SSH conections
 MV OS       : GNU/Linux Debian 7
=end

check :configurations do
  goto :host1, :execute => "ifconfig| grep HWaddr| tr -s ' ' '%'| cut -d % -f 5"
  unique "MAC[host1]", result.value 

  goto :host2, :execute => "ifconfig| grep HWaddr| tr -s ' ' '%'| cut -d % -f 5"
  unique "MAC[host2]", result.value
end

check :debian_configurations do	
  desc "Zona horaria <WET #{get(:year)}>"
  goto :host1, :execute => "date | grep WET | grep #{get(:year)} | wc -l"
  expect result.equal?(1)

  desc "OS Debian 64 bits"
  goto :host1, :execute => "uname -a| grep Debian| grep 64| wc -l"
  expect result.equal?(1)

  desc "Cheking hostname <"+get(:host1_hostname)+">"
  goto :host1, :execute => "hostname -a"
  expect result.equal?(get(:host1_hostname))
	
  desc "Checking domainname <"+get(:lastname)+">"
  goto :host1, :execute =>  "hostname -d" 
  expect result.equal?(get(:lastname))
	
  desc "Checking username <"+get(:firstname)+">"
  goto :host1, :execute => "cat /etc/passwd|grep '"+get(:firstname)+"'|wc -l"
  expect result.equal?(1)

  desc "Checking groupname <"+get(:groupname)+">"
  goto :host1,  :execute => "cat /etc/group|grep '"+get(:groupname)+"'|wc -l"
  expect result.equal?(1)

  desc "User member of group <"+get(:groupname)+">"
  goto :host1, :execute => "id "+get(:firstname)+"| tr -s ' ' ':'| cut -d : -f 2| grep "+get(:groupname)+"|wc -l"
  expect result.equal?(1)
end

check :ssh_configurations do
  desc "Claves privada y pública en usuario <#{get(:firstname)}>"
  goto :host1, :execute => "vdir /home/#{get(:firstname)}/.ssh/id_*| wc -l"
  expect result.equal?(2)

  goto :host1, :execute => "cat /home/#{get(:firstname)}/.ssh/id_rsa.pub", :tempfile => "mv1_idrsapub.tmp"
  @filename1=tempfile
  	
  desc "Host2 hostname defined on Host1"
  goto :host1, :execute => "cat /etc/hosts| grep #{get(:host2_hostname)}| grep #{get(:host2_ip)}| wc -l"
  expect result.equal?(1)
end

check :opensuse_configurations do
  desc "Zona horaria <WET #{get(:year)}>"
  goto :host2, :execute => "date | grep WET | grep #{get(:year)} | wc -l"
  expect result.equal?(1)

  desc "OS OpenSuse 64 bits"
  goto :host2, :execute => "uname -a| grep opensuse| grep x86_64| wc -l"
  expect result.equal?(1)

  desc "Value hostname == "+get(:host2_hostname)+" "
  goto :host2, :execute => "hostname -a"
  expect result.equal?(get(:host2_hostname))
	
  desc "Value domainname == "+get(:lastname)+" "
  goto :host2, :execute => "hostname -d" 
  expect result.equal?(get(:lastname))

  desc "Exist username <"+get(:firstname)+">"
  goto :host2, :execute => "cat /etc/passwd|grep '"+get(:firstname)+"'|wc -l"
  expect result.equal?(1)

  desc "Checking groupname <"+get(:groupname)+">"
  goto :host1, :execute => "cat /etc/group|grep '"+get(:groupname)+"'|wc -l"
  expect result.equal?(1)

  desc "User maingroup == "+get(:groupname)+" "
  goto :host1, :execute => "id "+get(:firstname)+"| tr -s ' ' ':'| cut -d : -f 2| grep "+get(:groupname)+"|wc -l"
  expect result.equal?(1)
end

check :ssh_configurations_on_host2 do
  desc "Permissions /home/#{get(:firstname)}/.ssh => rwx------"
  goto :host2, :execute => "vdir -a /home/#{get(:firstname)}/ | grep '.ssh'| grep 'rwx------'| wc -l"
  expect result.equal?(1)

  goto :host2, :execute => "cat /home/#{get(:firstname)}/.ssh/authorized_keys", :tempfile => "mv2_authorizedkeys.tmp"
  filename2=tempfile
  	
  desc "mv2(authorized_keys) == mv1(id_rsa.pub)"
  goto :localhost, :execute => "diff #{@filename1} #{filename2}| wc -l"
  expect result.equal?(0)

  desc "mv2: Host1 hostname defined"
  goto :host2, :execute => "cat /etc/hosts| grep #{get(:host1_hostname)}| grep #{get(:host1_ip)}| wc -l"
  expect result.equal?(1)	
end

check :vncserver_configurations_on_host1 do
  desc "Tightvncserver installed on <#{get(:host1_ip)}>"
  goto :host1, :execute => "dpkg -l tightvncserver| grep 'ii'| wc -l"
  expect result.equal?(1)

  goto :localhost, :execute => "nmap -Pn #{get(:host1_ip)}", :tempfile => 'mv1_nmap.tmp'
  filename = tempfile
  
  #command "ps -ef| grep tightvnc| grep geometry| wc -l", :tempfile => 'tightvnc.tmp'
  #vncserver :1
	
  desc "Services 'vnc' on <#{get(:host1_ip)}>"
  goto :localhost, :execute => "cat #{filename}|grep 'vnc'| wc -l"
  expect result.equal?(1)

  desc "Services active on ip/port #{get(:host1_ip)}/6001"
  goto :localhost, :execute => "cat #{filename} |grep '6001'| wc -l"
  expect result.equal?(1)
end

check :git_clone_on_host2 do
  desc "Git installed on <#{get(:host1_ip)}>"
  goto :host1, :execute => "dpkg -l git| grep 'ii'| wc -l"
  expect result.equal?(1)
	
  #desc "Proyect from GitHub cloned on <#{get(:host1_ip)}>"
  #on :host1, :execute => "vdir -a /home/#{get(:username)}/add1314profesor/ | grep '.git'| wc -l"
  #check result.to_i.equal?(1)

  desc "Git installed on <#{get(:host2_ip)}>"
  goto :host2, :execute => "git --version| grep git |grep version| wc -l"
  expect result.equal?(1)
	
  desc "Proyect from GitHub cloned on <#{get(:host2_ip)}>"
  goto :host2, :execute => "vdir -a /home/#{get(:firstname)}/add1314profesor/unit.1/ | grep '.exam_remoto'| wc -l"
  expect result.equal?(1)

  log "Tests finished"
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
  :host1_password: profesor
  :host2_ip: 172.16.109.201
  :host2_password: profesor
- :tt_members: richard stallman
  :firstname: richard
  :lastname: stallman
  :host1_ip: 172.16.109.110
  :host1_password: 78787878v
  :host2_ip: 172.16.109.210
  :host2_password: 78787878v
=end
