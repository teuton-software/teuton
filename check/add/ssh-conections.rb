#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Course name : ADD1516
 Activity    : Commands 01
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

	desc "Exist username <"+get(:username)+">"
	command "cat /etc/passwd|grep '"+get(:username)+"'|wc -l"
	run_on :host2
	check result.to_i.equal?(1)

	desc "Checking groupname <"+get(:groupname)+">"
	command "cat /etc/group|grep '"+get(:groupname)+"'|wc -l"
	run_on :host1
	check result.to_i.equal?(1)

	desc "User maingroup == "+get(:groupname)+" "
	command "id "+get(:username)+"| tr -s ' ' ':'| cut -d : -f 2| grep "+get(:groupname)+"|wc -l"
	run_on :host1
	check result.to_i.equal?(1)
end

def t.test06_mv2_ssh_config
	return if !@alive[:host2]

	desc "Permisos /home/#{get(:username)}/.ssh => rwx------"
	command "vdir -a /home/#{get(:username)}/ | grep '.ssh'| grep 'rwx------'| wc -l"
	run_on :host2
	check result.to_i.equal?(1)

	command "cat /home/#{get(:username)}/.ssh/authorized_keys", :tempfile => "mv2_authorizedkeys.tmp"
	run_on :host2
	
	desc "mv2(authorized_keys) == mv1(id_rsa.pub)"
	s=`cat var/tmp/mv1_idrsapub.tmp`
	s.chop!
	command "cat var/tmp/mv2_authorizedkeys.tmp | grep '#{s}'| wc -l"
	run_on :localhost
	check result.to_i.equal?(1)

	desc "mv2: Host1 hostname defined"
	command "cat /etc/hosts| grep #{get(:host1_hostname)}| grep #{get(:host1_ip)}| wc -l"
	run_on :host2
	check result.to_i.equal?(1)	
end

def t.test07_mv1_vncserver
	return if !@alive[:host1]

	desc "Tightvncserver installed on <#{get(:host1_ip)}>"
	command "dpkg -l tightvncserver| grep 'ii'| wc -l"
	run_on :host1
	check result.to_i.equal?(1)

	command "nmap -Pn #{get(:host1_ip)}", :tempfile => 'mv1_nmap.tmp'
	run_on :localhost
	
	#command "ps -ef| grep tightvnc| grep geometry| wc -l", :tempfile => 'tightvnc.tmp'
	#vncserver :1
	
	desc "Services 'vnc' on <#{get(:host1_ip)}>"
	command "cat var/tmp/mv1_nmap.tmp|grep 'vnc'| wc -l"
	run_on :localhost
	check result.to_i.equal?(1)

	desc "Services active on ip/port #{get(:host1_ip)}/6001"
	command "cat var/tmp/mv1_nmap.tmp |grep '6001'| wc -l"
	run_on :localhost
	check result.to_i.equal?(1)
end

def t.test08_mv2_git_clone
	return if !@alive[:host2]

	desc "Git installed on <#{get(:host1_ip)}>"
	command "dpkg -l git| grep 'ii'| wc -l"
	run_on :host1
	check result.to_i.equal?(1)
	
	#desc "Proyect from GitHub cloned on <#{get(:host1_ip)}>"
	#command "vdir -a /home/#{get(:username)}/add1314profesor/ | grep '.git'| wc -l"
	#run_on :host1
	#check result.to_i.equal?(1)

	desc "Git installed on <#{get(:host2_ip)}>"
	command "git --version| grep git |grep version| wc -l"
	run_on :host2
	check result.to_i.equal?(1)
	
	desc "Proyect from GitHub cloned on <#{get(:host2_ip)}>"
	command "vdir -a /home/#{get(:username)}/add1314profesor/unit.1/ | grep '.exam_remoto'| wc -l"
	run_on :host2
	check result.to_i.equal?(1)

	log "Tests finished"
end

start do
	show :resume
	export :all
end
