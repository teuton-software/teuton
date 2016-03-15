#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/sysadmingame'

=begin
 State       : UNDER DEVELOPMENT
 Course name : IDP1516
 Activity    : Backup (Trimestre2)
 MV OS       : host1 => Window7
               host2 => Windows2008server
               hots3 => OpenSUSE 132
 Spanish URL : https://github.com/dvarrui/libro-de-actividades/blob/master/actividades/idp/backup/README.md
=end

task "Configure W7 and W2008server" do

  desc "ping <"+get(:host1_ip)+"> to Windows7"
  on :localhost, :execute => "ping #{get(:host1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.to_i.equal(0)

  desc "ping <"+get(:host2_ip)+"> to Windows2008server"
  on :localhost, :execute => "ping #{get(:host2_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.equal(0)
  
  desc "netbios-ssn service on <"+get(:host2_ip)+">"
  on :localhost, :execute => "nmap -Pn #{get(:host2_ip)} | grep '139/tcp'| grep 'open'|wc -l"
  expect result.equal(1)

  desc "microsoft-ds service on <"+get(:host2_ip)+">"
  on :localhost, :execute => "nmap -Pn #{get(:host2_ip)} | grep '445/tcp'| grep 'open'|wc -l"
  expect result.equal(1)

end

task "Configure OpenSSUE 13.2" do

  desc "SSH port 22 on <"+get(:host3_ip)+"> open"
  on :localhost, :execute => "nmap #{get(:host3_ip)} -Pn | grep ssh|wc -l"
  expect result.equal(1)

  hostname3a="#{get(:lastname1)}3"
  desc "Checking hostname -a <"+hostname3a+">"
  on :host3, :execute => "hostname -a"
  expect result.equal(hostname3a)

  hostname3b="#{get(:lastname2)}"
  desc "Checking hostname -d <"+hostname3b+">"
  on :host3, :execute => "hostname -d"
  expect result.equal(hostname3b)

  hostname3c="#{hostname3a}.#{hostname3b}"
  desc "Checking hostname -f <"+hostname3c+">"
  on :host3, :execute => "hostname -f"
  expect result.equal(hostname3c)

  on :host3, :execute => "blkid |grep sda1"
  unique "UUID_sda1", result.value	
  on :host3, :execute => "blkid |grep sda2"
  unique "UUID_sda2", result.value
  	
end

task "Configure users" do

  username=get(:firstname)

  desc "User <#{username}> exists"
  on :host3, :execute => "id '#{username}' | wc -l"
  expect result.equal(1)

  desc "Users <#{username}> with not empty password "
  on :host3, :execute => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.equal(1)

  desc "User <#{username}> logged"
  on :host3, :execute => "last | grep #{username[0,8]} | wc -l"
  expect result.not_equal(0)
end

task "Create files to be saved" do

  files1=['manual11.txt','manual12.txt','manual13.txt']
  dir1="/home/#{get(:firstname)}1/mydocs/"
  
  files1.each do |filename|
    filepath=dir1+filename
    desc "Exist file <#{filepath}>"
    on :host3, :execute => "file '#{filepath}' | wc -l"
    expect result.equal(1)
  end

  files2=['manual21.txt','manual22.txt','manual23.txt']
  dir2="/home/#{get(:firstname)}2/mydocs/"
  
  files2.each do |filename|
    filepath=dir2+filename
    desc "Exist file <#{filepath}>"
    on :host3, :execute => "file '#{filepath}' | wc -l"
    expect result.equal(1)
  end
end

task "Check backup output" do

  username=get(:firstname)+"1"
  groupname="root"
  
  pcnumber=get(:host3_ip).split(".")[2]
  dir="/var/backup-#{pcnumber}/#{get(:firstname)}1"
  
  desc "Exist directory <#{dir}>"
  on :host3, :execute => "file '#{dir}' | grep directory| wc -l"
  expect result.equal(1)

  desc "Owner/Group of <#{dir}>"
  on :host3, :execute => "vdir '#{dir}' -d | grep #{username}|grep #{groupname} |wc -l"
  expect result.equal(1)

  desc "Permisions of <#{dir}> must be <drwxrwx--->"
  on :host3, :execute => "vdir '#{dir}' -d | grep 'drwxrwx--- '| wc -l"
  expect result.equal(1)

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
- :tt_members: david
  :host1_ip: 172.19.2.11
  :host2_ip: 172.19.2.21
  :host3_ip: 172.19.2.51
  :host1_password: 45454545a
  :firstname: david
  :lastname1: vargas
  :lastname2: ruiz
=end
