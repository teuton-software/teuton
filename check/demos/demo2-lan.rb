#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/tool'

check :remote_hosts_configurations do
  desc "Checking user <"+get(:username)+">"
  on :host1, :execute => "cat /etc/passwd|grep '"+get(:username)+":'|wc -l"
  expect result.to_i.equal?(1)

  desc "Checking hostname <"+get(:host1_hostname)+">"
  on :host1, :execute => "hostname -f"
  expect result.to_s.equal?(get(:host1_hostname))

  desc "Number of MBR sda partitions, must be 3"
  on :host1, :execute => "fdisk -l|grep -v Disco|grep sda"
  expect result.content.count==3
	
  desc "Free space on rootfs > 10%"
  on :host1, :execute => "df -hT| grep rootfs| tr -s ' ' ':'|cut -d : -f 6"
  expect result.to_i.is_less_than?(90)

  on :host1, :execute => "ifconfig| grep eth0| tr -s ' ' '$'|cut -d $ -f 5"
  unique 'eth0_MAC', result.value

end

start do
	show :resume
	export :all, :format => :txt
end
