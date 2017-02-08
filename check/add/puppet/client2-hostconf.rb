
task "Windows external configuration" do
  target "Conection with <#{get(:client2_ip)}>"
  goto   :localhost, :exec => "ping #{get(:client2_ip)} -c 1"
  expect result.find!(", 0% packet loss").count!.eq 1

  goto   :localhost, :exec => "nmap -Pn #{get(:client2_ip)}" #Execute command once

  ports=[ [ '23/tcp' , 'telnet'] ]
#          [ '139/tcp', 'netbios-ssn'] ]

  ports.each do |port|
    target "windows #{get(:client2_ip)} port #{port[0]}"
    result.restore! # Eval result several times over the same original result
    expect result.grep!(port[0]).grep!("open").grep!(port[1]).count!.eq(1)
  end
end

task "Windows Student configurations" do
  target "User #{get(:username)} home dir"
  goto   :client2, :exec => "dir c:\\Users"
  expect result.find!(get(:username)).count!.eq 1
  #expect result.find!(get(:username)[1,99]).count!.eq 1

  shortname = 'cli2alu' + get(:number).to_s
  target "Windows COMPUTERNAME"
  goto   :client2, :exec => "set"
  expect result.find!("COMPUTERNAME").find!(shortname.upcase).count!.eq 1

  #WARINING: error de acceso denegado!
  #target "Windows1 WORKGROUP_NAME"
  #goto   :host1, :exec => "net config workstation"
  #expect result.find!("Dominio de estaci").find!("de trabajo").find!(get(:host1_domain).to_s.upcase).count!.eq 1
end

task "Windows version" do
  target "Windows version"
  goto   :client2, :exec => "ver"
  expect result.find!("Windows").find!("6.1").count!.eq 1

  target "Windows ProductName"
  goto   :client2, :exec => "reg query \"HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion\" /t REG_SZ"
  expect result.find!("ProductName").find!(get(:client2_productname)).count!.eq 1
end

task "Windows network configurations" do
  goto :client2, :exec => "ipconfig /all"
  mac=result.find!("Direcci").content[0]
  log    ("host1_MAC = #{mac}")
  unique "MAC", mac
  #getmac command => MAC number

  target "Gateway <#{get(:gateway_ip)}>"
  goto   :client2, :exec => "ipconfig"
  expect result.find!("enlace").find!(get(:gateway_ip)).count!.eq 1

  target "WWW routing OK"
  goto   :client2, :exec => "ping 88.198.18.148"
  expect result.find!("Respuesta").count!.gt 1

  target "DNS OK"
  goto   :client2, :exec => "nslookup www.iespuertodelacruz.es"
  expect result.find!("Address:").find!("88.198.18.148").count!.eq 1
end
