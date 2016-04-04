
task "Configure Host Debian2" do

  target "ping #{get(:debian2_ip)} to Debian"
  goto :localhost, :exec => "ping #{get(:debian2_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "SSH port 22 on <"+get(:debian2_ip)+"> open"
  goto :localhost, :exec => "nmap #{get(:debian2_ip)} -Pn | grep ssh|wc -l"
  expect result.eq 1

  @short_hostname[2]="#{get(:lastname1)}#{@student_number}h"
  
  target "Checking hostname -a <"+@short_hostname[2]+">"
  goto :debian2, :exec => "hostname -a"
  expect result.eq @short_hostname[2]

  target "Checking hostname -d <"+get(:domain)+">"
  goto :debian2, :exec => "hostname -d"
  expect result.eq get(:domain)

  @long_hostname[2]="#{@short_hostname[2]}.#{get(:domain)}}"

  target "Checking hostname -f <"+@long_hostname[2]+">"
  goto :debian2, :exec => "hostname -f"
  expect result.eq @long_hostname[2]

  target "Exists user <#{get(:firstname)}"
  goto :debian2, :exec => "cat /etc/passwd | grep '#{get(:firstname)}:' |wc -l"
  expect result.gt 0

  target "Gateway <#{get(:gateway)}"
  goto :debian2, :exec => "route -n|grep UG|grep #{get(:gateway)} |wc -l"
  expect result.eq 1

  target "DNS <#{get(:dns)}> is running"
  goto :debian2, :exec => "ping #{get(:dns)} -c 1| grep '1 received' |wc -l"
  expect result.gt 0

  target "DNS works!"
  goto :debian2, :exec => "host www.iespuertodelacruz.es |grep 'has address' |wc -l"
  expect result.gt 0

  goto :debian2, :exec => "blkid |grep sda1"
  unique "UUID_sda1", result.value	

  @uuid_debian2=result.value
end

task "¿ Debian1==Debian2 ?" do
  if @uuid_debian1!=@uuid_debian2 then
    log("UUID debian1 distinto de debian2",:error)
  end  
end

task "Ping from debian2 to *" do  
  target "ping debian2 to debian1_ip"
  goto :debian2, :exec => "ping #{get(:debian1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping debian2 to debian1_name"
  goto :debian2, :exec => "ping #{@short_hostname[1]} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping debian2 to windows1_ip"
  goto :debian2, :exec => "ping #{get(:windows1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping debian2 to windows1_name"
  goto :debian2, :exec => "ping #{@short_hostname[3]} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

end

task "Configure Nagios Agent on Debian2" do

  packages=['nagios-nrpe-server', 'nagios-plugins-basic']

  packages.each do |package|
    target "Package #{package} installed"
    goto :debian2, :exec => "dpkg -l #{package}| grep 'ii' |wc -l"
    expect result.eq 1
  end

  file="/etc/nagios/nrpe.cfg"

  target "<#{file}> content"
  goto :debian2, :exec => "cat #{file}| grep 'allowed_hosts' |grep #{get(:debian1_ip)} |wc -l"
  expect result.eq 1

  target "NRPE debian1 to debian2"
  goto :debian1, :exec => "/usr/lib/nagios/plugins/check_nrpe -H #{get(:debian2_ip)} |wc -l"
  expect result.eq 1

end

=begin
La configuración del agente NRPE se realiza desde el archivo /etc/nagios/nrpe.cfg. 
Las variables a tener en cuenta en este archivo son:

    server_port=5666 #define en qué puerto (TCP) escuchará el agente. 
    Por defecto es el 5666, pero se puede setear cualquiera.

    server_address=192.168.0.3 # indica en qué dirección IP escuchará 
    el agente, en caso que el servidor posea más de una IP.

    allowed_hosts=192.168.0.100 # define qué IPs tienen permitido 
    conectarse al agente en busca de datos. Es un parámetro de seguridad mínimo para limita

command[check_users]=/usr/lib/nagios/plugins/check_users -w 5 -c 10 
# alias check_user para obtener la cantidad de usuarios logueados y alertar si hay más de 5 logueados al mismo tiempo.
command[check_load]=/usr/lib/nagios/plugins/check_load -w 15,10,5 -c 30,25,20 
#alias check_load para obtener la carga de CPU
command[check_disk]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -x sda
 #alias check_disk para obtener el espacio disponible en el disco /dev/sda y alertar si queda menos de 20% de espacio en alguna partición.

# /etc/init.d/nagios-nrpe-server restart
=end
