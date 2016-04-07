
task "Configure Nagios Agent on Debian2" do

  packages=['nagios-nrpe-server', 'nagios-plugins-basic']

  packages.each do |package|
    target "Package #{package} installed"
    goto :debian2, :exec => "dpkg -l #{package}| grep 'ii' |wc -l"
    expect result.eq 1
  end

  file="/etc/nagios/nrpe.cfg"

  target "File <#{file}> exist"
  goto :debian2, :exec => "file #{file}|grep 'text'|wc -l"
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
  texts << [ "command", "check_users" , "/usr/lib/nagios/plugins/check_users"]
  texts << [ "command", "check_load"  , "/usr/lib/nagios/plugins/check_load"]
  texts << [ "command", "check_disk"  , "/usr/lib/nagios/plugins/check_disk"]
  texts << [ "command", "check_procs" , "/usr/lib/nagios/plugins/check_procs"]
  
  texts.each do |item|
    target "<#{file}> content: \"#{item.to_s}\""
    goto :debian2, :exec => "cat #{file}| grep -v '#'|grep #{item[0]}"
    expect result.grep!(item[1]).grep!(item[2]).count!.eq 1
  end
end

task "Debian2: Restart Agent service on Debian2" do

  target "Debian2: Stop agent service"
  goto   :debian2, :exec => "service nagios-nrpe-server stop"
  goto   :debian2, :exec => "service nagios-nrpe-server status |grep Active|grep inactive| wc -l"
  expect result.eq 1

  target "Debian2: Start agent service"
  goto   :debian2, :exec => "service nagios-nrpe-server start"
  goto   :debian2, :exec => "service nagios-nrpe-server status |grep Active|grep active| wc -l"
  expect result.eq(1), :weight => 5
  
  target "Debian1 nmap to debian2"
  goto :debian1, :exec => "nmap -Pn #{get(:debian2_ip)}"
  expect result.grep!("5666").size!.eq(1), :weight => 5

  target "NRPE debian1 to debian2"
  goto :debian1, :exec => "/usr/lib/nagios/plugins/check_nrpe -H #{get(:debian2_ip)} |wc -l"
  expect result.eq(1), :weight => 5
  
end

