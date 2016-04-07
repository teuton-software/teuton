# encoding: utf-8

task "Windows: external configuration" do

  target "Localhost: Conection with <#{get(:windows1_ip)}>"
  goto :localhost, :exec => "ping #{get(:windows1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0
  
  target "Localhost: netbios-ssn service on #{get(:windows1_ip)}"
  goto :localhost, :exec => "nmap -Pn #{get(:windows1_ip)} | grep '139/tcp'| grep 'open'|wc -l"
  expect result.eq 1

end

task "Windows: internal configurations" do

  target "Windows version"
  goto :windows1, :exec => "ver"
  expect result.find!("Windows").find!("6.1").count!.eq 1

  target "Windows COMPUTERNAME"
  goto :windows1, :exec => "set"
  result.debug
  expect result.find!("COMPUTERNAME").find!(get(:windows1_hostname)).count!.eq 1

  target "Windows router Config<#{get(:gateway)}>"
  goto :windows1, :exec => "ipconfig"
  expect result.find!("enlace").find!(get(:gateway)).count!.eq 1

#  target "Windows router OK"
#  goto :windows1, :exec => "ping 8.8.4.4"
#  result.debug
##  result.find!(get(:dns))
#  result.debug
#  expect result.count!.eq 4

#  target "Windows DNS OK"
#  goto :windows1, :exec => "nslookup www.iespuertodelacruz.es"
#  expect result.find!("Address:").find!("88.198.18.148").count!.eq 1

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
=end

start do
  show
  export :format => :colored_text
end

