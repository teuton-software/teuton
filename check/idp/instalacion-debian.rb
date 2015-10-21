#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Course name : IDP1516
 Activity    : Instalación personalizada de Debian7
 MV OS       : GNU/Linux Debian 7
=end

check :hostname_configurations do
  desc "Checking SSH port <"+get(:host1_ip)+">"
  on :localhost, :execute => "nmap #{get(:host1_ip)} | grep ssh|wc -l"
  expect result.to_i.equal?(1)

  _hostname="#{get(:lastname1)}.#{get(:lastname2)}"
  desc "Checking hostname <"+_hostname+">"
  on :host1, :execute => "hostname -f"
  expect result.equal?(_hostname)

  unique "hostname", result.value	
  on :host1, :execute => "blkid |grep sda1"
  unique "UUID", result.value	
end

check :user_definitions do
  username=get(:firstname)

  desc "User <#{username}> exists"
  on :host1, :execute => "cat /etc/passwd | grep '#{username}:' | wc -l"
  expect result.to_i.equal?(1)

  desc "Users <#{username}> with not empty password "
  on :host1, :exceute => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.to_i.equal?(1)

  desc "User <#{username}> logged"
  on :host1, :execute => "last | grep #{username[0,8]} | wc -l"
  expect result.to_i.not_equal?(0)
end

check :disk_size do
  size='10G'
  desc "Disk sda size <#{size}>"
  on :host1, :execute => "lsblk |grep disk| grep sda| grep #{size}| wc -l"
  expect result.to_i.equal?(1)
end

check :partitions_size_and_type do
  partitions={ :sda5 => ['[SWAP]','953M', '952M'],
               :sda6 => ['/'     ,'6,5G', '6,5G'],
               :sda7 => ['/home' ,'476M', '475M'],
               :sda8 => ['sda8'  ,'94M' , '93M']
                }
  
  partitions.each_pair do |key,value|
    desc "Partition #{key} mounted on <#{value[0]}>"
    on :host1, :execute => "lsblk |grep part| grep #{key}| grep #{value[0]}| wc -l"
    expect result.to_i.equal?(1)

    desc "Partition #{key} size <#{value[1]}>"
    on :host1, :execute => "lsblk |grep part| grep #{key}| tr -s ' ' ':'| cut -d ':' -f 5"
    expect(result.to_s.equal?(value[1]) || result.to_s.equal?(value[2]))    
  end

  partitions={ ['/dev/disk', '/', 'ext4'],
               ['/dev/disk', '/', 'ext4']
  }
  
  partitions.each_pair do |key,value|  
     desc "Partition #{key} type <#{value}>"
    on :host1, :execute => "df -hT | grep #{key}| grep #{value}|wc -l"
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
