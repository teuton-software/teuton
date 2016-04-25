
task "<winserver> external configuration" do

  @student_number=get(:winserver_ip).split(".")[2]||"99"
  @student_number="0"+@student_number if @student_number.size==1

  @short_hostname=[]
  @long_hostname=[]
  
  @short_hostname[0]="#{get(:lastname1)}#{@student_number}s"
  @long_hostname[0]="#{@short_hostname[0]}.#{get(:domain)}"

  @short_hostname[1]="#{get(:lastname1)}#{@student_number}w"
  @long_hostname[1]="#{@short_hostname[1]}.#{get(:domain)}"

  @short_hostname[2]="#{get(:lastname1)}#{@student_number}x"
  @long_hostname[2]="#{@short_hostname[2]}.#{get(:domain)}"


  target "Conection with <#{get(:winserver_ip)}>"
  goto :localhost, :exec => "ping #{get(:winserver_ip)} -c 1"
  expect result.find!("Destination Host Unreachable").count!.eq 0
  
  ports=[
          [ '23/tcp' , 'telnet'], 
          [ '53/tcp' , 'domain'],
          [ '139/tcp', 'netbios-ssn'],
          [ '389/tcp', 'ldap' ]
         ]

  ports.each do |port|
    target "windserver #{get(:winserver_ip)} port #{port[0]}"
    goto :localhost, :exec => "nmap -Pn #{get(:winserver_ip)}"
    expect result.grep!(port[0]).grep!("open").grep!(port[1]).count!.eq(1)
  end

end

task "winserver internal configurations" do
  
  goto :winserver, :exec => "ipconfig /all"
  mac=result.find!("Direcci").content[0]
  log ("winserver_MAC = #{mac}")
  unique "MAC", mac

  target "winserver version"
  goto :winserver, :exec => "ver"
  expect result.find!("Windows").find!("6.0.6002").count!.eq 1

  target "winserver COMPUTERNAME"
  goto :winserver, :exec => "set"
  expect result.find!("COMPUTERNAME").find!(@short_hostname[0].upcase).count!.eq 1

  target "winserver enlace <#{get(:gateway_ip)}>"
  goto :winserver, :exec => "ipconfig"
  expect result.find!("enlace").find!(get(:gateway_ip)).count!.eq 1

  target "winserver router OK"
  goto :winserver, :exec => "ping 8.8.4.4"
  expect result.find!("Respuesta").count!.gt 1

  target "winserver DNS OK"
  goto :winserver, :exec => "nslookup www.iespuertodelacruz.es"
  expect result.find!("Address:").find!("88.198.18.148").count!.eq 1

#  target "Windows1 WORKGROUP_NAME"
#  goto :windows1, :exec => "net config workstation"
#  expect result.find!("Dominio de estaci").find!("de trabajo").find!(get(:domain).to_s.upcase).count!.eq 1

  target "winserver ProductName"
  goto :winserver, :exec => "reg query \"HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion\" /t REG_SZ"
  expect result.find!("ProductName").find!("Windows Server").find!("2008").count!.eq 1

end

task "Ping from winserver to *" do  
  target "ping winserver to #{get(:wincli1_ip)}"
  goto :winserver, :exec => "ping #{get(:wincli1_ip)}"
  expect result.find!("Respuesta").count!.gt 1

  target "ping winserver to windows1_name"
  goto :winserver, :exec => "ping #{@short_hostname[1]}"
  expect result.find!("Respuesta").count!.gt 1

  target "ping winserver to #{get(:wincli2_ip)}"
  goto :winserver, :exec => "ping #{get(:wincli2_ip)}"
  expect result.find!("Respuesta").count!.gt 1

  target "ping winserver to windows2_name"
  goto :winserver, :exec => "ping #{@short_hostname[2]}"
  expect result.find!("Respuesta").count!.gt 1

end
