
#require_relative 'windows'
require_relative 'opensuse'
#require_relative 'debian'

start do
  show
  export :format => :colored_text
  send :copy_to => :host2
end

=begin
---
:global:
  :host1_protocol: telnet
  :host1_username: sysadmingame
  :gateway_ip: 172.18.0.1
  :host1_domain: curso1617
  :host1_productname: "Windows 7 Professional"
  :host2_domain: curso1617
:cases:
- :tt_members: Studen full name
  :username: firstname
  :apellido1: lastname
  :apellido2: lastname2
  :number: "01"
  :host1_password: password-for-sysadmingame-and-root
=end

