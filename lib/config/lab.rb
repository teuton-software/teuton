#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/sysadmingame'

task "TASK NAME" do

  target "TARGET DESCRIPTION"
  goto :localhost, :exec => "COMMAND"
  expect result.equal(1)

end

start do
  show
  export
end
