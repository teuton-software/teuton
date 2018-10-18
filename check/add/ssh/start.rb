
=begin
 State       : In progress...
 Course name : ADD1516
 Activity    : SSH conections
 MV OS       : GNU/Linux Debian 7
 Spanish URL : https://github.com/dvarrui/libro-de-actividades/blob/master/actividades/add/ssh/README.md
=end

require_relative "opensuse-conf"
require_relative "ssh-server-g"
require_relative "ssh-client-g"

start do
	show
	export :format => :colored_text
  send   :copy_to => :host2
end

=begin
---
:global:
  :groupname: udremote
  :host1_username: sysadmingame
  :host1_protocol: telnet
  :host2_username: root
  :host3_username: root
  :domain: 'curso1617'
:cases:
- :tt_members: Student full name
  :number: "01"
  :username: firstname
  :lastname: lastname
  :host1_password: changethis
=end
