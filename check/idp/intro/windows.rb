
task "Windows external configuration" do

  goto   :localhost, :exec => "nmap -Pn #{get(:host1_ip)}" #Execute command once

  ports=[ [ '23/tcp' , 'telnet'],
          [ '139/tcp', 'netbios-ssn'] ]

  ports.each do |port|
    target "windows #{get(:host1_ip)} port #{port[0]}"
    result.restore! # Eval result several times over the same original result
    expect result.grep!(port[0]).grep!("open").grep!(port[1]).count!.eq(1)
  end

  #  target "Conection with <#{get(:host1_ip)}>"
  #  goto   :localhost, :exec => "ping #{get(:host1_ip)} -c 1"
  #  expect result.find!("Destination Host Unreachable").count!.eq 0

end

=begin
task "Windows internal configurations" do

  goto :host1, :exec => "ipconfig /all"
  mac=result.find!("Direcci").content[0]
  log    ("host1_MAC = #{mac}")
  unique "MAC", mac

  target "Windows version"
  goto   :host1, :exec => "ver"
  expect result.find!("Windows").find!("6.1").count!.eq 1

  sname =get(:apellido1).to_s+"00w"
  target "Windows COMPUTERNAME"
  goto   :host1, :exec => "set"
  expect result.find!("COMPUTERNAME").find!(sname).count!.eq 1
end

=begin
    target "#{cli[:label]} enlace <#{get(:gateway_ip)}>"
    goto   cli[:goto], :exec => "ipconfig"
    expect result.find!("enlace").find!(get(:gateway_ip)).count!.eq 1

    target "#{cli[:label]} router OK"
    goto   cli[:goto], :exec => "ping 8.8.4.4"
    expect result.find!("Respuesta").count!.gt 1

    target "#{cli[:label]} DNS OK"
    goto   cli[:goto], :exec => "nslookup www.iespuertodelacruz.es"
    expect result.find!("Address:").find!("88.198.18.148").count!.eq 1

#  target "Windows1 WORKGROUP_NAME"
#  goto :windows1, :exec => "net config workstation"
#  expect result.find!("Dominio de estaci").find!("de trabajo").find!(get(:domain).to_s.upcase).count!.eq 1

    target "#{cli[:label]} ProductName"
    goto   cli[:goto], :exec => "reg query \"HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion\" /t REG_SZ"
    expect result.find!("ProductName").find!(cli[:productname]).count!.eq 1
  end

end

task "Ping from wincli1 to *" do
  target "ping wincli1 to #{get(:winserver_ip)}"
  goto   :wincli1, :exec => "ping #{get(:winserver_ip)}"
  expect result.find!("Respuesta").count!.gt 1

  target "ping wincli1 to #{get(:winserver_sname)}"
  goto   :wincli1, :exec => "ping #{get(:winserver_sname)}"
  expect result.find!("Respuesta").count!.gt 1

  target "ping wincli1 to #{get(:wincli2_ip)}"
  goto   :wincli1, :exec => "ping #{get(:wincli2_ip)}"
  expect result.find!("Respuesta").count!.gt 1

  target "ping wincli1 to #{get(:wincli2_sname)}"
  goto   :wincli1, :exec => "ping #{get(:wincli2_sname)}"
  expect result.find!("Respuesta").count!.gt 1
end

task "Ping from wincli2 to *" do
  target "ping wincli2 to #{get(:winserver_ip)}"
  goto   :wincli2, :exec => "ping #{get(:winserver_ip)}"
  expect result.find!("Respuesta").count!.gt 1

  target "ping wincli2 to #{get(:winserver_sname)}"
  goto   :wincli2, :exec => "ping #{get(:winserver_sname)}"
  expect result.find!("Respuesta").count!.gt 1

  target "ping wincli2 to #{get(:wincli1_ip)}"
  goto   :wincli2, :exec => "ping #{get(:wincli1_ip)}"
  expect result.find!("Respuesta").count!.gt 1

  target "ping wincli2 to #{get(:wincli1_sname)}"
  goto   :wincli2, :exec => "ping #{get(:wincli1_sname)}"
  expect result.find!("Respuesta").count!.gt 1
end
=end
