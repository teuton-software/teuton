#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Course name : IDP1516
 Activity    : Commands 01
 MV OS       : GNU/Linux Debian 7
=end

define_test :hostname_configured do
  description "Checking SSH port <"+get(:host1_ip)+">"
  run_on :localhost, :command => "nmap #{get(:host1_ip)} | grep ssh|wc -l"
  check result.to_i.equal?(1)

  _hostname="#{get(:lastname1)}.#{get(:lastname2)}"
  description "Checking hostname <"+_hostname+">"
  run_on :host1, :command => "hostname -f"
  check result.equal?(_hostname)

  unique "hostname", result.value	
  run_on :host1, :command => "blkid |grep sda1"
  unique "UUID", result.value	
end

define_test :user_defined do
  username=get(:firstname)

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

define_test :directory_tree_exists do
  dirs=[ 'fuw', 'idp', 'lnd', 'lnt' ]
  
  dirs.each do |dirname|
    dirfullname="/home/#{get(:firstname)}/Documentos/curso1516/#{dirname}"
    description "Exist directory <#{dirfullname}>"
    run_on :host1, :command => "vdir #{dirfullname} -d | wc -l"
    check result.to_i.equal?(1)
    
    filefullname="#{dirfullname}/leeme.txt"
    description "Exist file <#{filefullname}>"
    run_on :host1, :command => "vdir #{filefullname} | wc -l"
    check result.to_i.equal?(1)

    description "Content file <#{filefullname}> with <#{get(:firstname)}>"
    run_on :host1, :command => "cat #{filefullname} | grep #{get(:firstname)}| wc -l"
    check result.to_i.equal?(1)    
  end
end

start do
	show :resume
	export :all
end
