#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Course name : IDP1516
 Activity    : RSyslog Debian (Trimestre2)
 MV OS       : host1 => Debian8
               host2 => Windows7
=end


check :host1_configurations do

  desc "ping #{get(:host1_ip)} to Debian"
  goto :localhost, :execute => "ping #{get(:host1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.equal?(0)

  desc "SSH port 22 on <"+get(:host1_ip)+"> open"
  goto :localhost, :execute => "nmap #{get(:host1_ip)} -Pn | grep ssh|wc -l"
  expect result.equal?(1)

  hostname1a="#{get(:lastname1)}"
  desc "Checking hostname -a <"+hostname1a+">"
  goto :host1, :execute => "hostname -a"
  expect result.equal?(hostname1a)

  hostname1b="#{get(:host1_hostname)}"
  desc "Checking hostname -d <"+hostname1b+">"
  goto :host1, :execute => "hostname -d"
  expect result.equal?(hostname1b)

  hostname1c="#{hostname1a}.#{hostname1b}"
  desc "Checking hostname -f <"+hostname1c+">"
  goto :host1, :execute => "hostname -f"
  expect result.equal?(hostname1c)

  goto :host1, :execute => "blkid |grep sda1"
  unique "UUID_sda1", result.value	
  goto :host1, :execute => "blkid |grep sda2"
  unique "UUID_sda2", result.value	

end

check :host2_configurations do

  desc "ping #{get(:host2_ip)} to Windows2012"
  goto :localhost, :execute => "ping #{get(:host2_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.equal?(0)
  
  desc "netbios-ssn service on #{get(:host2_ip)}"
  goto :localhost, :execute => "nmap -Pn #{get(:host2_ip)} | grep '139/tcp'| grep 'open'|wc -l"
  expect result.equal?(1)

end

check :host1_user_definitions do

  username=get(:firstname)

  desc "User <#{username}> exists"
  goto :host1, :execute => "id '#{username}' | wc -l"
  expect result.equal?(1)

  desc "Users <#{username}> with not empty password "
  goto :host1, :execute => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.equal?(1)

  desc "User <#{username}> logged"
  goto :host1, :execute => "last | grep #{username[0,8]} | wc -l"
  expect result.not_equal?(0)
end

check :host1_webmin do

  desc "Webmin installed"
  goto :host1, :execute => "dpkg -l webmin| grep webmin| wc -l"
  expect result.equal? 1

  desc "Executing Webmin"
  goto :host1, :execute => "ps -ef|grep webmin| wc -l"
  expect result.equal? 1
  
  desc "Webmin working on port 10000"
  goto :host1, :execute => "netstat -ntap|grep webmin| grep '127.0.0.1:10000'| wc -l"
  expect result.equal? 1
  
end

check :host1_rsyslog do

  desc "rsyslog configuration"
  goto :host1, :execute => "file /etc/rsyslog.d/#{get(:firstname)}.conf | grep text| wc -l"
  expect result.equal? 0

  desc "Exist prueba-local.log file"
  goto :host1, :execute => "file /var/log/#{get(:firstname)}/prueba-local.log| grep text |wc -l"
  expect result.equal? 1

  desc "Content of prueba-local.log file"
  goto :host1, :execute => "file /var/log/#{get(:firstname)}/prueba-local.log| grep text |wc -l"
  expect result.equal? 1

end

check :host1_logrotate do
  desc "logrotate configuration"
  goto :host1, :execute => "file /etc/logrotate.d/#{get(:firstname)} | grep text| wc -l"
  expect result.equal? 1
end

start do
  show
  export :colored_text
  send :copy_to => :host1
end

=begin
---
:global:
  :host1_username: root
:cases:
- :tt_members: david
  :host1_ip: 172.19.2.11
  :host1_password: 45454545a
  :host2_ip: 172.19.2.21
  :firstname: david
  :lastname1: vargas
  :lastname2: ruiz
=end
