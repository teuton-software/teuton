#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/sysadmingame'

=begin
  Test several targets for every case into diferent hosts:
  * desc: Describe the target
  * goto: Move to localhost and execute the command
  * expect: Check if the result is equal to the expected value
  * get: Get the value for every case from the configuration YAML file.
  * send_copy: copy report to temporal directory into the host used by the case
=end

task "Configure hostname and DNS server" do

  desc "Hostname is <"+get(:host1_hostname)+">"
  goto :host1, :execute => "hostname -f"
  expect result.equal?(get(:host1_hostname))

  desc "DNS Server OK"
  goto :host1, :execute => "host www.google.es| grep 'has address'| wc -l"
  expect result.equal?(1)

end

task "Create user with your name" do

  desc "Exist user <"+get(:username)+">"
  goto :host1, :execute => "id #{get(:username)} |wc -l"
  expect result.equal?(1)

end

start do
  show
  export :format => :colored_text
  send :copy_to => :host1, :format=> :colored_text
end
