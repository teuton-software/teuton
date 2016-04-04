
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

  target "Checking hostname -d <"+get(:domain)+">"
  goto :debian2, :exec => "hostname -d"
  expect result.eq get(:domain)

  @long_hostname[2]="#{@short_hostname[2]}.#{get(:domain)}}"

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
  unique "debian2_sda1_UUID", result.value	

  @uuid_debian2=result.value
end

task "¿ Debian1==Debian2 ?" do
  if @uuid_debian1!=@uuid_debian2 then
    log("UUID debian1 distinto de debian2",:warn)
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

  target "File <#{file}> exist"
  goto :debian2, :exec => "file #{file}| grep 'ASCII text' |wc -l"
  expect result.eq 1

  target "<#{file}> content: server_port=5666"
  goto :debian2, :exec => "cat #{file}| grep 'server_port' |grep 5666 |wc -l"
  expect result.eq 1

  target "<#{file}> content: server_address=#{get(:debian2_ip)}"
  goto :debian2, :exec => "cat #{file}| grep 'server_address' |grep #{get(:debian2_ip)} |wc -l"
  expect result.eq 1

  target "<#{file}> content: allowed_hosts=127.0.0.1"
  goto :debian2, :exec => "cat #{file}| grep 'allowed_hosts' |grep '127.0.0.1'|wc -l"
  expect result.eq 1

  target "<#{file}> content: allowed_hosts=#{get(:debian1_ip)}"
  goto :debian2, :exec => "cat #{file}| grep 'allowed_hosts' |grep #{get(:debian1_ip)} |wc -l"
  expect result.eq 1

  texts=[]
  texts << "command[check_users]=/usr/lib/nagios/plugins/check_users"
  texts << "command[check_load]=/usr/lib/nagios/plugins/check_load"
  texts << "command[check_disk]=/usr/lib/nagios/plugins/check_disk"
  
  texts.each do |text|
    target "<#{file}> content: \"#{text}\""
    goto :debian2, :exec => "cat #{file}| grep '#{text}' |wc -l"
    expect result.eq 1
  end
end

task "Restart Agent service on Debian2" do

  target "Debian2: Stop agent service"
  goto   :debian2, :exec => "service nagios-nrpe-server stop"
  goto   :debian2, :exec => "service nagios-nrpe-server status |grep Active|grep inactive"
  expect result.eq 1

  target "Debian2: Start agent service"
  goto   :debian2, :exec => "service nagios-nrpe-server start"
  goto   :debian2, :exec => "service nagios-nrpe-server status |grep Active|grep active"
  expect result.eq(1), :weight => 2
  
end

task "Exec check_nrpe commands from debian1 to debian2" do

  target "NRPE debian1 to debian2"
  goto :debian1, :exec => "/usr/lib/nagios/plugins/check_nrpe -H #{get(:debian2_ip)} |wc -l"
  expect result.eq 1

end

