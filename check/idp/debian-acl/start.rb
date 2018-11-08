# encoding: utf-8

=begin
 Course name : IDP
 Activity    : Instalación personalizada de Debian
 MV OS       : GNU/Linux Debian
=end

require_relative '../lib/debian_settings'
require_relative '../lib/debian_general'

task "ACL Settings" do
	set(:linux1_ip, get(:debian1_ip))
	set(:linux1_username, get(:debian1_username))
	set(:linux1_passwd, get(:debian1_passwd))
  set(:linux1_hostname, get(:debian1_hostname))
end

require_relative '../lib/gnulinux_user'
require_relative '../lib/debian_hostname'
require_relative '../lib/debian_network'


start do
	show
	export
end

=begin
---
---
:global:
  :host1_username: root
  :dominio: curso1819
:cases:
- :tt_members: david
  :number: '03'
  :debian1_ip: 172.18.3.41
  :debian1_password: profesor
  :firstname: david
  :lastname1: vargas
  :lastname2: ruiz

=end
