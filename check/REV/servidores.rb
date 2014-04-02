#!/usr/bin/ruby
# encoding: utf-8

=begin
Script de pruebas contra servidor FRY

David Vargas Ruiz
davidvargas.tenerife@gmail.com

=end

require './sys/teacher.rb'

checker = Teacher.new

def checker.init
	@ip='172.16.1.1'
	@hostname='fry.servidor'

	@ip2='192.168.1.3'
	@hostname2='leela.servidor'
end

def checker.step01_nmap
	
	cmd='nmap '+@ip+' | grep 22 | grep ssh | wc -l'
	item=exec_cmd_and_read_output(cmd, 'nmap.tmp')
	
	test(item[0].to_i==1,"Scanning 22 port on <"+@ip+">: "+cmd)

	cmd='nmap '+@ip+' | grep 32 | wc -l'
	item=exec_cmd_and_read_output(cmd, 'nmap.tmp')
	
	test(item[0].to_i==0,"Scanning 32 port on <"+@ip+">: "+cmd)

	cmd='nmap '+@ip+' | grep 80 | wc -l'
	item=exec_cmd_and_read_output(cmd, 'nmap.tmp')
	
	test(item[0].to_i==1,"Scanning 80 port on <"+@ip+">: "+cmd)

	cmd='nmap '+@ip2+' | grep 22| grep ssh | wc -l'
	item=exec_cmd_and_read_output(cmd, 'nmap.tmp')
	
	test(item[0].to_i==1,"Scanning 22 port on <"+@ip2+">: "+cmd)

	cmd='nmap '+@ip2+' | grep 80 | wc -l'
	item=exec_cmd_and_read_output(cmd, 'nmap.tmp')
	
	test(item[0].to_i==1,"Scanning 80 port on <"+@ip2+">: "+cmd)
end

checker.debug=true
checker.execute

