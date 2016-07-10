
task "<wincli[12]> external configuration" do

  winclients=[ 
           { :label      => 'wincli1', 
             :goto       => :wincli1, 
             :ip         => :wincli1_ip, 
             :short_name => get(:wincli1_sname).upcase } ,
           { :label      => 'wincli2', 
             :goto       => :wincli2, 
             :ip         => :wincli2_ip, 
             :short_name => get(:wincli2_sname).upcase } 
          ]
         
  winclients.each do |cli|
    target "Conection with <#{get(cli[:ip])}>"
    goto   :localhost, :exec => "ping #{get(cli[:ip])} -c 1"
    expect result.find!("Destination Host Unreachable").count!.eq 0
  
    goto   :localhost, :exec => "nmap -Pn #{get(cli[:ip])}" #Execute command once

    ports=[ [ '23/tcp' , 'telnet'], 
            [ '139/tcp', 'netbios-ssn'] ]

    ports.each do |port|
      target "#{cli[:label]} #{get(cli[:ip])} port #{port[0]}"
      result.restore! # Eval result several times over the same original result
      expect result.grep!(port[0]).grep!("open").grep!(port[1]).count!.eq(1)
    end
  end
  
end

task "<wincli[12]> internal configurations" do
  
  winclients=[ 
           { :label       => 'wincli1', 
             :goto        => :wincli1, 
             :ip          => :wincli1_ip, 
             :sname       => get(:wincli1_sname).upcase,
             :productname => get(:wincli1_productname) } ,
           { :label       => 'wincli2', 
             :goto        => :wincli2, 
             :ip          => :wincli2_ip, 
             :sname       => get(:wincli2_sname).upcase,
             :productname => get(:wincli2_productname) } 
         ]
         
  winclients.each do |cli|
    goto cli[:goto], :exec => "ipconfig /all"
    mac=result.find!("Direcci").content[0]
    log    ("#{cli[:label]}_MAC = #{mac}")
    unique "MAC", mac

    target "#{cli[:label]} version"
    goto   cli[:goto], :exec => "ver"
    expect result.find!("Windows").find!("6.1").count!.eq 1

    target "#{cli[:label]} COMPUTERNAME"
    goto   cli[:goto], :exec => "set"
    expect result.find!("COMPUTERNAME").find!(cli[:sname]).count!.eq 1

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
