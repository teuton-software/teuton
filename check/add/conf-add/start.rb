# encoding: utf-8

require_relative '../lib/opensuse_general'
require_relative '../lib/opensuse_user'
require_relative '../lib/opensuse_network'
require_relative '../lib/opensuse_ssh_hostname'

start do
	show
	export :format => :txt
	send :copy_to => :host1
end

=begin
---
:global:
  :host1_username: root
  :dominio: curso1819
:cases:
- :tt_members: david
  :number: '42'
  :host1_ip: 172.18.42.31
  :host1_password: profesor
  :firstname: david
  :lastname1: vargas
  :lastname2: ruiz

=end
