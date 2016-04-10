# encoding: utf-8

task "Windows: Configure Nagios Agent" do

  file="C:\Program Files\NSClient++\nsclient.ini"

#  target "File <#{file}> exist"
#  goto   :windows1, :exec => "type #{file}"
#  expect result.find!("text").count!.eq 1

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

=begin
task "Windows1: Restart Agent service" do

  target "Windows1: Stop agent service"
  goto   :debian2, :exec => "net stop nsclient"
  goto   :debian2, :exec => "service nagios-nrpe-server status |grep Active|grep inactive"
  expect result.eq 1

  target "Debian2: Start agent service"
  goto   :debian2, :exec => "net start nsclient"
  goto   :debian2, :exec => "service nagios-nrpe-server status |grep Active|grep active"
  expect result.eq(1), :weight => 2
=end

task "Check service on Windows1" do

  target "Windows1: check Agent Nagios service"
  goto :windows1, :exec => "sc query"
  expect result.find!("Nagios Agent").count!.eq(1), :weight => 5

  target "Debian1 nmap to debian2"
  goto :debian1, :exec => "nmap -Pn #{get(:windows1_ip)}"
  expect result.find!("5666").find!("open").count!.eq(1), :weight => 5

  target "NRPE debian1 to windows1"
  goto :debian1, :exec => "/usr/lib/nagios/plugins/check_nrpe -H #{get(:windows1_ip)}"
  expect result.find!("fine").count!.eq 1

end
