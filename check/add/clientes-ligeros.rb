#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Módulo ADD1516. Actividad Clientes ligeros
=end

define_test :hostnames_configured do

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

define_test :users_defined do
  USERS=[1,2,3]
  
  USERS.each do |i|
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

define_test :thin_clients_running do
  CLIENTS = [20, 21]

  CLIENTS.each do |i|
    ip="192.168.0."+i.to_s
	
	description "Thin client #{ip} into ARP table"
	command "arp | grep #{ip}|grep eth1"
	run_on :host1
	check result.to_i.equal?(1)

	description "Thin client #{ip} into LOG files"
	command "cat /var/log/syslog |grep dhcp |grep DHCPREQUEST |grep #{ip} |wc -l"
	run_on :host1
	check result.to_i.value > 1 

	description "Thin client #{ip} into LOG files"
	command "cat /var/log/syslog |grep dhcp |grep DHCPACK |grep #{ip} |wc -l"
	run_on :host1
	check result.to_i.value > 1 
  end
  	
  command "ip link | grep ether"
  unique "LTSP MAC", result.value
end

start do
	show :resume
	export :all
end
