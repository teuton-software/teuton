#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/teacher2'
require_relative '../../lib/case'

class Case

	def test01_localhost
		description "Checking user <"+get(:username)+">"
		command "cat /etc/passwd|grep ':"+get(:username)+"'|wc -l"
		run_on :localhost
		check result.to_i.equal?(1)

		description "Checking home directory"
		command "cat /etc/passwd|grep #{get(:username)}|cut -d: -f6"
		run_on '127.0.0.1'
		check result.to_s.equal?(get(:homedir))

		description "Creating tempfiel"
		command "df -hT", :tempfile => "dfht.tmp"
		run_on :host1
		
		description "Number of sda devices, must be 3"
		command "cat #{path_to_tempfile}| grep sda"
		run_on :host1
		check result.content.count==3
	
		log "Tests finished!"
	end
	
end

t = Teacher.new
t.checkit!

t.report.show
t.report.export :txt

