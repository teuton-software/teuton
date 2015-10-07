#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Módulo ADD1516. Actividad Clientes ligeros
=end

define_test :hostnames do

	description "Checking SSH service on <"+get(:host1_ip)+">"
	command "nmap #{get(:host1_ip)} | grep 22|wc -l"
	run_on :localhost
	check result.to_i.equal?(1)

	description "Checking hostname <"+get(:host1_hostname)+">"
	command "hostname -f"
	run_on :host1
	check result.equal?(get(:host1_hostname))

	unique "hostname", result.value
	
end

define_test :users do
		
	[1,2,3].each do |i|
	  username=get(:apellido1)+i.to_s

	  description "User <#{username}> exists"
	  command "cat /etc/passwd | grep #{username} | wc -l"
	  run_on :host1
	  check result.to_i.equal?(1)

	  description "Users <#{username}> with passwd>"
	  command "cat /etc/shadow | grep #{username}| cut -d : -f 2| wc -l"
	  run_on :host1
	  check result.to_i.equal?(1)

	  description "User <#{username}> logged"
	  command "last | grep #{username} | wc -l"
	  run_on :host1
	  check result.to_i.not_equal?(0)
    end
    
end

define_test :thin_clients do

	description "Thin client 192.168.0.20"
	command "arp | grep 192.168.0.20|grep eth1"
	run_on :host1
	check result.to_i.equal?(1)
	
	description "Thin client 192.168.0.21"
	command "arp | grep 192.168.0.21|grep eth1"
	run_on :host1
	check result.to_i.equal?(1)

	command "ip link | grep ether"
	unique "MAC", result.value
	
end

start do
	show :resume
	export :all
end
