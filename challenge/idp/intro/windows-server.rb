
task "Windows Server external configuration" do

cd  set :host2_ip, "172.19.#{get(:number).to_i.to_s}.21"

  target "Conection with <#{get(:host2_ip)}>"
  goto   :localhost, :exec => "ping #{get(:host2_ip)} -c 1"
  expect result.find!(", 0% packet loss").count!.eq 1

  goto   :localhost, :exec => "nmap -Pn #{get(:host2_ip)}" #Execute command once

  ports=[ [ '22/tcp' , 'ssh'],
          [ '139/tcp', 'netbios-ssn'] ]

  ports.each do |port|
    target "windows #{get(:host2_ip)} port #{port[0]}"
    result.restore! # Eval result several times over the same original result
    expect result.grep!(port[0]).grep!("open").grep!(port[1]).count!.eq(1)
  end
end

task "Windows Server Student configurations" do
  target "User #{get(:username)} home dir"
  goto   :host1, :exec => "dir c:\\Users"
  expect result.find!(get(:username)).count!.eq 1

  shortname = get(:apellido1).to_s+get(:number).to_s+'s'
  target "Windows COMPUTERNAME"
  goto   :host2, :exec => "set"
  expect result.find!("COMPUTERNAME").find!(shortname.upcase).count!.eq 1

  #WARINING: error de acceso denegado!
  #target "Windows1 WORKGROUP_NAME"
  #goto   :host1, :exec => "net config workstation"
  #expect result.find!("Dominio de estaci").find!("de trabajo").find!(get(:host1_domain).to_s.upcase).count!.eq 1
end

task "Windows Server version" do
  target "Windows version"
  goto   :host2, :exec => "ver"
  expect result.find!("Windows").find!("6.1").count!.eq 1

  target "Windows ProductName"
  goto   :host2, :exec => "reg query \"HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion\" /t REG_SZ"
  expect result.find!("ProductName").find!(get(:host1_productname)).count!.eq 1
end

task "Windows Server network configurations" do
  goto :host2, :exec => "ipconfig /all"
  mac=result.find!("Direcci").content[0]
  log    ("host2_MAC = #{mac}")
  unique "MAC", mac
  #getmac command => MAC number

  target "Gateway <#{get(:gateway_ip)}>"
  goto   :host2, :exec => "ipconfig"
  expect result.find!("enlace").find!(get(:gateway_ip)).count!.eq 1

  target "WWW routing OK"
  goto   :host2, :exec => "ping 88.198.18.148"
  expect result.find!("Respuesta").count!.gt 1

  target "DNS OK"
  goto   :host2, :exec => "nslookup www.iespuertodelacruz.es"
  expect result.find!("Address:").find!("88.198.18.148").count!.eq 1
end
