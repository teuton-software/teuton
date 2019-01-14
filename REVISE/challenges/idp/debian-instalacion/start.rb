# encoding: utf-8

=begin
 Course name : IDP
 Activity    : Instalación personalizada de Debian
 MV OS       : GNU/Linux Debian
=end

require_relative '../lib/debian_general'
require_relative '../lib/gnulinux_user'
require_relative '../lib/debian_hostname'
require_relative '../lib/debian_network'
require_relative 'disk'

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
