# encoding: utf-8

task "Configure host Debian1" do

  target "ping #{get(:debian1_ip)} to Debian"
  goto :localhost, :exec => "ping #{get(:debian1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "SSH port 22 on <"+get(:debian1_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:debian1_ip)} -Pn | grep ssh|wc -l"
  expect result.eq 1

  @student_number=get(:debian1_ip).split(".")[2]
  @student_number="0"+@student_number if @student_number.size=1
  @short_hostname=[]
  @short_hostname[1]="#{get(:lastname1)}#{@student_number}g"
  
  target "Checking hostname -a <"+@short_hostname[1]+">"
  goto :debian1, :exec => "hostname -a"
  expect result.eq @short_hostname[1]

  @domain=[]
  @domain[1]=get(:lastname2)
  
  target "Checking hostname -d <"+@domain[1]+">"
  goto :debian1, :exec => "hostname -d"
  expect result.eq domain

  @long_hostname=[]
  @long_hostname[1]="#{@short_hostname[1]}.#{@domain[1]}}"
  
  target "Checking hostname -f <"+@long_hostname[1]+">"
  goto :debian1, :exec => "hostname -f"
  expect result.eq @long_hostname[1]

  target "Exists user <#{get(:firstname)}"
  goto :debian1, :exec => "cat /etc/passwd | grep '#{get(:firstname)}:' |wc -l"
  expect result.gt 0

  target "Gateway <#{get(:gateway)}"
  goto :debian1, :exec => "route -n|grep UG|grep #{get(:gateway)} |wc -l"
  expect result.eq 1

  target "DNS <#{get(:dns)}> is running"
  goto :debian1, :exec => "ping #{get(:dns)} -c 1| grep '1 received' |wc -l"
  expect result.gt 0

  target "DNS works!"
  goto :debian1, :exec => "host www.iespuertodelacruz.es |grep 'has address' |wc -l"
  expect result.gt 0

  goto :debian1, :exec => "blkid |grep sda1"
  unique "UUID_sda1", result.value	

  @uuid_debian1=result.value
end

task "Ping from debian1 to *" do  
  target "ping debian1 to debian2_ip"
  goto :debian1, :exec => "ping #{get(:debian2_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping debian1 to debian2_name"
  goto :debian1, :exec => "ping #{@short_hostname[2]} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping debian1 to windows1_ip"
  goto :debian1, :exec => "ping #{get(:windows1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping debian1 to windows1_name"
  goto :debian1, :exec => "ping #{@short_hostname[3]} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

end

task "Configure Nagios Server" do

  packages=['nagios3', 'nagios3-doc', 'nagios-nrpe-plugin']

  packages.each do |package|
    target "Package #{package} installed"
    goto :debian1, :exec => "dpkg -l #{package}| grep 'ii' |wc -l"
    expect result.eq 1
  end

  dir="/etc/nagios3/#{get(:firstname)}.d"
  target "Directory <#{dir}> exist"
  goto :debian1, :exec => "file #{dir}| grep 'directory' |wc -l"
  expect result.eq 1

  files=['grupos','grupo-de-routers','grupo-de-servidores','grupo-de-clientes']
  pathtofiles=[]
  files.each do |file|
    f=file+@student_number+".cfg"
    target "File <#{f}> exist"
    goto :debian1, :exec => "file #{f}| grep 'ASCII text' |wc -l"
    expect result.eq 1
    
    pathtofiles << f
  end

  #grupos.XX.cfg
  filepath= pathtofiles.select { |i| i.include? 'grupos'}

  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'hostgroup' |wc -l"
  expect result.eq 3
  
  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'hostgroup_name routers#{@student_number}' |wc -l"
  expect result.eq 1

  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'hostgroup_name servidores#{@student_number}' |wc -l"
  expect result.eq 1

  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'hostgroup_name clientes#{@student_number}' |wc -l"
  expect result.eq 1

  #grupo-de-routersXX.cfg
  filepath= pathtofiles.select { |i| i.include? 'grupo-de-routers'}

  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'define host' |wc -l"
  expect result.eq 2
  
  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'host_name'| grep bender#{@student_number}' |wc -l"
  expect result.eq 1

  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'address'| grep #{get(:bender_ip)}' |wc -l"
  expect result.eq 1

  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'host_name' | grep caronte#{@student_number}' |wc -l"
  expect result.eq 1
  
  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'address'| grep #{get(:caronte_ip)}' |wc -l"
  expect result.eq 1

  #grupo-de-servidoresXX.cfg
  filepath= pathtofiles.select { |i| i.include? 'grupo-de-servidores'}

  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'define host' |wc -l"
  expect result.eq 1
  
  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'host_name'| grep leela#{@student_number}' |wc -l"
  expect result.eq 1

  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'address'| grep #{get(:leela_ip)}' |wc -l"
  expect result.eq 1

  #grupo-de-clientesXX.cfg
  filepath= pathtofiles.select { |i| i.include? 'grupo-de-clientes'}

  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'define host' |wc -l"
  expect result.eq 2
  
  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'host_name'| grep #{@short_hostname[2]}' |wc -l"
  expect result.eq 1

  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'address'| grep #{get(:debian2_ip)}' |wc -l"
  expect result.eq 1

  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'host_name'| grep #{@short_hostname[3]}' |wc -l"
  expect result.eq 1

  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'address'| grep #{get(:windows1_ip)}' |wc -l"
  expect result.eq 1
  
end

