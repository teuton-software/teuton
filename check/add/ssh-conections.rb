#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Course name : ADD1516
 Activity    : SSH conections
 MV OS       : GNU/Linux Debian 7
=end

check :configurations do
  on :host1, :execute => "ifconfig| grep HWaddr| tr -s ' ' '%'| cut -d % -f 5"
  unique "MAC[host1]", result.value 

  on :host2, :execute => "ifconfig| grep HWaddr| tr -s ' ' '%'| cut -d % -f 5"
  unique "MAC[host2]", result.value
end

check :debian_configurations do	
  desc "Zona horaria <WET #{get(:year)}>"
  on :host1, :execute => "date | grep WET | grep #{get(:year)} | wc -l"
  expect result.to_i.equal?(1)

  desc "OS Debian 64 bits"
  on :host1, :execute => "uname -a| grep Debian| grep 64| wc -l"
  expect result.to_i.equal?(1)

  desc "Cheking hostname <"+get(:host1_hostname)+">"
  on :host1, :execute => "hostname -a"
  expect result.to_s.equal?(get(:host1_hostname))
	
  desc "Checking domainname <"+get(:lastname)+">"
  on :host1, :execute =>  "hostname -d" 
  expect result.to_s.equal?(get(:lastname))
	
  desc "Checking username <"+get(:firstname)+">"
  on :host1, :execute => "cat /etc/passwd|grep '"+get(:firstname)+"'|wc -l"
  expect result.to_i.equal?(1)

  desc "Checking groupname <"+get(:groupname)+">"
  on :host1,  :execute => "cat /etc/group|grep '"+get(:groupname)+"'|wc -l"
  expect result.to_i.equal?(1)

  desc "User member of group <"+get(:groupname)+">"
  on :host1, :execute => "id "+get(:firstname)+"| tr -s ' ' ':'| cut -d : -f 2| grep "+get(:groupname)+"|wc -l"
  expect result.to_i.equal?(1)
end

check :ssh_configurations do
  desc "Claves privada y pública en usuario <#{get(:firstname)}>"
  on :host1, :execute => "vdir /home/#{get(:firstname)}/.ssh/id_*| wc -l"
  expect result.to_i.equal?(2)

  on :host1, :execute => "cat /home/#{get(:firstname)}/.ssh/id_rsa.pub", :tempfile => "mv1_idrsapub.tmp"
  @filename1=tempfile
  	
  desc "Host2 hostname defined on Host1"
  on :host1, :execute => "cat /etc/hosts| grep #{get(:host2_hostname)}| grep #{get(:host2_ip)}| wc -l"
  expect result.to_i.equal?(1)
end

check :opensuse_configurations do
  desc "Zona horaria <WET #{get(:year)}>"
  on :host2, :execute => "date | grep WET | grep #{get(:year)} | wc -l"
  expect result.to_i.equal?(1)

  desc "OS OpenSuse 64 bits"
  on :host2, :execute => "uname -a| grep opensuse| grep x86_64| wc -l"
  expect result.to_i.equal?(1)

  desc "Value hostname == "+get(:host2_hostname)+" "
  on :host2, :execute => "hostname -a"
  expect result.to_s.equal?(get(:host2_hostname))
	
  desc "Value domainname == "+get(:lastname)+" "
  on :host2, :execute => "hostname -d" 
  expect result.to_s.equal?(get(:lastname))

  desc "Exist username <"+get(:firstname)+">"
  on :host2, :execute => "cat /etc/passwd|grep '"+get(:firstname)+"'|wc -l"
  expect result.to_i.equal?(1)

  desc "Checking groupname <"+get(:groupname)+">"
  on :host1, :execute => "cat /etc/group|grep '"+get(:groupname)+"'|wc -l"
  expect result.to_i.equal?(1)

  desc "User maingroup == "+get(:groupname)+" "
  on :host1, :execute => "id "+get(:firstname)+"| tr -s ' ' ':'| cut -d : -f 2| grep "+get(:groupname)+"|wc -l"
  expect result.to_i.equal?(1)
end

check :ssh_configurations_on_host2 do
  desc "Permissions /home/#{get(:firstname)}/.ssh => rwx------"
  on :host2, :expect => "vdir -a /home/#{get(:firstname)}/ | grep '.ssh'| grep 'rwx------'| wc -l"
  expect result.to_i.equal?(1)

  on :host2, :execute => "cat /home/#{get(:firstname)}/.ssh/authorized_keys", :tempfile => "mv2_authorizedkeys.tmp"
  filename2=tempfile
  	
  desc "mv2(authorized_keys) == mv1(id_rsa.pub)"
  on :localhost, :execute => "diff #{@filename1} #{filename2}| wc -l"
  expect result.to_i.equal?(0)

  desc "mv2: Host1 hostname defined"
  on :host2, :execute => "cat /etc/hosts| grep #{get(:host1_hostname)}| grep #{get(:host1_ip)}| wc -l"
  expect result.to_i.equal?(1)	
end

check :vncserver_configurations_on_host1 do
  desc "Tightvncserver installed on <#{get(:host1_ip)}>"
  on :host1, :execute => "dpkg -l tightvncserver| grep 'ii'| wc -l"
  expect result.to_i.equal?(1)

  on :localhost, :execute => "nmap -Pn #{get(:host1_ip)}", :tempfile => 'mv1_nmap.tmp'
  filename = tempfile
  
  #command "ps -ef| grep tightvnc| grep geometry| wc -l", :tempfile => 'tightvnc.tmp'
  #vncserver :1
	
  desc "Services 'vnc' on <#{get(:host1_ip)}>"
  on :localhost, :execute => "cat #{filename}|grep 'vnc'| wc -l"
  expect result.to_i.equal?(1)

  desc "Services active on ip/port #{get(:host1_ip)}/6001"
  on :localhost, :execute => "cat #{filename} |grep '6001'| wc -l"
  expect result.to_i.equal?(1)
end

check :git_clone_on_host2 do
  desc "Git installed on <#{get(:host1_ip)}>"
  on :host1, :execute => "dpkg -l git| grep 'ii'| wc -l"
  expect result.to_i.equal?(1)
	
  #desc "Proyect from GitHub cloned on <#{get(:host1_ip)}>"
  #on :host1, :execute => "vdir -a /home/#{get(:username)}/add1314profesor/ | grep '.git'| wc -l"
  #check result.to_i.equal?(1)

  desc "Git installed on <#{get(:host2_ip)}>"
  on :host2, :execute => "git --version| grep git |grep version| wc -l"
  expect result.to_i.equal?(1)
	
  desc "Proyect from GitHub cloned on <#{get(:host2_ip)}>"
  on :host2, :execute => "vdir -a /home/#{get(:firstname)}/add1314profesor/unit.1/ | grep '.exam_remoto'| wc -l"
  expect result.to_i.equal?(1)

  log "Tests finished"
end

start do
	show :resume
	export :all, :format => :txt
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
