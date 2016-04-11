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
  expect result.find!("COMPUTERNAME").find!(@short_hostname[3].upcase).count!.eq 1

  target "Windows1 enlace <#{get(:bender_ip)}>"
  goto :windows1, :exec => "ipconfig"
  expect result.find!("enlace").find!(get(:bender_ip)).count!.eq 1

  target "Windows1 router OK"
  goto :windows1, :exec => "ping 8.8.4.4"
  expect result.find!("Respuesta").count!.gt 1

  target "Windows1 DNS OK"
  goto :windows1, :exec => "nslookup www.iespuertodelacruz.es"
  expect result.find!("Address:").find!("88.198.18.148").count!.eq 1

  target "Windows1 WORKGROUP_NAME"
  goto :windows1, :exec => "net config workstation"
  expect result.find!("Dominio de estaci").find!("de trabajo").find!(get(:dominio).upcase).count!.eq 1

  target "Windows1 ProductName"
  goto :windows1, :exec => "reg query \"HKLM\Software\Microsoft\Windows NT\CurrentVersion\" /t REG_SZ"
  expect result.find!("ProductName").find!(get(:windows1_productname)).count!.eq 1

end

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
