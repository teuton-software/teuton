#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/sysadmingame'

=begin
 Course name : IDP1516
 Activity    : LVM Debian (Trimestre2)
 MV OS       : host1 => Debian8
               host2 => Windows7
=end


task :host1_configurations do

  target "ping #{get(:host1_ip)} to #{get(:host1_osname)}"
  goto :localhost, :exec => "ping #{get(:host1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.equal?(0)

  target "SSH port 22 on <"+get(:host1_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:host1_ip)} -Pn | grep ssh|wc -l"
  expect result.equal?(1)

  hostname1a="#{get(:lastname1)}"
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

task :host2_configurations do
=begin  
  target "ping #{get(:host2_ip)} to #{get(:host2_osname)}"
  goto :localhost, :exec => "ping #{get(:host2_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.equal?(0)
  
  target "netbios-ssn service on #{get(:host2_ip)}"
  goto :localhost, :exec => "nmap -Pn #{get(:host2_ip)} | grep '139/tcp'| grep 'open'|wc -l"
  expect result.equal?(1)
=end
end

task :user_definitions do
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

task :lvm1_host1 do

  target "vgdisplay vg-debian"
  goto :host1, :exec => "vgdisplay vg-debian | wc -l"
  expect result.is_greater_than? 0

  target "vg-debian/lv-raiz"
  goto :host1, :exec => "lvdisplay vg-debian| grep 'vg-debian/lv-raiz' |wc -l"
  expect result.equal? 1

  target "vg-debian/lv-swap"
  goto :host1, :exec => "lvdisplay vg-debian| grep 'vg-debian/lv-swap' |wc -l"
  expect result.equal? 1

  target "vg-debian/lv-datos"
  goto :host1, :exec => "lvdisplay vg-debian| grep 'vg-debian/lv-datos' |wc -l"
  expect result.equal? 1
end

task :lvm2_into_host1 do

  target "Disk sdb"
  goto :host1, :exec => "fdisk -l /dev/sdb|grep sdb|wc -l"
  expect result.is_greater_than? 1

  target "Disk sdc"
  goto :host1, :exec => "fdisk -l /dev/sdc|grep sdc|wc -l"
  expect result.is_greater_than? 3

  target "vg-extra"
  goto :host1, :exec => "vgdisplay vg-extra | wc -l"
  expect result.is_greater_than? 0

  target "vg-extra/lv-extra"
  goto :host1, :exec => "lvdisplay vg-extra| grep 'vg-extra/lv-extra' |wc -l"
  expect result.equal? 1

end  

start do
  show
  export
  send :copy_to => :host1
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
