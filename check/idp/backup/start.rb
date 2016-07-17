# encoding: utf-8

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

  target "ping <"+get(:host1_ip)+"> to Windows7"
  goto   :localhost, :exec => "ping #{get(:host1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping <"+get(:host2_ip)+"> to Windows2008server"
  goto   :localhost, :exec => "ping #{get(:host2_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0
  
  target "netbios-ssn service on <"+get(:host2_ip)+">"
  goto   :localhost, :exec => "nmap -Pn #{get(:host2_ip)} | grep '139/tcp'| grep 'open'|wc -l"
  expect result.eq 1

  target "microsoft-ds service on <"+get(:host2_ip)+">"
  goto   :localhost, :exec => "nmap -Pn #{get(:host2_ip)} | grep '445/tcp'| grep 'open'|wc -l"
  expect result.eq 1

end

task "Configure OpenSUSE 13.2" do

  target "SSH port 22 on <"+get(:host3_ip)+"> open"
  goto   :localhost, :exec => "nmap #{get(:host3_ip)} -Pn | grep ssh|wc -l"
  expect result.eq 1

  hostname3a="#{get(:lastname1)}3"
  target "Checking hostname -a <"+hostname3a+">"
  goto   :host3, :exec => "hostname -a"
  expect result.eq hostname3a

  hostname3b="#{get(:lastname2)}"
  target "Checking hostname -d <"+hostname3b+">"
  goto   :host3, :exec => "hostname -d"
  expect result.eq hostname3b

  hostname3c="#{hostname3a}.#{hostname3b}"
  target "Checking hostname -f <"+hostname3c+">"
  goto   :host3, :exec => "hostname -f"
  expect result.eq hostname3c

  goto   :host3, :exec => "blkid |grep sda1"
  unique "UUID_sda1", result.value	
  goto   :host3, :exec => "blkid |grep sda2"
  unique "UUID_sda2", result.value
  	
end

task "Configure users" do

  username=get(:firstname)

  target "User <#{username}> exists"
  goto   :host3, :exec => "id '#{username}' | wc -l"
  expect result.equal(1)

  target "Users <#{username}> with not empty password "
  goto   :host3, :exec => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.equal(1)

  target "User <#{username}> logged"
  goto   :host3, :exec => "last | grep #{username[0,8]} | wc -l"
  expect result.not_equal(0)
end

task "Create files to be saved" do

  files1=['manual11.txt','manual12.txt','manual13.txt']
  dir1="/home/#{get(:firstname)}1/mydocs/"
  
  files1.each do |filename|
    filepath=dir1+filename
    target "Exist file <#{filepath}>"
    goto  :host3, :exec => "file '#{filepath}' | wc -l"
    expect result.equal(1)
  end

  files2=['manual21.txt','manual22.txt','manual23.txt']
  dir2="/home/#{get(:firstname)}2/mydocs/"
  
  files2.each do |filename|
    filepath=dir2+filename
    target "Exist file <#{filepath}>"
    goto   :host3, :exec => "file '#{filepath}' | wc -l"
    expect result.equal(1)
  end
end

task "Check backup output" do

  username=get(:firstname)+"1"
  groupname="root"
  
  pcnumber=get(:host3_ip).split(".")[2]
  dir="/var/backup-#{pcnumber}/#{get(:firstname)}1"
  
  target "Exist directory <#{dir}>"
  goto   :host3, :exec => "file '#{dir}' | grep directory| wc -l"
  expect result.equal(1)

  target "Owner/Group of <#{dir}>"
  goto   :host3, :exec => "vdir '#{dir}' -d | grep #{username}|grep #{groupname} |wc -l"
  expect result.equal(1)

  target "Permisions of <#{dir}> must be <drwxrwx--->"
  goto   :host3, :exec => "vdir '#{dir}' -d | grep 'drwxrwx--- '| wc -l"
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
