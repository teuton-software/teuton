#!/usr/bin/ruby
# encoding: utf-8

require_relative '../../lib/teacher'

define_test :ping_host do
	#Quick test to check if is the host alive or not
	@alive={}
	@alive[:host1]=false

	result = `ping -q -c 1 -i 0.3 #{get(:host1_ip)}`
	@alive[:host1]=true	if ($?.exitstatus == 0)
	verbose("host1[#{@alive[:host1]}],")
	
	@alive[:all]= @alive[:host1]
end

define_test :unique_values do
	if @alive[:host1] then
		command "ifconfig", :tempfile => "ifconfig1.tmp"
		run_on :host1
	
		value=`cat #{@tmpdir}/ifconfig1.tmp| grep Ethernet| tr -s ' ' '%'| cut -d % -f 5`
		unique value.chop, "host1 MAC"
	end	
end

define_test :pc_aula108 do
	#return if !@alive[:host1]

	description "Checking user <asir>"
	command "cat /etc/passwd|grep 'asir:'|wc -l"
	run_on :host1
	check result.to_i.equal?(1)

	description "Checking user <daw>"
	command "cat /etc/passwd|grep 'daw:'|wc -l"
	run_on :host1
	check result.to_i.equal?(1)

	description "Checking hostname <"+get(:host1_hostname)+">"
	command "hostname -f"
	run_on :host1
	check result.to_s.equal?(get(:host1_hostname))

	description "Number of sda devices, must be 3"
	command "df -h|grep sda", :tempfile => "tempfile.tmp"
	run_on :host1
	check result.content.count==3

	description "df -hT"
	command "df -hT", :tempfile => "dfht.tmp"
	run_on :host1
	filename = tempfile
	
	description "Partitions /dev/sda => 3"
	command "cat #{filename}| grep sda| wc -l", :tempfile => "counter.tmp"
	run_on :localhost
	check result.to_i.equal?(3)

	description "Free space on sda3 > 10%"
	command "cat #{filename}| grep sda3| tr -s ' ' ':'|cut -d : -f 6"
	run_on :localhost
	check result.to_i.is_less_than?(90)

	description "Free space on sda4 > 10%"
	command "cat #{filename}| grep sda4| tr -s ' ' ':'|cut -d : -f 6"
	run_on :localhost
	check result.to_i.is_less_than?(90)

	command "blkid", :tempfile => "blkid.tmp"
	run_on :host1

	log "Tests finished!"	
end

start do
	report.show
	report.export :txt
end

=begin
def t.NOtest04_uuid
#/dev/sda1: UUID="758f86be-e8c0-476b-bf48-6a08a55cade4" TYPE="swap" 
#/dev/sda2: UUID="a0db90b5-2678-4071-bb6d-55837ca11f10" TYPE="ext4" 
#/dev/sda3: UUID="47b338e0-59c7-48dc-9864-03b9aa96ac8e" TYPE="ext4" 
#/dev/sda4: UUID="e10610ba-9358-4aae-b5fe-e782d3c29ee5" TYPE="ext4" 

  uuid_sda2="a0db90b5-2678-4071-bb6d-55837ca11f10"
	uuid_sda3="47b338e0-59c7-48dc-9864-03b9aa96ac8e" 
	uuid_sda4="e10610ba-9358-4aae-b5fe-e782d3c29ee5" 
 
	desc "Checking UUID on cloned machines"
	tempfile "dvr_local.tmp"
	command "cat var/tmp/demo2-aula108/blkid.tmp |grep sda2 |grep #{uuid_sda2}|wc -l"
	check result.to_i.equal?(1)

end
=end
