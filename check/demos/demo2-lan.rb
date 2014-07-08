#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

define_test :remote_hosts do
	log "Starting tests!"

	description "Checking user <"+get(:username)+">"
	command "cat /etc/passwd|grep '"+get(:username)+":'|wc -l"
	run_on :host1
	check result.to_i.equal?(1)

	description "Checking hostname <"+get(:host1_hostname)+">"
	command "hostname -f"
	run_on :host1
	check result.to_s.equal?(get(:host1_hostname))

	description "Number of MBR sda partitions, must be 3"
	command "fdisk -l|grep -v Disco|grep sda", :tempfile => "tempfile.tmp"
	run_on :host1
	check result.content.count==3

	description "df -hT"
	command "df -hT", :tempfile => "dfht.tmp"
	run_on :host1
	filename = tempfile
	
	description "Free space on rootfs > 10%"
	command "cat #{filename}| grep rootfs| tr -s ' ' ':'|cut -d : -f 5", :tempfile => :default
	run_on :localhost
	check result.to_i.is_less_than?(90)

	log "Tests finished!"
end

start do
	show :resume
	export :all, :format => :txt
end
