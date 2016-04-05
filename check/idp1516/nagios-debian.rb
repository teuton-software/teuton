# encoding: utf-8

=begin
  Course name : IDP1516
     Activity : Nagios Debian Windows (Trimestre2)
        MV OS : debian1 => Debian8
              : debian2 => Debian8
              : windows1 => Windows7
   Teacher OS : GNU/Linux
  English URL : (Under construction. Sorry!)
  Spanish URL : https://github.com/dvarrui/libro-de-actividades/blob/master/actividades/idp/monitorizar/nagios-debian-windows.md
=end 

require_relative 'nagios-debian/debian1-config-mv'
require_relative 'nagios-debian/debian1-nagios-server'
require_relative 'nagios-debian/debian2-config-mv'
require_relative 'nagios-debian/debian2-agent'
#require_relative 'nagios-debian/windows-agent'

start do
  show
  export :format => :colored_text
  send :copy_to => :debian1
end

=begin
#Example of configuration file:
---
:global:
  :gateway: 172.19.0.1
  :dns: 8.8.4.4
  :bender_ip: 172.19.0.1
  :caronte_ip: 192.168.1.1
  :leela_ip: 172.20.1.2
  :debian1_username: root
  :debian2_username: root
:cases:
- :tt_members: student name
  :firstname: name
  :lastname1: lastname
  :lastname2: lastname
  :debian1_ip: 172.19.2.41
  :debian1_password: password
  :debian2_ip: 172.19.2.42
  :debian2_password: password
  :windows1_ip: 172.19.2.11
=end
