# encoding: utf-8

=begin
 Course name : IDP1516
 Activity    : Commands 01
 MV OS       : GNU/Linux Debian 7
=end

task :hostname_configurations do
  target "Checking SSH port <"+get(:host1_ip)+">"
  goto  :localhost, :exec => "nmap #{get(:host1_ip)} | grep ssh|wc -l"
  expect result.eq(1)

  _hostname="#{get(:lastname1)}.#{get(:lastname2)}"
  target "Checking hostname <"+_hostname+">"
  goto  :host1, :exec => "hostname -f"
  expect result.equal?(_hostname)

  unique "hostname", result.value	
  goto  :host1, :exec => "blkid |grep sda1"
  unique "UUID", result.value	
end

task :user_definitions do
  username=get(:firstname)

  target "User <#{username}> exists"
  goto  :host1, :exec => "cat /etc/passwd | grep '#{username}:' | wc -l"
  expect result.eq(1)

  target "Users <#{username}> with not empty password "
  goto  :host1, :exceute => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.eq(1)

  target "User <#{username}> logged"
  goto  :host1, :exec => "last | grep #{username[0,8]} | wc -l"
  expect result.neq(0)
end

task :directory_and_files_created do
  dirs=[ 'fuw', 'idp', 'lnd', 'lnt' ]
  
  dirs.each do |dirname|
    dirfullname="/home/#{get(:firstname)}/Documentos/curso1516/#{dirname}"
    target "Exist directory <#{dirfullname}>"
    goto  :host1, :exec => "vdir #{dirfullname} -d | wc -l"
    expect result.eq(1)
    
    filefullname="#{dirfullname}/leeme.txt"
    target "Exist file <#{filefullname}>"
    goto  :host1, :exec => "vdir #{filefullname} | wc -l"
    expect result.eq(1)

    target "Content file <#{filefullname}> with <#{get(:firstname)}>"
    goto  :host1, :exec => "cat #{filefullname} | grep #{get(:firstname)}| wc -l"
    expect result.eq(1)    
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
