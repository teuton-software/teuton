#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../sys/teacher1'

=begin
 Curso 1314
 IDP U1 Actividad 2
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

def t.test02_unique_values
	command "ifconfig"
	tempfile "ifconfig.tmp"
	run_from :host1
	
	value=`cat var/tmp/ifconfig.tmp| grep HWaddr| tr -s ' ' '%'| cut -d % -f 5`
	unique value.chop, "MAC eth0"
	
	command "vdir /dev/disk/by-uuid"
	tempfile "disk-by-uuid.tmp"
	run_from :host1
	
	value=`cat var/tmp/disk-by-uuid.tmp| grep sda1| tr -s ' ' '%'| cut -d % -f 9`
	unique value.chop, "uuid sda1"

	value=`cat var/tmp/disk-by-uuid.tmp| grep sda2| tr -s ' ' '%'| cut -d % -f 9`
	unique value.chop, "uuid sda2"

	value=`cat var/tmp/disk-by-uuid.tmp| grep sda5| tr -s ' ' '%'| cut -d % -f 9`
	unique value.chop, "uuid sda5"

	value=`cat var/tmp/disk-by-uuid.tmp| grep sda6| tr -s ' ' '%'| cut -d % -f 9`
	unique value.chop, "uuid sda6"

	value=`cat var/tmp/disk-by-uuid.tmp| grep sda7| tr -s ' ' '%'| cut -d % -f 9`
	unique value.chop, "uuid sda7"
end

def t.test03_check_opensuse
	return if !@alive
	
	#variables defined with the same value for every case
	lsYear='2013'
	
	command "date | grep WEST | grep #{lsYear} | wc -l"
	description "Zona horaria WEST"
	run_from :host1
	check result.to_i.equal?(1)

	command "cat /etc/passwd|grep '"+get(:username)+"'|wc -l"
	description "Checking username <"+get(:username)+">"
	run_from :host1
	check result.to_i.equal?(1)

	command "hostname| cut -d . -f 1"
	description "Cheking hostname <"+get(:hostname)+">"
	run_from :host1
	check result.to_s.equal?(get(:hostname))
	
	command "hostname| cut -d . -f 2" 
	description "Checking domainname <"+get(:domainname)+">"
	run_from :host1
	check result.to_s.equal?(get(:domainname))

	command "vdir /etc/sysconfig/yast2| wc -l 2>/dev/null"
	description "SO OpenSUSE installed"
	run_from :host1
	check result.to_i.equal?(1)
    
	command "fdisk -l"
	tempfile 'fdiskl.tmp'
	run_from :host1

	command "cat var/tmp/fdiskl.tmp| grep -v Dis| grep '/dev/sd'| wc -l"
	description "Número de particiones 6"
	run_from :localhost
	check result.to_i.equal?(6)
	
	command "cat var/tmp/fdiskl.tmp |grep Dis|tr -s ' ' ':'|tr ',' '.'|cut -f 3 -d :"
	description "Tamaño del disco 18GB"
	run_from :localhost
	check result.to_f.is_near_to?(18)

	command "cat var/tmp/fdiskl.tmp |grep NTFS| grep '/dev/sda1'| wc -l"
	description "Partición sda1 primaria NTFS"
	run_from :localhost
	check result.to_i.equal?(1)

	command "cat var/tmp/fdiskl.tmp |grep FAT32| grep '/dev/sda2'| wc -l"
	description "Partición sda2 primaria FAT32"
	run_from :localhost
	check result.to_i.equal?(1)

	command "cat var/tmp/fdiskl.tmp |grep Extendida| grep '/dev/sda3'| wc -l"
	description "Partición sda3 Extendida"
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

	command "df -hT"
	tempfile 'dfhT.tmp'
	run_from :host1

	command "cat var/tmp/dfhT.tmp | grep '/dev/sda7'| grep ext4| wc -l"
	description "Partición raíz es ext4"
	run_from :localhost
	check result.to_i.equal?(1)

	command "cat var/tmp/dfhT.tmp | grep '/dev/sda7'| tr -s ' ' ':'| tr ',' '.'|cut -f 3 -d :"
	description "System partition size"
	run_from :localhost
	check result.to_f.is_near_to?(5)

	command "cat var/tmp/dfhT.tmp | grep home| grep ext3| wc -l"
	description "Partición home es ext3"
	run_from :localhost
	check result.to_i.equal?(1)

	command "cat var/tmp/dfhT.tmp | grep home| tr -s ' ' ':'| tr ',' '.'|cut -f 3 -d :"
	description "Home partition size 100"
	run_from :localhost
	check result.to_f.is_near_to?(100)

	command "mount"
	tempfile 'mount.tmp'
	run_from :host1

	command "cat var/tmp/mount.tmp | grep '/dev/sda'| wc -l"
	description "Mounted partitions=2"
	run_from :localhost
	check result.to_i.equal?(2)
	
	command "cat /boot/grub2/grub.cfg| grep menuentry| grep 'Windows 7'| wc -l"
	description "Exists 'Windows 7' menuentry"
	run_from :host1
	check result.to_i.equal?(1)
end

def t.test04_check_windows
	return if !@alive

	command "mkdir /mnt/ntfs; mount /dev/sda1 /mnt/ntfs"
	run_from :host1

	command "cd /mnt/ntfs/Users; vdir"
	tempfile "ntfs-users.tmp"
	run_from :host1

	command "cd /; umount /mnt/ntfs; rmdir /mnt/ntfs"
	run_from :host1

	command "cat var/tmp/ntfs-users.tmp| grep #{get(:username)}| wc -l"
	description "Exists user <#{get(:username)}> on SO#1"
	run_from :localhost
	check result.to_i.equal?(1)

	log "Tests finished"
end

t.process  File.join(File.dirname(__FILE__),'u01-act02.yaml')

t.report.show
t.report.export :txt

