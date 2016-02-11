#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Demo script to run on localhost
=end

check :exist_user_obiwan do

  desc "Checking user <obiwan>"
  goto :localhost, :execute => "id obiwan| wc -l"
  expect result.equal?(1)

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
=end
