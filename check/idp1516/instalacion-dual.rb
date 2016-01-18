#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Course name : IDP1516
 Activity    : Instalación dual
 MV OS       : Window7 con OpenSUSE 132.
=end

check :hostname_configurations do
  #desc "ping to <"+get(:host1_ip)+">"
  #on :localhost, :execute => "ping #{get(:host1_ip)} | grep errors|wc -l"
  #expect result.to_i.equal?(0)

  desc "SSH port 22 on <"+get(:host1_ip)+"> open"
  on :localhost, :execute => "nmap #{get(:host1_ip)} -Pn | grep ssh|wc -l"
  expect result.to_i.equal?(1)

  _hostname="DUALX#{get(:lastname1)}"
  desc "Checking hostname -a <"+_hostname+">"
  on :host1, :execute => "hostname -a"
  expect result.equal?(_hostname)

  _hostname="#{get(:lastname2)}"
  desc "Checking hostname -d <"+_hostname+">"
  on :host1, :execute => "hostname -d"
  expect result.equal?(_hostname)

  _hostname="DUALX#{get(:lastname1)}.#{get(:lastname2)}"
  desc "Checking hostname -f <"+_hostname+">"
  on :host1, :execute => "hostname -f"
  expect result.equal?(_hostname)

  on :host1, :execute => "blkid |grep sda1"
  unique "UUID_sda1", result.value	
  on :host1, :execute => "blkid |grep sda2"
  unique "UUID_sda2", result.value	
  on :host1, :execute => "blkid |grep sda6"
  unique "UUID_sda6", result.value	
  on :host1, :execute => "blkid |grep sda7"
  unique "UUID_sda7", result.value	
end

check :user_definitions do
  username=get(:firstname)

  desc "User <#{username}> exists"
  on :host1, :execute => "cat /etc/passwd | grep '#{username}:' | wc -l"
  expect result.to_i.equal?(1)

  desc "Users <#{username}> with not empty password "
  on :host1, :execute => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.to_i.equal?(1)

  desc "User <#{username}> logged"
  on :host1, :execute => "last | grep #{username[0,8]} | wc -l"
  expect result.to_i.not_equal?(0)
end

check :disk_size do
  size='18'
  desc "Disk sda size <#{size}>"
  on :host1, :execute => "lsblk |grep disk| grep sda| grep #{size}|grep G| wc -l"
  expect result.to_i.equal?(1)
end


check :partitions_size_and_type do
  partitions={ :sda1 => ['sda1'  ,'11,7G' , '12G'],
               :sda2 => ['sda2'  ,'100M' , '100M'],
               :sda5 => ['[SWAP]','500M', '500M'],
               :sda6 => ['/home' ,'100M', '107M'],
               :sda7 => ['/'     ,'5G', '5,3G']
                }
  
  partitions.each_pair do |key,value|
    desc "Partition #{key} mounted on <#{value[0]}>"
    on :host1, :execute => "lsblk |grep part| grep #{key}| grep #{value[0]}| wc -l"
    expect result.to_i.equal?(1)

    desc "Partition #{key} size <#{value[1]}>"
    on :host1, :execute => "lsblk |grep part| grep #{key}| tr -s ' ' ':'| cut -d ':' -f 5"
    expect(result.to_s.equal?(value[1]) || result.to_s.equal?(value[2]))    
  end

  partitions={ :sda6 => ['/dev/disk', '/home', 'ext3'],
               :sda7 => ['/dev/disk', '/'    , 'ext4'] 
             }
  
  partitions.each_pair do |key,value|  
     desc "Partition #{key} type <#{value[2]}>"
    on :host1, :execute => "df -hT | grep #{key}| grep #{value[2]}|wc -l"
    expect result.to_i.equal?(1)
  end  
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
  :host1_ip: 172.19.2.30
  :host1_password: 45454545a
  :firstname: david
  :lastname1: vargas
  :lastname2: ruiz

=end
