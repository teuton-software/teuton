# encoding: utf-8

=begin
 Course name : IDP1516
 Activity    : Instalación personalizada de Debian7
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

task :disk_size do
  size='10G'
  target "Disk sda size <#{size}>"
  goto  :host1, :exec => "lsblk |grep disk| grep sda| grep #{size}| wc -l"
  expect result.eq(1)
end

task :partitions_size_and_type do
  partitions={ :sda5 => ['[SWAP]','953M', '952M'],
               :sda6 => ['/'     ,'6,5G', '6,5G'],
               :sda7 => ['/home' ,'476M', '475M'],
               :sda8 => ['sda8'  ,'94M' , '93M']
                }
  
  partitions.each_pair do |key,value|
    target "Partition #{key} mounted on <#{value[0]}>"
    goto  :host1, :exec => "lsblk |grep part| grep #{key}| grep #{value[0]}| wc -l"
    expect result.eq(1)

    target "Partition #{key} size <#{value[1]}>"
    goto  :host1, :exec => "lsblk |grep part| grep #{key}| tr -s ' ' ':'| cut -d ':' -f 5"
    expect(result.to_s.equal?(value[1]) || result.to_s.equal?(value[2]))    
  end

  partitions=[ ['/dev/disk', '/', 'ext4'], ['/dev/disk', '/', 'ext4']  ]
  
  partitions.each do |p|
    
    target "Partition #{p[1]} type <#{p[2]}>"
    goto  :host1, :exec => "df -hT | grep #{p[0]} | grep #{p[1]}| grep #{p[2]}|wc -l"
    expect result.eq(1)
  end

  
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
  :host1_ip: 172.19.2.30
  :host1_password: 45454545a
  :firstname: david
  :lastname1: vargas
  :lastname2: ruiz

=end
