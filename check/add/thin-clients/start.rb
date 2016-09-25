#!/usr/bin/ruby
# encoding: utf-8

=begin
 State       : In progress...
 Activity    : Thin Clients LTSP
 MV OS       : GNU/Linux OpenSUSE 13.2
 Spanish URL : https://github.com/dvarrui/libro-de-actividades/blob/master/actividades/add/clientes-ligeros/README.md
=end

task "Configure hostname" do

  target "Ensure SSH port <"+get(:host1_ip)+"> is open"
  goto :localhost, :exec => "nmap #{get(:host1_ip)}"
  expect result.grep!("ssh").count!.equal(1)

  set :host1_hostname, get(:apellido1)+"."+get(:apellido2)
  target "Checking hostname <"+get(:host1_hostname)+">"
  goto :host1, :exec => "hostname -f"
  expect result.equal(get(:host1_hostname))

  unique "hostname", result.value
  goto :host1, :exec => "blkid |grep sda1"
  unique "UUID", result.value

end

task "Create users" do
  users=[1,2,3]

  users.each do |i|
    username=get(:apellido1)+i.to_s

    target "User <#{username}> exists"
	  goto :host1, :exec => "cat /etc/passwd | grep #{username} | wc -l"
	  expect result.equal(1)

	  target "Users <#{username}> with not empty password "
	  goto :host1, :exec => "cat /etc/shadow | grep #{username}| cut -d : -f 2| wc -l"
	  expect result.equal(1)

	  target "User <#{username}> logged"
	  goto :host1, :exec => "last | grep #{username[0,8]} | wc -l"
	  expect result.not_equal(0)
  end
end

task "Installed sofware" do
  packagename="tlsp"
  target "Package <#{packagename}> installed"
  goto :host1, :exec => "dpkg -l #{packagename}| grep ii| wc -l"
  expect result.equal(1)

  target "Image builded"
  goto :host1, :exec => "ltsp-info| grep 'found image'| wc -l"
  expect result.equal(1)

  goto :host1, :exec => "ltsp-info| grep 'found image'| tr -s ':' ' '|tr -s ' ' ':'| cut -d : -f 3"
  log imagefullname=result.value
end

task "Run the services" do
  services=[ 'dhcpd', 'tftpd' ]

  services.each do |service|
    target "Service <#{service}> running"
    goto :host1, :exec => "ps -ef| grep #{service}| grep -v color| wc -l"
    expect result.equal(1)
  end

  filename='/etc/default/isc-dhcp-server'
  target "<#{filename}> content"
  goto :host1, :exec => "cat #{filename}|grep INTERFACES"
  expect result.grep!('INTERFACES="eth1"').equal(1)

  filename='/etc/default/tftpd-pha'
  target "<#{filename}> content"
  goto :host1, :exec => "cat #{filename}|grep TFTP_ADDRESS"
  expect result.grep!('TFTP_ADDRESS="192.168.0.1:69"').equal(1)

end

task "Run thin clients" do
  clients = [20, 21]

  clients.each do |i|
    ip="192.168.0."+i.to_s

	  target "Thin client #{ip} into ARP table"
	  goto :host1, :exec => "arp | grep #{ip}| wc -l"
	  expect result.equal(1)

	  target "Thin client #{ip} into LOG files"
	  goto :host1, :exec => "cat /var/log/syslog |grep dhcp |grep DHCPREQUEST |grep #{ip} |wc -l"
	  expect result.greater 1

	  target "Thin client #{ip} into LOG files"
	  goto :host1, :exec => "cat /var/log/syslog |grep dhcp |grep DHCPACK |grep #{ip} |wc -l"
	  expect result.greater 1
  end

  goto :host1, :exec => "ip link | grep ether"
  unique "LTSP MAC", result.value
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
  :host1_ip: 172.18.1.41
  :host1_password: password1
  :apellido1: vargas
  :apellido2: ruiz
...
=end
