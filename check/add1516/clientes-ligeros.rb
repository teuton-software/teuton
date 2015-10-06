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
	
	description "Users <#{get(:apellido1)}[123]>"
	command "cat /etc/passwd | grep #{get(:apellido1)}| wc -l"
	run_on :host1
	check result.to_i.equal?(3)
	
	description "Users passwd <#{get(:apellido1)}[123]>"
	command "cat /etc/shadow | grep #{get(:apellido1)}| cut -d : -f 2| wc -l"
	run_on :host1
	check result.to_i.equal?(3)

	description "User <#{get(:apellido1)}1>"
	command "cat /etc/passwd | grep #{get(:apellido1)}1 | wc -l"
	run_on :host1
	check result.to_i.equal?(1)

	description "User <#{get(:apellido1)}2>"
	command "cat /etc/passwd | grep #{get(:apellido1)}2 | wc -l"
	run_on :host1
	check result.to_i.equal?(1)

	description "User <#{get(:apellido1)}3>"
	command "cat /etc/passwd | grep #{get(:apellido1)}3 | wc -l"
	run_on :host1
	check result.to_i.equal?(1)

end

define_test :thin_clients do
	description "Cliente ligero 192.168.0.20"
	command "arp | grep 192.168.0.20|grep eth1"
	run_on :host1
	check result.to_i.equal?(1)
	
	description "Cliente ligero 192.168.0.21"
	command "arp | grep 192.168.0.21|grep eth1"
	run_on :host1
	check result.to_i.equal?(1)

end

start do
	show :resume
	export :all
end
