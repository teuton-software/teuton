
=begin
 Course   : 201314
 Activity : IDP U1 Actividad 1
 Author   : David Vargas Ruiz
=end

task "host1 check_config"
	
	#variables defined with the same value for every case
	lsDefault_os='deb7'
	
	target "Zona horaria WEST"
	goto   :host1, :exec => "date"
	expect result.find!("WEST").find!(get(:year).count!.eq 1

	target "Checking username <#{get(:username)}>"
	goto   :host1, :exec => "cat /etc/passwd"
	expect result.find!(get(:username)).count!.eq 1

	target "Cheking hostname <#{get(:hostname)}>"
	goto   :host1, :exec => "hostname"
	expect result.eq get(:hostname)
	
	target "Checking dnsdomainname <#{get(:domainname)}>"
	goto   :host1, :exec => "dnsdomainname"
	expect result.eq get(:domainname)

	target "We don't need GUI installed"
	goto   :host1, :exec => "dir /etc/rc2.d/*dm"
	check  result.count!.eq 0

	#Some students used debian6 instead of debian7
	target "SO Debian instalado"
	if get(:os)=='debian6' then
		log "OS mode = <#{get(:os)}>"
	    goto  :host1, :exec => "uname -a| grep Linux"
	else
		goto  :host1, :exec => "uname -a| grep #{get(:default_os} | grep #{get(:hostname)}"
    end
	expect result.eq 1
    
	command "fdisk -l"
	tempfile 'fdiskl.tmp'
	run_from :host1

	target  "Número de particiones 5"
	command "cat var/tmp/fdiskl.tmp| grep -v Dis| grep '/dev/sd'| wc -l"
	run_from :localhost
	check result.to_i.equal?(5)
	
	command "cat var/tmp/fdiskl.tmp |grep Dis|tr -s ' ' ':'|tr ',' '.'|cut -f 3 -d :"
	description "Tamaño del disco 10GB"
	run_from :localhost
	check result.to_f.is_near_to?(10)

	command "cat var/tmp/fdiskl.tmp |grep Extendida| grep '/dev/sda1'| wc -l"
	description "Partición sda1 extendida"
	run_from :localhost
	check result.to_i.equal?(1)

	command "cat var/tmp/fdiskl.tmp |grep swap| grep '/dev/sda5'| wc -l"
	description "Partición sda5 swap"
	run_from :localhost
	check result.to_i.equal?(1)

	command "cat var/tmp/fdiskl.tmp |grep Linux| grep '/dev/sda6'| wc -l"
	description "Partición sda6 lógica"
	run_from :localhost
	check result.to_i.equal?(1)

	command "cat var/tmp/fdiskl.tmp |grep Linux| grep '/dev/sda7'| wc -l"
	description "Partición sda7 lógica"
	run_from :localhost
	check result.to_i.equal?(1)

	command "cat var/tmp/fdiskl.tmp |grep Linux| grep '/dev/sda8'| wc -l"
	description "Partición sda8 lógica"
	run_from :localhost
	check result.to_i.equal?(1)

	command "df -hT"
	tempfile 'dfhT.tmp'
	run_from :host1

	if get(:os)=='debian6' then
		command "cat var/tmp/dfhT.tmp | grep '/dev/sda6'| grep ext4| wc -l"
	else
		command "cat var/tmp/dfhT.tmp | grep uuid| grep ext4| wc -l"
	end
	description "Partición raíz es ext4"
	run_from :localhost
	check result.to_i.equal?(1)

	if get(:os)=='debian6' then
		command "cat var/tmp/dfhT.tmp | grep '/dev/sda6'| tr -s ' ' ':'| tr ',' '.'|cut -f 3 -d :"
	else
		command "cat var/tmp/dfhT.tmp | grep uuid| tr -s ' ' ':'| tr ',' '.'|cut -f 3 -d :"
	end
	description "Tamaño partición raíz"
	run_from :localhost
	check result.to_f.is_near_to?(7)

	command "cat var/tmp/dfhT.tmp | grep home| grep ext3| wc -l"
	description "Partición home es ext3"
	run_from :localhost
	check result.to_i.equal?(1)

	command "cat var/tmp/dfhT.tmp | grep home| tr -s ' ' ':'| tr ',' '.'|cut -f 3 -d :"
	description "Tamaño partición home 500"
	run_from :localhost
	check result.to_f.is_near_to?(500)

	command "mount"
	tempfile 'mount.tmp'
	run_from :host1

	if get(:os)=='debian6' then
		command "cat var/tmp/mount.tmp | grep '/dev/sd'| wc -l"
		description "Nº particiones montadas 2"
		run_from :localhost
		check result.to_i.equal?(2)
	else
		command "cat var/tmp/mount.tmp | grep '/dev/sd'| wc -l"
		description "Nº particiones montadas 1"
		run_from :localhost
		check result.to_i.equal?(1)
	end

	log "Los Tests han acabado"
end


start do
  show
  export
end

