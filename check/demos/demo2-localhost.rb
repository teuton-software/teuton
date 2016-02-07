#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Demo script to run on localhost
=end

check :exist_username do

  unique "username", get(:username)

  desc "Checking user <"+get(:username)+">"
  goto :localhost, :execute => "id #{get(:username)}| wc -l"
  expect result.to_i.equal?(1)

  desc "Checking home directory"
  goto '127.0.0.1', :execute => "cat /etc/passwd|grep #{get(:username)}|cut -d: -f6"
  expect result.to_s.equal?(get(:homedir))

end

check :partitions do
	
  desc "Partitions /dev/sda == 4"
  goto :localhost, :execute => "cat /proc/partitions | grep sda| wc -l"
  expect result.to_i.equal?(4)

  desc "Partitions /dev/sdb == 3"
  goto :localhost, :execute => "cat /proc/partitions | grep sdb| wc -l"
  expect result.to_i.equal?(3)
end

start do
  show
  export
end

=begin
---
:global:
  :host1_username: root
:cases:
- :tt_members: Superusuario
  :tt_emails: student1@email.com
  :host1_ip: 127.0.0.1
  :host1_password: toor
  :username: root
  :homedir: /root
- :tt_members: Usuario normal
  :tt_emails: student2@email.com
  :host1_ip: 127.0.0.1
  :host1_password: toor
  :username: darth-maul
  :homedir: /home/obiwan
=end
