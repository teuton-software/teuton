#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/sysadmingame'

=begin
 Course name : IDP1516
 Activity    : Commands 01
 MV OS       : GNU/Linux Debian 7
=end

task :hostname_configurations do
  target "Checking SSH port <"+get(:host1_ip)+">"
  on :localhost, :exec => "nmap #{get(:host1_ip)} | grep ssh|wc -l"
  expect result.to_i.equal?(1)

  _hostname="#{get(:lastname1)}.#{get(:lastname2)}"
  target "Checking hostname <"+_hostname+">"
  on :host1, :exec => "hostname -f"
  expect result.equal?(_hostname)

  unique "hostname", result.value	
  on :host1, :exec => "blkid |grep sda1"
  unique "UUID", result.value	
end

task :user_definitions do
  username=get(:firstname)

  target "User <#{username}> exists"
  on :host1, :exec => "cat /etc/passwd | grep '#{username}:' | wc -l"
  expect result.to_i.equal?(1)

  target "Users <#{username}> with not empty password "
  on :host1, :exceute => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.to_i.equal?(1)

  target "User <#{username}> logged"
  on :host1, :exec => "last | grep #{username[0,8]} | wc -l"
  expect result.to_i.not_equal?(0)
end

task :directory_and_files_created do
  dirs=[ 'fuw', 'idp', 'lnd', 'lnt' ]
  
  dirs.each do |dirname|
    dirfullname="/home/#{get(:firstname)}/Documentos/curso1516/#{dirname}"
    target "Exist directory <#{dirfullname}>"
    on :host1, :exec => "vdir #{dirfullname} -d | wc -l"
    expect result.to_i.equal?(1)
    
    filefullname="#{dirfullname}/leeme.txt"
    target "Exist file <#{filefullname}>"
    on :host1, :exec => "vdir #{filefullname} | wc -l"
    expect result.to_i.equal?(1)

    target "Content file <#{filefullname}> with <#{get(:firstname)}>"
    on :host1, :exec => "cat #{filefullname} | grep #{get(:firstname)}| wc -l"
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
