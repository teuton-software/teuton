#!/usr/bin/ruby
# encoding: utf-8

=begin
Script de pruebas con el servidor telesforo

David Vargas Ruiz
davidvargas.tenerife@gmail.com
=end

require './teacher.rb'
require 'rubygems'
require 'net/ssh'
require 'net/sftp'

teacher = Teacher.new

def teacher.init
	@ip='88.198.18.148'
	@hostname='www.iespuertodelacruz.es'
	@username='david'
	@password='profesor'
end

def teacher.step01_nmap
	show_debug('step01_nmap')
	
	cmd='nmap '+@ip+' | grep 22 | wc -l'
	item=exec_cmd_and_read_output(cmd, 'tmp/nmap.tmp')
	
	test(item[0].to_i==1,"Scanning 22 port on <"+@ip+">: "+cmd)
end

def teacher.xstep02_df
	show_debug('step02_df')
	
	lsTempfile='df-hT-md0.tmp'
	lsCmd="df -hT | grep /dev/md0 | grep '/' | wc -l > /tmp/#{lsTempfile}"
	lsItem = exec_ssh_cmd_read_output(@ip, @username, @password, lsCmd, lsTempfile)
	
	test(lsItem[0].to_i==1,"Reading file <tmp/#{lsTempfile}>")

	lsTempfile='df-hT-md1.tmp'
	lsCmd="df -hT | grep /dev/md1 | grep '/mnt/raid1' | wc -l > /tmp/#{lsTempfile}"
	lsItem = exec_ssh_cmd_read_output(@ip, @username, @password, lsCmd, lsTempfile)
	
	test(lsItem[0].to_i==1,"Reading file <tmp/#{lsTempfile}")
end

def teacher.xstep03_fdisk
	show_debug('step03_fdisk')
	
	lsTempfile='fdisk-sda.tmp'
	lsCmd="fdisk -l /dev/sda |grep Disco| tr ':' ' '| tr -s ' ' ':' > /tmp/#{lsTempfile}"
	lsItem = exec_ssh_cmd_read_output(@ip, @username, @password, lsCmd, lsTempfile)
	
	v=lsItem[0].split(':')[2].to_i
	test((v>100 and v<110),"Partition size <tmp/#{lsTempfile}>: "+v.to_s)

	lsTempfile='fdisk-sdb.tmp'
	lsCmd="fdisk -l /dev/sdb |grep Disco| tr ':' ' '| tr -s ' ' ':' > /tmp/#{lsTempfile}"
	lsItem = exec_ssh_cmd_read_output(@ip, @username, @password, lsCmd, lsTempfile)
	
	v=lsItem[0].split(':')[2].to_i
	test((v>2000 and v<2200),"Partition size <tmp/#{lsTempfile}>: "+v.to_s)

	lsTempfile='fdisk-sdc.tmp'
	lsCmd="fdisk -l /dev/sdc |grep Disco| tr ':' ' '| tr -s ' ' ':' > /tmp/#{lsTempfile}"
	lsItem = exec_ssh_cmd_read_output(@ip, @username, @password, lsCmd, lsTempfile)
	
	v=lsItem[0].split(':')[2].to_i
	test((v>1000 and v<1100),"Partition size <tmp/#{lsTempfile}>: "+v.to_s)

	lsTempfile='fdisk-sdd.tmp'
	lsCmd="fdisk -l /dev/sdd |grep Disco| tr ':' ' '| tr -s ' ' ':' > /tmp/#{lsTempfile}"
	lsItem = exec_ssh_cmd_read_output(@ip, @username, @password, lsCmd, lsTempfile)
	
	v=lsItem[0].split(':')[2].to_i
	test((v>500 and v<550),"Partition size <tmp/#{lsTempfile}>: "+v.to_s)

	lsTempfile='fdisk-sde.tmp'
	lsCmd="fdisk -l /dev/sde |grep Disco| tr ':' ' '| tr -s ' ' ':' > /tmp/#{lsTempfile}"
	lsItem = exec_ssh_cmd_read_output(@ip, @username, @password, lsCmd, lsTempfile)
	
	v=lsItem[0].split(':')[2].to_i
	test((v>500 and v<550),"Partition size <tmp/#{lsTempfile}>: "+v.to_s)

	lsTempfile='fdisk-md0.tmp'
	lsCmd="fdisk -l /dev/md0 |grep Disco| tr ':' ' '| tr -s ' ' ':' > /tmp/#{lsTempfile}"
	lsItem = exec_ssh_cmd_read_output(@ip, @username, @password, lsCmd, lsTempfile)
	
	v=lsItem[0].split(':')[2].to_i
	test((v>3000 and v<3300),"Partition size <tmp/#{lsTempfile}>: "+v.to_s)

	lsTempfile='fdisk-md1.tmp'
	lsCmd="fdisk -l /dev/md1 |grep Disco| tr ':' ' '| tr -s ' ' ':' > /tmp/#{lsTempfile}"
	lsItem = exec_ssh_cmd_read_output(@ip, @username, @password, lsCmd, lsTempfile)
	
	v=lsItem[0].split(':')[2].to_i
	test((v>500 and v<550),"Partition size <tmp/#{lsTempfile}>: "+v.to_s)

end

def teacher.do_tests
	step01_nmap
end

teacher.debug=true
teacher.execute
