# encoding: utf-8

=begin
 URL      : https://github.com/dvarrui/libro-de-actividades/blob/master/actividades/idp/permisos/permisos-acl-debian.md
 Activity : ACL en Debian
 MV OS    : GNU/Linux Debian
 Course   : IDP
=end

require_relative '../lib/debian_settings'
require_relative '../lib/debian_general'
require_relative '../lib/debian_hostname'

task "ACL Settings" do
	set(:linux1_ip, get(:debian1_ip))
	set(:linux1_username, get(:debian1_username))
	set(:linux1_password, get(:debian1_password))
  set(:linux1_hostname, get(:debian1_hostname))
end

require_relative '../lib/gnulinux_user'
require_relative '../lib/gnulinux_network'

require_relative 'discos'
require_relative 'usuariosygrupos'

start do
	show
	export :format => :colored_text
	send :copy_to => :debian1
end

=begin
---
:global:
  :debian1_username: root
  :dominio: curso1819
:cases:
- :tt_members: david
  :number: '03'
  :debian1_ip: 172.18.3.41
  :debian1_password: clave
  :firstname: david
  :lastname1: vargas
  :lastname2: ruiz

=end
