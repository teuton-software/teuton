#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/teacher1'

=begin
 Demo script to run on localhost
=end

t = Teacher.new

def t.test01_localhost
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

	description "df -hT"
	tempfile "dfht.tmp"
	command "df -hT"
	run_on :localhost
	tempfile :default
	
	description "Partitions /dev/sda => 3"
	command "cat #{path_to_tempfile("dfht.tmp")} | grep sda| wc -l"
	run_on :localhost
	check result.to_i.equal?(3)

	description "Partitions /dev/sdb => 1"
	command "cat #{path_to_tempfile("dfht.tmp")} | grep sdb| wc -l"
	run_on :localhost
	check result.to_i.equal?(1)

	log "Tests finished!"
	
end

t.process

t.report.show
t.report.export :txt

