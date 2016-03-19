#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/sysadmingame'

=begin
  Test if exist user <obiwan> into localhost
  * desc: Describe the target
  * goto: Move to localhost, and execute the command
  * expect: Check if the results are equal to expected value
  
  Teacher host (localhost) must have GNU/Linux OS.
=end

task "Create user obiwan" do

  target "Checking user <obiwan>"
  goto :localhost, :execute => "id obiwan| wc -l"
  expect result.equal(1)

end

start do
  show
  export
end
