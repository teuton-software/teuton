#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

=begin
 Demo script to run on localhost
=end

define_test :test01_localhost do
	log "Checking users!"

	description "Checking user <"+get(:username)+">"
	command "cat /etc/passwd|grep ':"+get(:username)+"'|wc -l"
	run_on :localhost
	check result.to_i.equal?(1)

	description "Checking home directory"
	command "cat /etc/passwd|grep #{get(:username)}|cut -d: -f6"
	run_on '127.0.0.1'
	check result.to_s.equal?(get(:homedir))

	log "Checking partitions!"

	description "Lookup for partitions"
	command "cat /proc/partitions", :tempfile => "proc-partitions.tmp"
	run_on :localhost
	
	filename = tempfile
	
	description "Partitions /dev/sda == 3"
	command "cat #{filename} | grep sda| wc -l", :tempfile => :default
	run_on :localhost
	check result.to_i.equal?(3+1)

	description "Partitions /dev/sdb == 2"
	command "cat #{filename} | grep sdb| wc -l", :tempfile => :default
	run_on :localhost
	check result.to_i.equal?(2+1)

	log "Tests finished!"
	
end

start do
	show :resume
	export :all, :formar => :txt
end
