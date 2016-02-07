#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Demo script to run on localhost
=end

check :exist_user do

  desc "Checking user <"+get(:username)+">"
  goto :localhost, :execute => "id #{get(:username)}| wc -l"
  expect result.to_i.equal?(1)

end

start do
  show
  export
end

=begin
---
:global:
:cases:
- :tt_members: Superusuario
  :tt_emails: student1@email.com
  :host1_ip: 127.0.0.1
  :username: root
- :tt_members: Usuario normal
  :tt_emails: student2@email.com
  :host1_ip: 127.0.0.1
  :username: darth-maul
=end
