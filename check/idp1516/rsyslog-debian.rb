#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/sysadmingame'

=begin
  Course name : IDP1516
     Activity : RSyslog Debian (Trimestre2)
        MV OS : host1 => Debian8
              : host2 => Windows7
   Teacher OS : GNU/Linux
  English URL : (Under construction. Sorry!)
  Spanish URL : https://github.com/dvarrui/libro-de-actividades/blob/master/actividades/idp/monitorizar/eventos-locales-windows-debian.md
=end 

task :host1_configurations do

  target "ping #{get(:host1_ip)} to Debian"
  goto :localhost, :exec => "ping #{get(:host1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.equal?(0)

  target "SSH port 22 on <"+get(:host1_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:host1_ip)} -Pn | grep ssh|wc -l"
  expect result.equal?(1)

  hostname1a="#{get(:lastname1)}"
  target "Checking hostname -a <"+hostname1a+">"
  goto :host1, :exec => "hostname -a"
  expect result.equal?(hostname1a)

  hostname1b="#{get(:host1_hostname)}"
  target "Checking hostname -d <"+hostname1b+">"
  goto :host1, :exec => "hostname -d"
  expect result.equal?(hostname1b)

  hostname1c="#{hostname1a}.#{hostname1b}"
  target "Checking hostname -f <"+hostname1c+">"
  goto :host1, :exec => "hostname -f"
  expect result.equal?(hostname1c)

  goto :host1, :exec => "blkid |grep sda1"
  unique "UUID_sda1", result.value	
  goto :host1, :exec => "blkid |grep sda2"
  unique "UUID_sda2", result.value	

end

task :host2_configurations do

  target "ping #{get(:host2_ip)} to Windows2012"
  goto :localhost, :exec => "ping #{get(:host2_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.equal?(0)
  
  target "netbios-ssn service on #{get(:host2_ip)}"
  goto :localhost, :exec => "nmap -Pn #{get(:host2_ip)} | grep '139/tcp'| grep 'open'|wc -l"
  expect result.equal?(1)

end

task :host1_user_definitions do

  username=get(:firstname)

  target "User <#{username}> exists"
  goto :host1, :exec => "id '#{username}' | wc -l"
  expect result.equal?(1)

  target "Users <#{username}> with not empty password "
  goto :host1, :exec => "cat /etc/shadow | grep '#{username}:' | cut -d : -f 2| wc -l"
  expect result.equal?(1)

  target "User <#{username}> logged"
  goto :host1, :exec => "last | grep #{username[0,8]} | wc -l"
  expect result.not_equal?(0)
end

task :webmin_on_host1 do

  target "Webmin installed"
  goto :host1, :exec => "dpkg -l webmin| grep webmin| wc -l"
  expect result.equal? 1

  target "Executing Webmin"
  goto :host1, :exec => "ps -ef|grep webmin| wc -l"
  expect result.equal? 1
  
  target "Webmin working on port 10000"
  goto :host1, :exec => "netstat -ntap|grep webmin| grep '127.0.0.1:10000'| wc -l"
  expect result.equal? 1
  
end

task :rsyslog_on_host1 do

  target "rsyslog configuration"
  goto :host1, :exec => "file /etc/rsyslog.d/#{get(:firstname)}.conf | grep text| wc -l"
  expect result.equal? 1

  target "Exist <prueba-local.log> file"
  goto :host1, :exec => "file /var/log/#{get(:firstname)}/prueba-local.log| grep text |wc -l"
  expect result.equal? 1

  target "Content of prueba-local.log file"
  goto :host1, :exec => "file /var/log/#{get(:firstname)}/prueba-local.log| grep text |wc -l"
  expect result.equal? 1

  target "Test rsyslog configuration with logger command"
  content="sysadmin-game."+(rand 100).to_s
  goto :host1, :exec => "logger -p local0.info '#{content}'"
  goto :host1, :exec => "cat /var/log/#{get(:firstname)}/prueba-local.log| grep #{content} |wc -l"
  expect result.is_greater_than? 0

end

task :host1_logrotate do

  target "Exist logrotate configuration file"
  goto :host1, :exec => "file /etc/logrotate.d/#{get(:firstname)} | grep text| wc -l"
  expect result.equal? 1

  target "Logrotate configuration contains our log file"
  goto :host1, :exec => "cat /etc/logrotate.d/#{get(:firstname)} | grep '/var/log/#{get(:firstname)}'| wc -l"
  expect result.equal? 1

end

start do
  show
  export :colored_text
  send :copy_to => :host1
end

=begin
#Example of configuration file:
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
