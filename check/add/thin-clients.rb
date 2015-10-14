#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Módulo ADD1516. Actividad Clientes ligeros
=end

define_test :hostnames_configured do

	description "Checking SSH port <"+get(:host1_ip)+">"
	command "nmap #{get(:host1_ip)} | grep ssh|wc -l"
	run_on :localhost
	check result.to_i.equal?(1)

	description "Checking hostname <"+get(:host1_hostname)+">"
	command "hostname -f"
	run_on :host1
	check result.equal?(get(:host1_hostname))

	unique "hostname", result.value
	
end

define_test :users_defined do
  users=[1,2,3]
  
  users.each do |i|
    username=get(:apellido1)+i.to_s

	description "User <#{username}> exists"
	run_on :host1, :command => "cat /etc/passwd | grep #{username} | wc -l"
	check result.to_i.equal?(1)

	description "Users <#{username}> with not empty password "
	run_on :host1, :command => "cat /etc/shadow | grep #{username}| cut -d : -f 2| wc -l"
	check result.to_i.equal?(1)

	description "User <#{username}> logged"
	run_on :host1, :command => "last | grep #{username[0,8]} | wc -l"
	check result.to_i.not_equal?(0)
  end
end

define_test :software_installed do
  description "Package <#{packagename}> installed"
  run_on :host1, :command => "dpkg -l #{packagename}| grep ii| wc -l"
  check result.to_i.equal?(1)

  description "Image builded"
  run_on :host1, :command => "ltsp-info| grep 'found image'| wc -l"
  check result.to_i.equal?(1)

  run_on :host1, :command => "ltsp-info| grep 'found image'| tr -s ':' ' '|tr -s ' ' ':'| cut -d : -f 3"
  imagefulname=result.value
  
end

define_test :services_running do
  services=[ 'dhcpd', 'tftpd' ]
  
  services.each do |service|
    description "Service <#{service}> running"
    run_on :host1, :command => "ps -ef| grep #{service}| grep -v color| wc -l"
    check result.to_i.equal?(1)
  end
    
end

define_test :thin_clients_running do
  clients = [20, 21]

  clients.each do |i|
    ip="192.168.0."+i.to_s
	
	description "Thin client #{ip} into ARP table"
	run_on :host1, :command => "arp | grep #{ip}| wc -l"
	check result.to_i.equal?(1)

	description "Thin client #{ip} into LOG files"
	run_on :host1, :command => "cat /var/log/syslog |grep dhcp |grep DHCPREQUEST |grep #{ip} |wc -l"
	check result.to_i.is_greater_than? 1 

	description "Thin client #{ip} into LOG files"
	run_on :host1, :command => "cat /var/log/syslog |grep dhcp |grep DHCPACK |grep #{ip} |wc -l"
	check result.to_i.is_greater_than? 1 
  end
  	
  run_on :host1, :command => "ip link | grep ether"
  unique "LTSP MAC", result.value
end

start do
	show :resume
	export :all
end
