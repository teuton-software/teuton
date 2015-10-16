#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Course name : IDP1516
 Activity    : Commands 01
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
  on :host1, :execute => "cat /etc/passwd | grep #{username} | wc -l"
  expect result.to_i.equal?(1)

  desc "Users <#{username}> with not empty password "
  on :host1, :exceute => "cat /etc/shadow | grep #{username}| cut -d : -f 2| wc -l"
  expect result.to_i.equal?(1)

  desc "User <#{username}> logged"
  on :host1, :execute => "last | grep #{username[0,8]} | wc -l"
  expect result.to_i.not_equal?(0)
end

check :directory_and_files_created do
  dirs=[ 'fuw', 'idp', 'lnd', 'lnt' ]
  
  dirs.each do |dirname|
    dirfullname="/home/#{get(:firstname)}/Documentos/curso1516/#{dirname}"
    desc "Exist directory <#{dirfullname}>"
    on :host1, :execute => "vdir #{dirfullname} -d | wc -l"
    expect result.to_i.equal?(1)
    
    filefullname="#{dirfullname}/leeme.txt"
    desc "Exist file <#{filefullname}>"
    on :host1, :execute => "vdir #{filefullname} | wc -l"
    expect result.to_i.equal?(1)

    desc "Content file <#{filefullname}> with <#{get(:firstname)}>"
    on :host1, :execute => "cat #{filefullname} | grep #{get(:firstname)}| wc -l"
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
