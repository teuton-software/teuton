# encoding: utf-8

task "Windows configuration" do

  @short_hostname[3]="#{get(:lastname1)}#{@student_number}w"
  @long_hostname[3]="#{@short_hostname[3]}.#{get(:domain)}}"

  target "Conection with <#{get(:windows1_ip)}>"
  goto :localhost, :exec => "ping #{get(:windows1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0
  
  target "netbios-ssn service on #{get(:windows1_ip)}"
  goto :localhost, :exec => "nmap -Pn #{get(:windows1_ip)} | grep '139/tcp'| grep 'open'|wc -l"
  expect result.eq 1

end

task "Ping from windows1 to *" do  
  target "ping windows1 to debian1_ip"
  goto :windows1, :exec => "ping #{get(:debian1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping windows1 to debian1_name"
  goto :windows1, :exec => "ping #{@short_hostname[1]} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping windows1 to debian2_ip"
  goto :windows1, :exec => "ping #{get(:debian2_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping windows1 to debian2_name"
  goto :windows1, :exec => "ping #{@short_hostname[2]} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

end

=begin
task "Windows: Configure Nagios Agent" do

  file="C:\Program Files\NSClient++\nsclient.ini"

  target "File <#{file}> exist"
  goto :windows1, :exec => "file #{file}| grep 'ASCII text' |wc -l"
  expect result.eq 1

  texts=[]
  texts << "NRPEServer=1"
  texts << "CheckSystem=1"
  texts << "CheckDisk=1"
  texts << "CheckExternalScripts=1"
  
  texts << "check_load=CheckCpu"
  texts << "check_disk=CheckDriveSize"
  texts << "check_firewall_service=CheckServiceState MpsSvc"
  texts << "allowed hosts=#{get(:debian1_ip)}"
   
  texts.each do |text|
    target "<#{file}> content: \"#{text}\""
    goto :windows1, :exec => "cat #{file}| grep '#{text}' |wc -l"
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
  
  target "NRPE debian1 to windows1"
  goto :debian1, :exec => "/usr/lib/nagios/plugins/check_nrpe -H #{get(:windows1_ip)} |wc -l"
  expect result.eq 1

end
=end
