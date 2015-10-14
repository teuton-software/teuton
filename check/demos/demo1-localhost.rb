#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Demo script to run on localhost
=end

define_test :test01_localhost do
  log "Checking users!"

  unique "username", get(:username)

  description "Checking user <"+get(:username)+">"
  run_on :localhost, :command =>"cat /etc/passwd|grep ':"+get(:username)+"'|wc -l"
  check result.to_i.equal?(1)

  description "Checking home directory"
  run_on '127.0.0.1', :command => "cat /etc/passwd|grep #{get(:username)}|cut -d: -f6"
  check result.to_s.equal?(get(:homedir))

  log "Checking partitions!"
	
  description "Partitions /dev/sda == 3"
  run_on :localhost, :command => "cat /proc/partitions | grep sda| wc -l"
  check result.to_i.equal?(3+1)

  description "Partitions /dev/sdb == 2"
  run_on :localhost, :command => "cat /proc/partitions | grep sdb| wc -l"
  check result.to_i.equal?(2+1)
end

start do
  show :resume
  export :all, :format => :txt
  build :gamelist
end
