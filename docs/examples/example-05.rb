#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

check :remote_hosts_configurations do
  desc "Checking user <"+get(:username)+">"
  goto :host1, :execute => "cat /etc/passwd|grep '"+get(:username)+":'|wc -l"
  expect result.equal?(1)

  desc "Checking hostname <"+get(:host1_hostname)+">"
  goto :host1, :execute => "hostname -f"
  expect result.equal?(get(:host1_hostname))

  desc "Number of MBR sda partitions, must be 3"
  goto :host1, :execute => "fdisk -l|grep -v Disco|grep sda"
  expect result.content.count==3
	
  desc "Free space on rootfs > 10%"
  goto :host1, :execute => "df -hT| grep rootfs| tr -s ' ' ':'|cut -d : -f 6"
  expect result.is_less_than?(90)

  goto :host1, :execute => "ifconfig| grep eth0| tr -s ' ' '$'|cut -d $ -f 5"
  unique 'eth0_MAC', result.value

end

start do
	show
	export
end

=begin
---
:global:
  :host1_username: root
  :host1_password: profesor
:cases:
- :tt_members: root
  :tt_emails: root@email.com
  :host1_ip: 192.168.1.201
  :host1_hostname: debian.vargas
  :username: root
- :tt_members: profesor
  :tt_emails: profesor@email.com
  :host1_username: root
  :host1_password: claveincorrecta
  :host1_ip: 192.168.1.201
  :host1_hostname: david.vargas
  :username: profesor
- :tt_members: profesor
  :tt_emails: profesor@email.com
  :host1_username: usuarioincorrecto
  :host1_password: profesor
  :host1_ip: 192.168.1.201
  :host1_hostname: david.vargas
  :username: profesor
- :tt_members: david
  :tt_skip: false
  :tt_emails: david@email.com
  :host1_ip: 192.168.1.203
  :host1_hostname: david.vargas
  :username: david
=end
