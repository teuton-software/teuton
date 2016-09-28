
task "Windows external configuration" do

  #set :host1_ip, "192.168.#{get(:number)}.11"

  target "Conection with <#{get(:host1_ip)}>"
  goto   :localhost, :exec => "ping #{get(:host1_ip)} -c 1"
  expect result.find!(", 0% packet loss").count!.eq 1

  goto   :localhost, :exec => "nmap -Pn #{get(:host1_ip)}" #Execute command once

  ports=[ [ '23/tcp' , 'telnet'],
          [ '139/tcp', 'netbios-ssn'] ]

  ports.each do |port|
    target "windows #{get(:host1_ip)} port #{port[0]}"
    result.restore! # Eval result several times over the same original result
    expect result.grep!(port[0]).grep!("open").grep!(port[1]).count!.eq(1)
  end
end

task "Windows Student configurations" do
  target "User #{get(:username)} home dir"
  goto   :host1, :exec => "dir c:\\Users"
  expect result.find!(get(:username)).count!.eq 1

  shortname = get(:apellido1).to_s+get(:number).to_s+"w"
  target "Windows COMPUTERNAME"
  goto   :host1, :exec => "set"
  expect result.find!("COMPUTERNAME").find!(shortname.upcase).count!.eq 1

  target "Windows1 WORKGROUP_NAME"
  goto   :host1, :exec => "net config workstation"
  expect result.find!("Dominio de estaci").find!("de trabajo").find!(get(:host1_domain).to_s.upcase).count!.eq 1
end

task "Windows version" do
  target "Windows version"
  goto   :host1, :exec => "ver"
  expect result.find!("Windows").find!("6.1").count!.eq 1

  target "Windows ProductName"
  goto   :host1, :exec => "reg query \"HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion\" /t REG_SZ"
  expect result.find!("ProductName").find!(get(:host1_productname)).count!.eq 1
end

task "Windows network configurations" do
  goto :host1, :exec => "ipconfig /all"
  mac=result.find!("Direcci").content[0]
  log    ("host1_MAC = #{mac}")
  unique "MAC", mac

  target "Gateway <#{get(:gateway_ip)}>"
  goto   :host1, :exec => "ipconfig"
  expect result.find!("enlace").find!(get(:gateway_ip)).count!.eq 1

  target "WWW routing OK"
  goto   :host1, :exec => "ping 8.8.4.4"
  expect result.find!("Respuesta").count!.gt 1

  target "DNS OK"
  goto   :host1, :exec => "nslookup www.iespuertodelacruz.es"
  expect result.find!("Address:").find!("88.198.18.148").count!.eq 1
end

task "Windows ping Opensuse" do
  target "ping #{get(:host2_ip)}"
  goto   :host1, :exec => "ping #{get(:host2_ip)}"
  expect result.find!("Respuesta").count!.gt 1
end
