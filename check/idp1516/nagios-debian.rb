# encoding: utf-8

=begin
  Course name : IDP1516
     Activity : Nagios Debian Windows (Trimestre2)
        MV OS : debian1 => Debian8
              : debian2 => Debian8
              : windows1 => Windows7
   Teacher OS : GNU/Linux
  English URL : (Under construction. Sorry!)
  Spanish URL : https://github.com/dvarrui/libro-de-actividades/blob/master/actividades/idp/monitorizar/nagios-debian-windows.md
=end 

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

task "Configure Host Debian2" do

  target "ping #{get(:debian2_ip)} to Debian"
  goto :localhost, :exec => "ping #{get(:debian2_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "SSH port 22 on <"+get(:debian2_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:debian2_ip)} -Pn | grep ssh|wc -l"
  expect result.eq 1

  @short_hostname[2]="#{get(:lastname1)}#{@student_number}h"
  
  target "Checking hostname -a <"+@short_hostname[2]+">"
  goto :debian2, :exec => "hostname -a"
  expect result.eq @short_hostname[2]

  @domain[2]=get(:lastname2)
  target "Checking hostname -d <"+@domain[2]+">"
  goto :debian2, :exec => "hostname -d"
  expect result.eq @domain[2]

  @long_hostname[2]="#{@short_hostname[2]}.#{@domain[2]}}"

  target "Checking hostname -f <"+@long_hostname[2]+">"
  goto :debian2, :exec => "hostname -f"
  expect result.eq @long_hostname[2]

  target "Exists user <#{get(:firstname)}"
  goto :debian2, :exec => "cat /etc/passwd | grep '#{get(:firstname)}:' |wc -l"
  expect result.gt 0

  target "Gateway <#{get(:gateway)}"
  goto :debian2, :exec => "route -n|grep UG|grep #{get(:gateway)} |wc -l"
  expect result.eq 1

  target "DNS <#{get(:dns)}> is running"
  goto :debian2, :exec => "ping #{get(:dns)} -c 1| grep '1 received' |wc -l"
  expect result.gt 0

  target "DNS works!"
  goto :debian2, :exec => "host www.iespuertodelacruz.es |grep 'has address' |wc -l"
  expect result.gt 0

  goto :debian2, :exec => "blkid |grep sda1"
  unique "UUID_sda1", result.value	

  @uuid_debian2=result.value
end

task "¿ Debian1==Debian2 ?" do
  if @uuid_debian1!=@uuid_debian2 then
    log("UUID debian1 distinto de debian2",:error)
  end  
end

task "Ping from debian2 to *" do  
  target "ping debian2 to debian1_ip"
  goto :debian2, :exec => "ping #{get(:debian1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping debian2 to debian1_name"
  goto :debian2, :exec => "ping #{@short_hostname[1]} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping debian2 to windows1_ip"
  goto :debian2, :exec => "ping #{get(:windows1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping debian2 to windows1_name"
  goto :debian2, :exec => "ping #{@short_hostname[3]} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

end

task "Configure Nagios Agent on Debian2" do

  packages=['nagios-nrpe-server', 'nagios-plugins-basic']

  packages.each do |package|
    target "Package #{package} installed"
    goto :debian2, :exec => "dpkg -l #{package}| grep 'ii' |wc -l"
    expect result.eq 1
  end

  file="/etc/nagios/nrpe.cfg"

  target "<#{file}> content"
  goto :debian2, :exec => "cat #{file}| grep 'allowed_hosts' |grep #{get(:debian1_ip)} |wc -l"
  expect result.eq 1

  target "NRPE debian1 to debian2"
  goto :debian1, :exec => "/usr/lib/nagios/plugins/check_nrpe -H #{get(:debian2_ip)} |wc -l"
  expect result.eq 1

end

require_relative 'nagios-debian/debian-agent'
require_relative 'nagios-debian/windows-agent'

start do
  show
  export :colored_text
  send :copy_to => :debian1
end

=begin
#Example of configuration file:
---
:global:
  :host1_username: root
:cases:
- :tt_members: david
  :host1_ip: 172.19.2.11
  :host1_password: 45454545a
  :host2_ip: 172.19.2.21
  :firstname: david
  :lastname1: vargas
  :lastname2: ruiz
=end
