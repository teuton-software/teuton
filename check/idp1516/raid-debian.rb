#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/sysadmingame'

=begin
 Course name : IDP1516
 Activity    : RAID Debian (Trimestre2)
 MV OS       : host1 => Debian8
               host2 => Windows7
=end


target :host1_configurations do

  target "ping #{get(:host1_ip)} to #{get(:host1_osname)}"
  goto :localhost, :exec => "ping #{get(:host1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.equal?(0)

  target "SSH port 22 on <"+get(:host1_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:host1_ip)} -Pn | grep ssh|wc -l"
  expect result.equal?(1)

  hostname1a="#{get(:lastname1)}3"
  target "Checking hostname -a <"+hostname1a+">"
  goto :host1, :exec => "hostname -a"
  expect result.equal?(hostname1a)

  hostname1b="#{get(:lastname2)}"
  target "Checking hostname -d <"+hostname1b+">"
  goto :host1, :exec => "hostname -d"
  expect result.equal?(hostname1b)

  hostname1c="#{hostname1a}.#{hostname1b}"
  target "Checking hostname -f <"+hostname1c+">"
  goto :host1, :exec => "hostname -f"
  expect result.equal?(hostname1c)

  goto :host1, :exec => "blkid |grep sda1"
  unique "UUID_sda1", result.value	
  goto :host1, :exec => "blkid |grep sda2"
  unique "UUID_sda2", result.value	

end

target :host2_configurations do

  target "ping #{get(:host2_ip)} to #{get(:host2_osname)}"
  goto :localhost, :exec => "ping #{get(:host2_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.equal?(0)
  
  target "netbios-ssn service on #{get(:host2_ip)}"
  goto :localhost, :exec => "nmap -Pn #{get(:host2_ip)} | grep '139/tcp'| grep 'open'|wc -l"
  expect result.equal?(1)

end

target :user_definitions do
  username=get(:firstname)

  target "User <#{username}> exists"
  goto :host1, :exec => "id '#{username}' | wc -l"
  expect result.equal?(1)

  target "Users <#{username}> with not empty password "
  goto :host1, :exec => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.equal?(1)

  target "User <#{username}> logged"
  goto :host1, :exec => "last | grep #{username[0,8]} | wc -l"
  expect result.not_equal?(0)
end

target :raid0_into_host1 do
end

target :raid1_into_host1 do

end  

start do
	show :resume
	export :all
end

=begin
---
:global:
  :host1_username: root
:cases:
- :tt_members: david
  :host1_ip: 172.19.2.11
  :host1_password: 45454545a
  :host2_ip: 172.19.2.21
  :firstname: david
  :lastname1: vargas
  :lastname2: ruiz
=end
