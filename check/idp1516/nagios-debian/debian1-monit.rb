# encoding: utf-8


task "Debian1: Monit configuration" do

  file="/etc/monit/monitrc"

  target "File <#{file}.bak> exist"
  goto :debian1, :exec => "file #{file}.bak"
  expect result.find!("text").count!.eq 1

  target "File <#{file}> exist"
  goto :debian1, :exec => "file #{file}"
  expect result.find!("text").count!.eq 1

  texts = []
  texts << [ "set daemon"      , "120" ]
  texts << [ "set logfile"     , "/var/log/monit.log" ]
  texts << [ "set mailserver"  , "localhost" ]
  texts << [ "set alert"       , "@" ]
  texts << [ "set mail-format" , "{" ]
  texts << [ "from:"           , "@" ]
  texts << [ "subject:"        , "$SERVICE $EVENT at $DATE" ]
  texts << [ "message:"        , "Monit $ACTION $SERVICE at $DATE on $HOST: $DESCRIPTION." ]
  texts << [ "Yours sincerely,", "monit" ]
  texts << [ "set httpd port 2812", "and use address localhost" ]
  texts << [ "allow "          , "#{get(:firstname)}:" ]
  texts << [ "check system"    , "localhost" ]
  texts << [ "if loadavg (1min)", ">", "4", "then alert" ]
  texts << [ "if loadavg (5min)", ">", "2", "then alert" ]
  texts << [ "if memory usage"  , ">", "75%", "then alert" ]
  texts << [ "if cpu usage (user)", ">", "70%", "then alert" ]
  texts << [ "if cpu usage (system)", ">", "30%", "then alert" ]
  texts << [ "if cpu usage (wait)", ">", "20%", "then alert" ]
  texts << [ "check process nagios3 with pidfile", "/var/run/nagios3.pid" ]
  texts << [ "start program" , "\"service nagios3 start\"" ]
  texts << [ "stop program"  , "\"service nagios3 stop\"" ]
  texts << [ "if failed port 2812 protocol nagios3 then restart" ]
  texts << [ "if 5 restarts within 5 cycles then timeout" ]
  
  texts.each do |text|
    target "<#{file}> must contain <#{text.join(" ")}> line"
    goto   :windows1, :exec => "type #{file}"
    
    text.each { |item| result.find!(item) }
    expect result.count!.eq(1), :weight => 0.2
  end
end

task "Debian1: Restart Monit service" do

  target "Debian1: Stop monit service"
  goto   :debian1, :exec => "service monit stop"
  goto   :debian1, :exec => "service monit status"
  expect result.find!("Active").find!("inactive").count!.eq 1

  target "Debian1: Start monit service"
  goto   :debian1, :exec => "service monit start"
  goto   :debian1, :exec => "service monit status"
  expect result.find!("Active").find!("active").count!.eq(1), :weight => 2

  target "Debian1: monit working on por 2812"
  goto   :debian1, :exec => "netstat -ntap"
  expect result.find!("2812/tcp").find!("monit").count!.eq(1), :weight => 2

  target "nmap debian1"
  goto :localhost, :exec => "nmap -Pn #{get(:debian1_ip)}"
  expect result.find!("2812/tcp").find!("open").count!.eq(1)

end
