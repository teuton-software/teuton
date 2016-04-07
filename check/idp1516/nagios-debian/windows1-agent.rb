# encoding: utf-8

task "Windows1 external configuration" do

  @short_hostname[3]="#{get(:lastname1)}#{@student_number}w"
  @long_hostname[3]="#{@short_hostname[3]}.#{get(:domain)}}"

  target "Conection with <#{get(:windows1_ip)}>"
  goto :localhost, :exec => "ping #{get(:windows1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0
  
  target "netbios-ssn service on #{get(:windows1_ip)}"
  goto :localhost, :exec => "nmap -Pn #{get(:windows1_ip)} | grep '139/tcp'| grep 'open'|wc -l"
  expect result.eq 1

end

task "Windows1 internal configurations" do

  target "Windows1 version"
  goto :windows1, :exec => "ver"
  expect result.find!("Windows").find!("6.1").count!.eq 1

  target "Windows1 COMPUTERNAME"
  goto :windows1, :exec => "set"
  expect result.find!("COMPUTERNAME").find!(@short_hostname[3]).count!.eq 1

  target "Windows1 enlace <#{get(:bender_ip)}>"
  goto :windows1, :exec => "ipconfig"
  expect result.find!("enlace").find!(get(:bender_ip)).count!.eq 1

  target "Windows1 router OK"
  goto :windows1, :exec => "ping 8.8.4.4"
  expect result.find!("Respuesta").count!.gt 1

  target "Windows1 DNS OK"
  goto :windows1, :exec => "nslookup www.iespuertodelacruz.es"
  expect result.find!("Address:").find!("88.198.18.148").count!.eq 1

end

=begin
task "Ping from windows1 to *" do  
  target "ping windows1 to debian1_ip"
  goto :windows1, :exec => "ping #{get(:debian1_ip)}"
  expect result.find!("Respuesta").count!.gt 1

  target "ping windows1 to debian1_name"
  goto :windows1, :exec => "ping #{@short_hostname[1]}"
  expect result.find!("Respuesta").count!.gt 1

  target "ping windows1 to debian2_ip"
  goto :windows1, :exec => "ping #{get(:debian2_ip)}"
  expect result.find!("Respuesta").count!.gt 1

  target "ping windows1 to debian2_name"
  goto :windows1, :exec => "ping #{@short_hostname[2]}"
  expect result.find!("Respuesta").count!.gt 1

end

=begin
task "Windows: Configure Nagios Agent" do

  file="C:\Program Files\NSClient++\nsclient.ini"

  target "File <#{file}> exist"
  goto :windows1, :exec => "file #{file}| grep 'ASCII text' |wc -l"
  expect result.eq 1

  texts=[]
  texts << ["ssl options"  , "no-sslv2, no-sslv3"]
  texts << ["verify mode"  , "none"]
  texts << ["insecure"     , "true"]

  texts << ["NRPEServer"          , "1"]
  texts << ["CheckSystem"         , "1"]
  texts << ["CheckDisk"           , "1"]
  texts << ["CheckExternalScripts", "1"]
  
  texts << ["check_load"             , "CheckCpu" ]
  texts << ["check_disk"             , "CheckDriveSize" ]
  texts << ["check_firewall_service" , "CheckServiceState MpsSvc" ]
  texts << ["allowed hosts"          , get(:debian1_ip) ]
   
  texts.each do |text|
    target "<#{file}> content: <#{text.join(",")}>"
    goto   :windows1, :exec => "type #{file}"
    expect result.find!(text[0]).find!(text[1]).count!.eq 1
  end
end

task "Windows1: Restart Agent service" do

  target "Windows1: Stop agent service"
  goto   :debian2, :exec => "net stop nsclient"
  goto   :debian2, :exec => "service nagios-nrpe-server status |grep Active|grep inactive"
  expect result.eq 1

  target "Debian2: Start agent service"
  goto   :debian2, :exec => "net start nsclient"
  goto   :debian2, :exec => "service nagios-nrpe-server status |grep Active|grep active"
  expect result.eq(1), :weight => 2
  
  target "Debian1 nmap to debian2"
  goto :debian1, :exec => "nmap -Pn #{get(:debian2_ip)}"
  expect result.find!("5666").find!("open").count!.eq(1), :weight => 5

  target "NRPE debian1 to windows1"
  goto :debian1, :exec => "/usr/lib/nagios/plugins/check_nrpe -H #{get(:windows1_ip)}"
  expect result.find!("fine").count!.eq 1

end
=end
