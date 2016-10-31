# encoding: utf-8

=begin
 Course name : IDP1516
 Activity    : Instalación dual
 MV OS       : Window7 con OpenSUSE 132.
=end

task "Preparativos" do
  set( :firstname, get(:username))
  set( :lastname1, get(:apellido1))
  set( :lastname2, get(:apellido2))
  set( :host2_ip , "172.19.#{get(:number).to_i.to_s}.32" )
end

task :hostname_configurations do
  #target "ping to <"+get(:host1_ip)+">"
  #goto :localhost, :exec => "ping #{get(:host1_ip)} | grep errors|wc -l"
  #expect result.eq(0)

  target "SSH port 22 on <"+get(:host2_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:host2_ip)} -Pn | grep ssh|wc -l"
  expect result.eq(1)

  _hostname="DUALX#{get(:lastname1)}"
  target "Checking hostname -a <"+_hostname+">"
  goto :host2, :exec => "hostname -a"
  expect result.equal?(_hostname)

  _hostname="#{get(:lastname2)}"
  target "Checking hostname -d <"+_hostname+">"
  goto :host2, :exec => "hostname -d"
  expect result.equal?(_hostname)

  _hostname="DUALX#{get(:lastname1)}.#{get(:lastname2)}"
  target "Checking hostname -f <"+_hostname+">"
  goto :host2, :exec => "hostname -f"
  expect result.equal?(_hostname)

  goto :host2, :exec => "blkid |grep sda1"
  unique "UUID_sda1", result.value
  goto :host2, :exec => "blkid |grep sda2"
  unique "UUID_sda2", result.value
  goto :host2, :exec => "blkid |grep sda6"
  unique "UUID_sda6", result.value
  goto :host2, :exec => "blkid |grep sda7"
  unique "UUID_sda7", result.value
end

task :user_definitions do
  username=get(:firstname)

  target "User <#{username}> exists"
  goto :host2, :exec => "cat /etc/passwd | grep '#{username}:' | wc -l"
  expect result.eq(1)

  target "Users <#{username}> with not empty password "
  goto :host2, :exec => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.eq(1)

  target "User <#{username}> logged"
  goto :host2, :exec => "last | grep #{username[0,8]} | wc -l"
  expect result.neq(0)
end

task :disk_size do
  size='18'
  target "Disk sda size <#{size}>"
  goto :host2, :exec => "lsblk |grep disk| grep sda| grep #{size}|grep G| wc -l"
  expect result.eq(1)
end

task :partitions_size_and_type do
  partitions={ :sda1 => ['sda1'  ,'11,7G' , '12G'],
               :sda2 => ['sda2'  ,'100M' , '100M'],
               :sda5 => ['[SWAP]','500M', '500M'],
               :sda6 => ['/home' ,'100M', '107M'],
               :sda7 => ['/'     ,'5G', '5,3G']
                }

  partitions.each_pair do |key,value|
    target "Partition #{key} mounted on <#{value[0]}>"
    goto :host2, :exec => "lsblk |grep part| grep #{key}| grep #{value[0]}| wc -l"
    expect result.eq(1)

    target "Partition #{key} size <#{value[1]}>"
    goto :host2, :exec => "lsblk |grep part| grep #{key}| tr -s ' ' ':'| cut -d ':' -f 5"
    expect(result.to_s.equal?(value[1]) || result.to_s.equal?(value[2]))
  end

  partitions={ :sda6 => ['/dev/disk', '/home', 'ext3'],
               :sda7 => ['/dev/disk', '/'    , 'ext4']
             }

  partitions.each_pair do |key,value|
     target "Partition #{key} type <#{value[2]}>"
    goto :host2, :exec => "df -hT | grep #{key}| grep #{value[2]}|wc -l"
    expect result.eq(1)
  end
end

start do
	show
	export :format => :colored_text
  send :copy_to => :host2
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
