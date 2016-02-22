#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Course name : IDP1516
 Activity    : LVM Debian (Trimestre2)
 MV OS       : host1 => Debian8
               host2 => Windows7
=end


check :host1_configurations do

  desc "ping #{get(:host1_ip)} to #{get(:host1_osname)}"
  goto :localhost, :execute => "ping #{get(:host1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.equal?(0)

  desc "SSH port 22 on <"+get(:host1_ip)+"> open"
  goto :localhost, :execute => "nmap #{get(:host1_ip)} -Pn | grep ssh|wc -l"
  expect result.equal?(1)

  hostname1a="#{get(:lastname1)}"
  desc "Checking hostname -a <"+hostname1a+">"
  goto :host1, :execute => "hostname -a"
  expect result.equal?(hostname1a)

  hostname1b="#{get(:lastname2)}"
  desc "Checking hostname -d <"+hostname1b+">"
  goto :host1, :execute => "hostname -d"
  expect result.equal?(hostname1b)

  hostname1c="#{hostname1a}.#{hostname1b}"
  desc "Checking hostname -f <"+hostname1c+">"
  goto :host1, :execute => "hostname -f"
  expect result.equal?(hostname1c)

  goto :host1, :execute => "blkid |grep sda1"
  unique "UUID_sda1", result.value	
  goto :host1, :execute => "blkid |grep sda2"
  unique "UUID_sda2", result.value	

end

check :host2_configurations do
=begin  
  desc "ping #{get(:host2_ip)} to #{get(:host2_osname)}"
  goto :localhost, :execute => "ping #{get(:host2_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.equal?(0)
  
  desc "netbios-ssn service on #{get(:host2_ip)}"
  goto :localhost, :execute => "nmap -Pn #{get(:host2_ip)} | grep '139/tcp'| grep 'open'|wc -l"
  expect result.equal?(1)
=end
end

check :user_definitions do
  username=get(:firstname)

  desc "User <#{username}> exists"
  goto :host1, :execute => "id '#{username}' | wc -l"
  expect result.equal?(1)

  desc "Users <#{username}> with not empty password "
  goto :host1, :execute => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.equal?(1)

  desc "User <#{username}> logged"
  goto :host1, :execute => "last | grep #{username[0,8]} | wc -l"
  expect result.not_equal?(0)
end

check :lvm1_host1 do

  desc "vgdisplay vg-debian"
  goto :host1, :execute => "vgdisplay vg-debian | wc -l"
  expect result.is_greater_than? 0

  desc "vg-debian/lv-raiz"
  goto :host1, :execute => "lvdisplay vg-debian| grep 'vg-debian/lv-raiz' |wc -l"
  expect result.equal? 1

  desc "vg-debian/lv-swap"
  goto :host1, :execute => "lvdisplay vg-debian| grep 'vg-debian/lv-swap' |wc -l"
  expect result.equal? 1

  desc "vg-debian/lv-datos"
  goto :host1, :execute => "lvdisplay vg-debian| grep 'vg-debian/lv-datos' |wc -l"
  expect result.equal? 1
end

check :lvm2_into_host1 do

  desc "Disk sdb"
  goto :host1, :execute => "fdisk -l /dev/sdb|grep sdb|wc -l"
  expect result.is_greater_than? 1

  desc "Disk sdc"
  goto :host1, :execute => "fdisk -l /dev/sdc|grep sdc|wc -l"
  expect result.is_greater_than? 3

  desc "vg-extra"
  goto :host1, :execute => "vgdisplay vg-extra | wc -l"
  expect result.is_greater_than? 0

  desc "vg-extra/lv-extra"
  goto :host1, :execute => "lvdisplay vg-extra| grep 'vg-extra/lv-extra' |wc -l"
  expect result.equal? 1

end  

start do
  show
  export
  #send :copy_to => :host1
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
