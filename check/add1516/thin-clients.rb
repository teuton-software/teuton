#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Course name: ADD1516
 Activity: Thin Clients LTSP
=end

check :hostnames_configurations do
  desc "Checking SSH port <"+get(:host1_ip)+">"
  goto :localhost, :execute => "nmap #{get(:host1_ip)} | grep ssh|wc -l"
  expect result.equal?(1)

  desc "Checking hostname <"+get(:host1_hostname)+">"
  goto :host1, :execute => "hostname -f"
  expect result.equal?(get(:host1_hostname))

  unique "hostname", result.value	
  goto :host1, :execute => "blkid |grep sda1"
  unique "UUID", result.value	
end

check :users_definitions do
  users=[1,2,3]
  
  users.each do |i|
    username=get(:apellido1)+i.to_s

	desc "User <#{username}> exists"
	goto :host1, :execute => "cat /etc/passwd | grep #{username} | wc -l"
	expect result.equal?(1)

	desc "Users <#{username}> with not empty password "
	goto :host1, :execute => "cat /etc/shadow | grep #{username}| cut -d : -f 2| wc -l"
	expect result.equal?(1)

	desc "User <#{username}> logged"
	goto :host1, :execute => "last | grep #{username[0,8]} | wc -l"
	expect result.not_equal?(0)
  end
end

check :software_installed do
  desc "Package <#{packagename}> installed"
  goto :host1, :execute => "dpkg -l #{packagename}| grep ii| wc -l"
  expect result.equal?(1)

  desc "Image builded"
  goto :host1, :execute => "ltsp-info| grep 'found image'| wc -l"
  expect result.equal?(1)

  goto :host1, :execute => "ltsp-info| grep 'found image'| tr -s ':' ' '|tr -s ' ' ':'| cut -d : -f 3"
  log imagefullname=result.value
end

check :services_are_running do
  services=[ 'dhcpd', 'tftpd' ]
  
  services.each do |service|
    desc "Service <#{service}> running"
    goto :host1, :execute => "ps -ef| grep #{service}| grep -v color| wc -l"
    expect result.equal?(1)
  end
  
  filename='/etc/default/isc-dhcp-server'
  desc "<#{filename}> content"
  goto :host1, :execute => "cat #{filename}|grep INTERFACES"
  expect result.value.include? 'INTERFACES="eth1"'

  filename='/etc/default/tftpd-pha'
  desc "<#{filename}> content"
  goto :host1, :execute => "cat #{filename}|grep TFTP_ADDRESS"
  expect result.value.include? 'TFTP_ADDRESS="192.168.0.1:69"'
end

check :thin_clients_are_running do
  clients = [20, 21]

  clients.each do |i|
    ip="192.168.0."+i.to_s
	
	desc "Thin client #{ip} into ARP table"
	goto :host1, :execute => "arp | grep #{ip}| wc -l"
	expect result.equal?(1)

	desc "Thin client #{ip} into LOG files"
	goto :host1, :execute => "cat /var/log/syslog |grep dhcp |grep DHCPREQUEST |grep #{ip} |wc -l"
	expect result.is_greater_than? 1 

	desc "Thin client #{ip} into LOG files"
	goto :host1, :execute => "cat /var/log/syslog |grep dhcp |grep DHCPACK |grep #{ip} |wc -l"
	expect result.is_greater_than? 1 
  end
  	
  goto :host1, :execute => "ip link | grep ether"
  unique "LTSP MAC", result.value
end

start do
	show
	export
end

=begin
---
:global:
  :host1_username: root
:cases:
- :tt_members: aaa
  :tt_emails: aaa@gmail.com
  :host1_ip: 172.18.2.41
  :host1_password: aaa
  :host1_hostname: aaa.bbb
  :apellido1: aaa
=end
