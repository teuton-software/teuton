#!/usr/bin/ruby
# encoding: utf-8

=begin
Script de autocorreción de la actividad: A1-Apache2

$author David Vargas Ruiz
$email davidvargas.tenerife@gmail.com

=end

require './checker.rb'

test = Checker.new

def test.init
	@ip='192.168.1.1'	
end

def test.test_server_by_nmap
	show_debug('test_server_by_nmap')
	
	tempfile='tmp/nmap.tmp'
	cmd='nmap '+@ip+' | grep 80 | wc -l'
	system(cmd+' > '+tempfile)

	found=false
	item=read_filename tempfile
	
	reg(item[0].to_i!=1,"Scanning 80 port on <"+@ip+">: "+cmd)
end

def test.do_tests
	system('rm tmp/*.tmp')
	puts ("\n"+"="*60)
	test_server_by_nmap
end

test.init
test.debug=true
test.do_tests
test.show_results

