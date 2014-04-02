#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../sys/teacher1'

=begin
 Curso 1314
 IDP U1 Actividad 1
 David Vargas Ruiz
=end


t = Teacher.new

def t.test01_ping_host
	#Quick test to check is the host is alive or not
	@alive=false

	result = `ping -q -c 1 -i 0.3 #{get(:host1_ip)}`
	if ($?.exitstatus == 0) then
		@alive=true
	end
	
end

def t.test02_check_config
	return if !@alive
	
	#variables defined with the same value for every case
	lsYear='2013'
	lsDefault_os='deb7'
	
	command "date | grep WEST | grep #{lsYear} | wc -l"
	description "Zona horaria WEST"
	run_from :host1
	check result.to_i.equal?(1)

	command "cat /etc/passwd|grep '"+get(:username)+"'|wc -l"
	description "Checking username <"+get(:username)+">"
	run_from :host1
	check result.to_i.equal?(1)

	command "hostname"
	description "Cheking hostname <"+get(:hostname)+">"
	run_from :host1
	check result.to_s.equal?(get(:hostname))
	
	command "dnsdomainname"
	description "Checking dnsdomainname <"+get(:domainname)+">"
	run_from :host1
	check result.to_s.equal?(get(:domainname))

	command "dir /etc/rc2.d/*dm| wc -l"
	description "We don't need GUI installed"
	run_from :host1
	check result.to_i.equal?(0)

	#Some students used debian6 instead of debian7
	if get(:os)=='debian6' then
		log "OS mode = <#{get(:os)}>"
		command "uname -a| grep Linux |wc -l"
	else
		command "uname -a| grep #{lsDefault_os} | grep #{get(:hostname)} |wc -l"
    end
	description "SO Debian instalado"
	run_from :host1
	check result.to_i.equal?(1)
    
	command "fdisk -l"
	tempfile 'fdiskl.tmp'
	run_from :host1

	command "cat var/tmp/fdiskl.tmp| grep -v Dis| grep '/dev/sd'| wc -l"
	description "Número de particiones 5"
	run_from :localhost
	check result.to_i.equal?(5)
	
	command "cat var/tmp/fdiskl.tmp |grep Dis|tr -s ' ' ':'|tr ',' '.'|cut -f 3 -d :"
	description "Tamaño del disco 10GB"
	run_from :localhost
	check result.to_f.is_near_to?(10)

	command "cat var/tmp/fdiskl.tmp |grep Extendida| grep '/dev/sda1'| wc -l"
	description "Partición sda1 extendida"
	run_from :localhost
	check result.to_i.equal?(1)

	command "cat var/tmp/fdiskl.tmp |grep swap| grep '/dev/sda5'| wc -l"
	description "Partición sda5 swap"
	run_from :localhost
	check result.to_i.equal?(1)

	command "cat var/tmp/fdiskl.tmp |grep Linux| grep '/dev/sda6'| wc -l"
	description "Partición sda6 lógica"
	run_from :localhost
	check result.to_i.equal?(1)

	command "cat var/tmp/fdiskl.tmp |grep Linux| grep '/dev/sda7'| wc -l"
	description "Partición sda7 lógica"
	run_from :localhost
	check result.to_i.equal?(1)

	command "cat var/tmp/fdiskl.tmp |grep Linux| grep '/dev/sda8'| wc -l"
	description "Partición sda8 lógica"
	run_from :localhost
	check result.to_i.equal?(1)

	command "df -hT"
	tempfile 'dfhT.tmp'
	run_from :host1

	if get(:os)=='debian6' then
		command "cat var/tmp/dfhT.tmp | grep '/dev/sda6'| grep ext4| wc -l"
	else
		command "cat var/tmp/dfhT.tmp | grep uuid| grep ext4| wc -l"
	end
	description "Partición raíz es ext4"
	run_from :localhost
	check result.to_i.equal?(1)

	if get(:os)=='debian6' then
		command "cat var/tmp/dfhT.tmp | grep '/dev/sda6'| tr -s ' ' ':'| tr ',' '.'|cut -f 3 -d :"
	else
		command "cat var/tmp/dfhT.tmp | grep uuid| tr -s ' ' ':'| tr ',' '.'|cut -f 3 -d :"
	end
	description "Tamaño partición raíz"
	run_from :localhost
	check result.to_f.is_near_to?(7)

	command "cat var/tmp/dfhT.tmp | grep home| grep ext3| wc -l"
	description "Partición home es ext3"
	run_from :localhost
	check result.to_i.equal?(1)

	command "cat var/tmp/dfhT.tmp | grep home| tr -s ' ' ':'| tr ',' '.'|cut -f 3 -d :"
	description "Tamaño partición home 500"
	run_from :localhost
	check result.to_f.is_near_to?(500)

	command "mount"
	tempfile 'mount.tmp'
	run_from :host1

	if get(:os)=='debian6' then
		command "cat var/tmp/mount.tmp | grep '/dev/sd'| wc -l"
		description "Nº particiones montadas 2"
		run_from :localhost
		check result.to_i.equal?(2)
	else
		command "cat var/tmp/mount.tmp | grep '/dev/sd'| wc -l"
		description "Nº particiones montadas 1"
		run_from :localhost
		check result.to_i.equal?(1)
	end

	log "Los Tests han acabado"
end

t.process File.join(File.dirname(__FILE__),'u01-act01.yaml')

t.report.show
t.report.export :txt

