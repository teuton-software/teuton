#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

define_test :remote_hosts do

	description "Checking user <"+get(:username)+">"
	command "cat /etc/passwd|grep '"+get(:username)+":'|wc -l"
	run_on :host1
	check result.to_i.equal?(1)

	description "Checking hostname <"+get(:host1_hostname)+">"
	command "hostname -f"
	run_on :host1
	check result.to_s.equal?(get(:host1_hostname))

	description "Number of MBR sda partitions, must be 3"
	command "fdisk -l|grep -v Disco|grep sda"
	run_on :host1
	check result.content.count==3
	
	description "Free space on rootfs > 10%"
	command "df -hT| grep rootfs| tr -s ' ' ':'|cut -d : -f 6"
	run_on :host1
	check result.to_i.is_less_than?(90)

	command "ifconfig| grep eth0| tr -s ' ' '$'|cut -d $ -f 5"
	run_on :host1
	unique 'eth0_MAC', result.value

end

start do
	show :resume
	export :all, :format => :txt
end
