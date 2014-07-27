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
	command "cat /etc/passwd|grep ':"+get(:username)+"'|wc -l"
	run_on :localhost
	check result.to_i.equal?(1)

	description "Checking home directory"
	command "cat /etc/passwd|grep #{get(:username)}|cut -d: -f6"
	run_on '127.0.0.1'
	check result.to_s.equal?(get(:homedir))

	log "Checking partitions!"
	
	description "Partitions /dev/sda == 3"
	command "cat /proc/partitions | grep sda| wc -l"
	run_on :localhost
	check result.to_i.equal?(3+1)

	description "Partitions /dev/sdb == 2"
	command "cat /proc/partitions | grep sdb| wc -l"
	run_on :localhost
	check result.to_i.equal?(2+1)
	
end

start do
	show :resume
	export :all, :format => :txt
	build_gamelist
end
