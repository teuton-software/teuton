# encoding: utf-8

task "Monit on debian1?" do

  target "netbios-ssn service on #{get(:windows1_ip)}"
  goto :localhost, :exec => "nmap -Pn #{get(:windows1_ip)} | grep '139/tcp'| grep 'open'|wc -l"
  expect result.eq 1

end

=begin

    # Fichero /etc/monit/monirc de ejemplo
    # config general
    set daemon 120
    set logfile /var/log/monit.log
    set mailserver localhost

    # Plantilla de email que se envía en las alertas
    set alert nombreusuarios@correousuario.com
    set mail-format {
      from: ALUMNO@EMAIL.ES
      subject: $SERVICE $EVENT at $DATE
      message: Monit $ACTION $SERVICE at $DATE on $HOST: $DESCRIPTION.
      Yours sincerely, monit
    }

    set httpd port 2812 and use address localhost
    allow NOMBRE_ALUMNO:CLAVE_ALUMNO

    # Monitorizar los recursos del sistema
    check system localhost
    if loadavg (1min) > 4 then alert
    if loadavg (5min) > 2 then alert
    if memory usage > 75% then alert
    if cpu usage (user) > 70% then alert
    if cpu usage (system) > 30% then alert
    if cpu usage (wait) > 20% then alert

    # Monitorizar el servicio NAGIOS
    check process nagios3 with pidfile /var/run/nagios3.pid
    start program "service nagios3 start"
    stop program  "service nagios3 stop"
    if failed port 2812 protocol nagios3 then restart
    if 5 restarts within 5 cycles then timeout
```

=end


=begin
task "Windows: Configure Nagios Agent" do

  file="/etc/monit/monitrc"

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
