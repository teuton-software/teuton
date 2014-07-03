#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/teacher'

define_test "localhost" do
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

end

work do
	checkit!
	report.show
	report.export :txt
end

