#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Course name: ADD1516
 Activity: Thin Clients LTSP
=end

check :hostnames_configurations do
  desc "Checking SSH port <"+get(:host1_ip)+">"
  on :localhost, :execute => "nmap #{get(:host1_ip)} | grep ssh|wc -l"
  expect result.to_i.equal?(1)

  desc "Checking hostname <"+get(:host1_hostname)+">"
  on :host1, :execute => "hostname -f"
  expect result.equal?(get(:host1_hostname))

  unique "hostname", result.value	
  on :host1, :execute => "blkid |grep sda1"
  unique "UUID", result.value	
end

check :users_definitions do
  users=[1,2,3]
  
  users.each do |i|
    username=get(:apellido1)+i.to_s

	desc "User <#{username}> exists"
	on :host1, :execute => "cat /etc/passwd | grep #{username} | wc -l"
	expect result.to_i.equal?(1)

	desc "Users <#{username}> with not empty password "
	on :host1, :execute => "cat /etc/shadow | grep #{username}| cut -d : -f 2| wc -l"
	expect result.to_i.equal?(1)

	desc "User <#{username}> logged"
	on :host1, :execute => "last | grep #{username[0,8]} | wc -l"
	expect result.to_i.not_equal?(0)
  end
end

check :software_installed do
  desc "Package <#{packagename}> installed"
  on :host1, :execute => "dpkg -l #{packagename}| grep ii| wc -l"
  expect result.to_i.equal?(1)

  desc "Image builded"
  on :host1, :execute => "ltsp-info| grep 'found image'| wc -l"
  expect result.to_i.equal?(1)

  on :host1, :execute => "ltsp-info| grep 'found image'| tr -s ':' ' '|tr -s ' ' ':'| cut -d : -f 3"
  log imagefullname=result.value
end

check :services_are_running do
  services=[ 'dhcpd', 'tftpd' ]
  
  services.each do |service|
    desc "Service <#{service}> running"
    on :host1, :execute => "ps -ef| grep #{service}| grep -v color| wc -l"
    expect result.to_i.equal?(1)
  end
  
  filename='/etc/default/isc-dhcp-server'
  desc "<#{filename}> content"
  on :host1, :execute => "cat #{filename}|grep INTERFACES"
  expect result.value.include? 'INTERFACES="eth1"'

  filename='/etc/default/tftpd-pha'
  desc "<#{filename}> content"
  on :host1, :execute => "cat #{filename}|grep TFTP_ADDRESS"
  expect result.value.include? 'TFTP_ADDRESS="192.168.0.1:69"'
end

check :thin_clients_are_running do
  clients = [20, 21]

  clients.each do |i|
    ip="192.168.0."+i.to_s
	
	desc "Thin client #{ip} into ARP table"
	on :host1, :execute => "arp | grep #{ip}| wc -l"
	expect result.to_i.equal?(1)

	desc "Thin client #{ip} into LOG files"
	on :host1, :execute => "cat /var/log/syslog |grep dhcp |grep DHCPREQUEST |grep #{ip} |wc -l"
	expect result.to_i.is_greater_than? 1 

	desc "Thin client #{ip} into LOG files"
	on :host1, :execute => "cat /var/log/syslog |grep dhcp |grep DHCPACK |grep #{ip} |wc -l"
	expect result.to_i.is_greater_than? 1 
  end
  	
  on :host1, :execute => "ip link | grep ether"
  unique "LTSP MAC", result.value
end

start do
	show :resume
	export :all
end
