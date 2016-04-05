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
    f=dir+"/"+file+@student_number+".cfg"
    target "File <#{f}> exist"
    goto :debian1, :exec => "file #{f}| grep 'ASCII text' |wc -l"
    expect result.eq 1
    
    pathtofiles << f
  end

  #grupos.XX.cfg
  f= pathtofiles.select { |i| i.include? 'grupos'}
  filepath=f[0]
  
  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'hostgroup_name' |wc -l"
  expect result.eq 3
  
  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'hostgroup_name routers#{@student_number}' |wc -l"
  expect result.eq 1

  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'hostgroup_name servidores#{@steudent_number}' |wc -l"
  expect result.eq 1

  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'hostgroup_name clientes#{@student_number}' |wc -l"
  expect result.eq 1

  #grupo-de-routersXX.cfg
  f= pathtofiles.select { |i| i.include? 'grupo-de-routers'}
  filepath=f[0]
  
  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'define host' |wc -l"
  expect result.eq 2
  
  target "<#{filepath}> content"
  goto :debian1, :exec => "cat #{filepath}| grep 'host_name'| grep bender#{@student_number} |wc -l"
  expect result.eq 1

  #Router bender
  target "<#{filepath}> content Router bender address"
  goto :debian1, :exec => "cat #{filepath}| grep 'address'| grep #{get(:bender_ip)} |wc -l"
  expect result.eq 1

  target "<#{filepath}> content Router bender host_name"
  goto :debian1, :exec => "cat #{filepath}| grep 'host_name' | grep bender#{@student_number} |wc -l"
  expect result.eq 1
  
  target "<#{filepath}> content Router caronte address"
  goto :debian1, :exec => "cat #{filepath}| grep 'address'| grep #{get(:caronte_ip)} |wc -l"
  expect result.eq 1

  target "<#{filepath}> content: Router caronte host_name"
  goto :debian1, :exec => "cat #{filepath}| grep 'host_name' | grep caronte#{@student_number} |wc -l"
  expect result.eq 1

  target "<#{filepath}> content: <parent>"
  goto :debian1, :exec => "cat #{filepath}| grep 'parent'| grep bender#{@student_number} |wc -l"
  expect result.eq 1

  #grupo-de-servidoresXX.cfg
  f= pathtofiles.select { |i| i.include? 'grupo-de-servidores'}
  filepath=f[0]
  
  target "<#{filepath}> content: <define hosts> ???"
  goto :debian1, :exec => "cat #{filepath}| grep 'define host' |wc -l"
  expect result.eq 1
  
  target "<#{filepath}> content: <host_name leela#{@student_number}>"
  goto :debian1, :exec => "cat #{filepath}| grep 'host_name'| grep leela#{@student_number} |wc -l"
  expect result.eq 1

  target "<#{filepath}> content: <address #{get(:leela_ip)}>"
  goto :debian1, :exec => "cat #{filepath}| grep 'address'| grep #{get(:leela_ip)} |wc -l"
  expect result.eq 1

  target "<#{filepath}> content: <parents bender#{@student_number}>"
  goto :debian1, :exec => "cat #{filepath}| grep 'parents'| grep bender#{@student_number} |wc -l"
  expect result.eq 1

  #grupo-de-clientesXX.cfg
  f= pathtofiles.select { |i| i.include? 'grupo-de-clientes'}
  filepath=f[0]
  
  target "<#{filepath}> content: <define host>"
  goto :debian1, :exec => "cat #{filepath}| grep 'define host' |wc -l"
  expect result.eq 2
  
  @short_hostname[2]="#{get(:lastname1)}#{@student_number}h"
  @long_hostname[2]="#{@short_hostname[2]}.#{get(:domain)}}"
  
  target "<#{filepath}> content: <host_name #{@short_hostname[2]}>"
  goto :debian1, :exec => "cat #{filepath}| grep 'host_name'| grep #{@short_hostname[2]} |wc -l"
  expect result.eq 1

  target "<#{filepath}> content: <address #{get(:debian2_ip)}>"
  goto :debian1, :exec => "cat #{filepath}| grep 'address'| grep #{get(:debian2_ip)} |wc -l"
  expect result.eq 1

  @short_hostname[3]="#{get(:lastname1)}#{@student_number}w"
  @long_hostname[3]="#{@short_hostname[3]}.#{get(:domain)}}"

  target "<#{filepath}> content <host_name #{@short_hostname[3]}>"
  goto :debian1, :exec => "cat #{filepath}| grep 'host_name'| grep #{@short_hostname[3]} |wc -l"
  expect result.eq 1

  target "<#{filepath}> content: <address #{get(:windows1_ip)}>"
  goto :debian1, :exec => "cat #{filepath}| grep 'address'| grep #{get(:windows1_ip)} |wc -l"
  expect result.eq 1
  
end

task "Debian1: Restart Nagios service" do

  target "Debian1: Stop agent service"
  goto   :debian1, :exec => "service nagios3 stop"
  goto   :debian1, :exec => "service nagios3 status |grep Active|grep inactive|wc -l"
  expect result.eq 1

  target "Debian1: Start agent service"
  goto   :debian1, :exec => "service nagios3 start"
  goto   :debian1, :exec => "service nagios3 status |grep Active|grep active|wc -l"
  expect result.eq(1), :weight => 5
  
end
