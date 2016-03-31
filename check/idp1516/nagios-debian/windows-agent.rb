# encoding: utf-8

task "Windows configuration" do

  @short_hostname[3]="#{get(:lastname1)}#{@student_number}w"
  @domain[3]=get(:lastname2)
  @long_hostname[3]="#{@short_hostname[3]}.#{@domain[3]}}"

  target "Conection with <#{get(:windows1_ip)}>"
  goto :localhost, :exec => "ping #{get(:windows1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0
  
  target "netbios-ssn service on #{get(:windows1_ip)}"
  goto :localhost, :exec => "nmap -Pn #{get(:windows1_ip)} | grep '139/tcp'| grep 'open'|wc -l"
  expect result.eq 1

end

task "Ping from windows1 to *" do  
  target "ping windows1 to debian1_ip"
  goto :windows1, :exec => "ping #{get(:debian1_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping windows1 to debian1_name"
  goto :windows1, :exec => "ping #{@short_hostname[1]} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping windows1 to debian2_ip"
  goto :windows1, :exec => "ping #{get(:debian2_ip)} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

  target "ping windows1 to debian2_name"
  goto :windows1, :exec => "ping #{@short_hostname[2]} -c 1| grep 'Destination Host Unreachable'|wc -l"
  expect result.eq 0

end

=begin
Toda la configuración se guarda en el archivo C:\Program Files\NSClient++\nsclient.ini (o C:\Archivos de Programas\NSClient++\nsclient.ini). Si no tildaron nada durante la instalación, verán que está vacío, a excepción de unos comentarios.
NSClient no utiliza el mismo formato de configuración que el visto en el host Linux, es más, varía bastante. Para empezar, la configuración se divide en secciones (formato estándar de los .ini). Por otra parte, los plugins se deben habilitar antes de ser utilizados. Además los plugins se llaman con ejecutables diferentes (CheckCpu. CheckDriveSize, etc), y los alias se definen de otra manera. Para estandarizar, en la configuración utilicé los mismos alias que en el host Linux, así es posible realizar grupos de hosts que incluyan tanto servidores Linux como Windows, y ejecutar los mismos comandos en ambos.
La configuración que utilizaremos será la siguiente:
 Para estandarizar, en la configuración utilicé los mismos alias que en el host Linux, así es posible realizar grupos de hosts que incluyan tanto servidores Linux como Windows, y ejecutar los mismos comandos en ambos.
La configuración que utilizaremos será la siguiente:

    [/modules]
    ; habilitamos el uso de NRPE
    NRPEServer = 1

    ; habilitamos plugins a utilizar. Como se ve, los plugins se agrupan por tipo.
    CheckSystem=1
    CheckDisk=1
    CheckExternalScripts=1

    ; creamos los mismos alias que en la definición del host Linux, y agregamos un alias para chequear servicios
    [/settings/external scripts/alias]
    check_load=CheckCpu MaxWarn=80 time=5m ; alias para chequear la carga de CPU. Si sobrepasa el 80% en un intervalo de 5 minutos, nos alertará.
    check_disk=CheckDriveSize ShowAll MinWarnFree=10% MinCritFree=5% ; alias para chequear el espacio en todos los discos del servidor
    check_firewall_service=CheckServiceState MpsSvc; alias para chequear el servicio del firewall de Windows (llamado MpsSvc).

    [/settings/default]
    ; permitimos el acceso al servidor Nagios para las consultas.
    allowed hosts = 192.168.0.100


=end
