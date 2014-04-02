#!/usr/bin/ruby
# encoding: utf-8

=begin
Script de autocorreción de la actividad: A1-raid-software

 David Vargas Ruiz
 davidvargas.tenerife@gmail.com
=end

require './sys/teacher.rb'

tester = Teacher.new

def tester.init
	@ip='172.16.209.1'
	#@ip='192.168.1.104'
	@username='root'
	@password='profesor'
end

def tester.step01_nmap	
	c='nmap '+@ip+' | grep 22 | grep ssh | wc -l'
	r=exec_cmd_and_read_output(c)
	
	test(r[0].to_i==1,"Scanning 22 port on <"+@ip+">: "+c)
end

def tester.step02_df	
	c="df -hT|grep /dev/md0|grep '/'|wc -l"
	r = exec_ssh_cmd_read_output(@ip, @username, @password, c, "step2_raid0.tmp")
	
	test(r[0].to_i==1,"File content must be 1")

	c="df -hT|grep /dev/md1|grep '/mnt/raid1'|wc -l"
	r = exec_ssh_cmd_read_output(@ip, @username, @password, c, "step2_raid1.tmp")
	
	test(r[0].to_i==1,"File content must be 1")
end

def tester.step03_fdisk	
	c="fdisk -l /dev/sda|grep Disco|tr ':' ' '|tr -s ' ' ':'"
	r = exec_ssh_cmd_read_output(@ip, @username, @password, c)
	
	v=r[0].split(':')[2].to_i
	test(is_near_to?(v,100),"Partition size: Expected=100, obtain=#{v}")

	c="fdisk -l /dev/sdb|grep Disco|tr ':' ' '|tr -s ' ' ':'"
	r=exec_ssh_cmd_read_output(@ip, @username, @password, c)
	
	v=r[0].split(':')[2].to_i
	test( is_near_to?(v,2000),"Partition size: Expected=2000, obtain=#{v}")

	c = "fdisk -l /dev/sdc|grep Disco|tr ':' ' '|tr -s ' ' ':'"
	r = exec_ssh_cmd_read_output(@ip, @username, @password, c)
	
	v=r[0].split(':')[2].to_i
	test( is_near_to?(v,1000) ,"Partition size: Expected=1000, obtain=#{v}")

	c = "fdisk -l /dev/sdd|grep Disco|tr ':' ' '|tr -s ' ' ':'"
	r = exec_ssh_cmd_read_output(@ip, @username, @password, c)
	
	v=r[0].split(':')[2].to_i
	test( is_near_to?(v,500),"Partition size: Expected=500, obtain=#{v}")

	c = "fdisk -l /dev/sde|grep Disco|tr ':' ' '|tr -s ' ' ':'"
	r = exec_ssh_cmd_read_output(@ip, @username, @password, c)
	
	v=r[0].split(':')[2].to_i
	test( is_near_to?(v,500),"Partition size: Expected=500, obtain=#{v}")

	c = "fdisk -l /dev/md0|grep Disco|tr ':' ' '|tr -s ' ' ':'"
	r = exec_ssh_cmd_read_output(@ip, @username, @password, c)
	
	v=r[0].split(':')[2].to_i
	test( is_near_to?(v,3100),"Partition size: Expected=3100, obtain=#{v}")

	c = "fdisk -l /dev/md1|grep Disco|tr ':' ' '|tr -s ' ' ':'"
	r = exec_ssh_cmd_read_output(@ip, @username, @password, c)
	
	v=r[0].split(':')[2].to_i
	test( is_near_to?(v,500),"Partition size: Expected=500, obtain=#{v}")

end

def tester.xstep04_proc_mdstat	
	t='proc_mdstat_md0_a.tmp'
	c="cat /proc/mdstat|grep md0|grep raid0|wc -l>/tmp/#{t}"
	item = exec_ssh_cmd_read_output(@ip, @username, @password, c, t)
	
	test(item[0].to_i==1,"Reading file <tmp/#{t}>")

	lsTempfile='proc_mdstat_md0_b.tmp'
	lsCmd="cat /proc/mdstat|grep raid0|grep 'sdb1'|grep 'sdc1'|wc -l>/tmp/#{lsTempfile}"
	lsItem = exec_ssh_cmd_read_output(@ip, @username, @password, lsCmd, lsTempfile)
	
	test(lsItem[0].to_i==1,"Reading file <tmp/#{lsTempfile}>")

	lsTempfile='proc_mdstat_md1_a.tmp'
	lsCmd="cat /proc/mdstat|grep md1|grep raid1|wc -l>/tmp/#{lsTempfile}"
	lsItem = exec_ssh_cmd_read_output(@ip, @username, @password, lsCmd, lsTempfile)
	
	test(lsItem[0].to_i==1,"Reading file <tmp/#{lsTempfile}>")

	lsTempfile='proc_mdstat_md1_b.tmp'
	lsCmd="cat /proc/mdstat|grep raid1|grep 'sdd1'|grep 'sde1'|wc -l>/tmp/#{lsTempfile}"
	lsItem = exec_ssh_cmd_read_output(@ip, @username, @password, lsCmd, lsTempfile)
	
	test(lsItem[0].to_i==1,"Reading file <tmp/#{lsTempfile}>")
end

#tester.debug=false
tester.execute
