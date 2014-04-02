#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../sys/teacher'

=begin
 Course   : 1314 
 Module   : IDP (Module) 
 Unit     : Remote
 Activity : Exam
 Author   : David Vargas Ruiz
=end

t = Teacher.new

def t.test01_ping_host
	#Quick test to check if is the host alive or not
	@alive={}
	@alive[:host1]=false
	@alive[:host2]=false

	result = `ping -q -c 1 -i 0.3 #{get(:host1_ip)}`
	if ($?.exitstatus == 0) then
		@alive[:host1]=true
	end
	verbose("host1[#{@alive[:host1]}],")
	
	result = `ping -q -c 1 -i 0.3 #{get(:host2_ip)}`
	if ($?.exitstatus == 0) then
		@alive[:host2]=true
	end
	verbose("host2[#{@alive[:host2]}],")

	@alive[:all]= @alive[:host1] and @alive[:host2]
end

def t.test02_unique_values
	if @alive[:host1] then
		command "ifconfig", :tempfile => "ifconfig1.tmp"
		run_on :host1
	
		value=`cat var/tmp/ifconfig1.tmp| grep HWaddr| tr -s ' ' '%'| cut -d % -f 5`
		unique value.chop, "host1 MAC"
	end
	
	if @alive[:host2] then
		command "ifconfig", :tempfile => "ifconfig2.tmp"
		run_on :host2
	
		value=`cat var/tmp/ifconfig2.tmp| grep HWaddr| tr -s ' ' '%'| cut -d % -f 5`
		unique value.chop, "host2 MAC"
	end
end

def t.test03_mv1_debian_config
	return if !@alive[:host1]
	
	#variables defined with the same value for every case
	lsYear='2013'
	
	desc "Zona horaria <WET #{lsYear}>"
	command "date | grep WET | grep #{lsYear} | wc -l"
	run_on :host1
	check result.to_i.equal?(1)

	desc "OS Debian 64 bits"
	command "uname -a| grep Debian| grep 64| wc -l"
	run_on :host1
	check result.to_i.equal?(1)

	desc "Cheking hostname <"+get(:host1_hostname)+">"
	command "hostname -a"
	run_on :host1
	check result.to_s.equal?(get(:host1_hostname))
	
	desc "Checking domainname <"+get(:domainname)+">"
	command "hostname -d" 
	run_on :host1
	check result.to_s.equal?(get(:domainname))
	
	desc "Checking username <"+get(:username)+">"
	command "cat /etc/passwd|grep '"+get(:username)+"'|wc -l"
	run_on :host1
	check result.to_i.equal?(1)

	desc "Checking groupname <"+get(:groupname)+">"
	command "cat /etc/group|grep '"+get(:groupname)+"'|wc -l"
	run_on :host1
	check result.to_i.equal?(1)

	desc "User member of group <"+get(:groupname)+">"
	command "id "+get(:username)+"| tr -s ' ' ':'| cut -d : -f 2| grep "+get(:groupname)+"|wc -l"
	run_on :host1
	check result.to_i.equal?(1)
end

def t.test04_mv1_ssh_config
	return if !@alive[:host1]

	desc "Claves privada y pública en usuario <#{get(:username)}>"
	command "vdir /home/#{get(:username)}/.ssh/id_*| wc -l"
	run_on :host1
	check result.to_i.equal?(2)

	command "cat /home/#{get(:username)}/.ssh/id_rsa.pub", :tempfile => "mv1_idrsapub.tmp"
	run_on :host1
	
	desc "Host2 hostname defined on Host1"
	command "cat /etc/hosts| grep #{get(:host2_hostname)}| grep #{get(:host2_ip)}| wc -l"
	run_on :host1
	check result.to_i.equal?(1)
	
end

def t.test05_mv2_opensuse_config
	return if !@alive[:host2]
	
	#variables defined with the same value for every case
	lsYear='2013'
	
	desc "Zona horaria <WET #{lsYear}>"
	command "date | grep WET | grep #{lsYear} | wc -l"
	run_on :host2
	check result.to_i.equal?(1)

	desc "OS OpenSuse 64 bits"
	command "uname -a| grep opensuse| grep x86_64| wc -l"
	run_on :host2
	check result.to_i.equal?(1)

	desc "Value hostname == "+get(:host2_hostname)+" "
	command "hostname -a"
	run_on :host2
	check result.to_s.equal?(get(:host2_hostname))
	
	desc "Value domainname == "+get(:domainname)+" "
	command "hostname -d" 
	run_on :host2
	check result.to_s.equal?(get(:domainname))

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

t.process  File.join(File.dirname(__FILE__),'ud-remote-exam2.yaml')

t.report.show
t.report.export :txt

