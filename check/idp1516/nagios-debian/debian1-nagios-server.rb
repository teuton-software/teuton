# encoding: utf-8

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

