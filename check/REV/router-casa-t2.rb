#!/usr/bin/ruby
# encoding: utf-8

require './sys/teacher2.rb'

=begin
Script de pruebas contra el router de casa

 David Vargas Ruiz
 davidvargas.tenerife@gmail.com
=end

t = Teacher.new

def tester.init
	@ip='192.168.1.1'
	@hostname='Livebox'
	@username='admin'
end

t.describe "Saving output of command" do
	
	command "nmap #{ hostname('m1').ip}"
	tempfile 'nmap.tmp'
	height 0,0
	
	run_from 'localhost'

	mark(r.count>0,"Saving output of: "+c)
	c="cat tmp/#{t} | grep 21 | wc -l"
	r=exec_cmd_and_read_output(c)
	test(r[0].to_i==0,"Port 21 hide on <"+@ip+">: "+c)

	mark(false,"Starting with ports")
	
	c="cat tmp/#{t} | grep 80 | grep open | wc -l"
	r=exec_cmd_and_read_output(c)
	test(r[0].to_i==1,"Port 80 open on <"+@ip+">: "+c)

	c="cat tmp/#{t} | grep 135 | grep open | wc -l"
	r=exec_cmd_and_read_output(c)
	test(r[0].to_i==1,"Port 135 open on <"+@ip+">: "+c)

	c="cat tmp/#{t} | grep 443 | grep open | wc -l"
	r=exec_cmd_and_read_output(c)
	test(r[0].to_i==1,"Port 443 open on <"+@ip+">: "+c)

end

tester.execute
