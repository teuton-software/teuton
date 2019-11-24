
# 02 - Conexión SSH a PowerShell

---

# Herramientas que uso

He creado el programa de ruby [ssh.rb](../../tests/manual/ssh.rb) para abrir
una conexión SSH a una máquina remota, ejecutar un comando y mostrar
el resutado en pantalla.

---

# Gema net/ssh

Estoy usando la gema `net/ssh`, la cual en su [documentación](hhttp://net-ssh.github.io/net-ssh/)
pone lo siguiente:

```
require 'net/ssh'

Net::SSH.start('host', 'user', password: "password") do |ssh|
  # capture all stderr and stdout output from a remote process
  output = ssh.exec!("hostname")
  puts output
end
```

> Repositorio GitHub de la gema: https://github.com/net-ssh/net-ssh

---

# Comprobaciones

## Debian 9 con servidor SSH

Todos los comandos que se ejecutan vía SSH por esta herramienta funcionan correctamente.

## MV Windows 2012 server con servidor SSH

* Manualmente -> OK (usando ssh con sshpass)

```
david@camaleon:~/proy/tools/sysadmin-game> sshpass -p profesorFP2018 ssh administrador@192.168.1.114 'get-windowsfeature -name rds-rd-server'

Display Name                                            Name                   
------------                                            ----                   
    [ ] Host de sesi�n de Escritorio remoto             RDS-RD-Server          

```

* Manualmente -> OK (usando ssh)

```
david@camaleon:~/proy/tools/sysadmin-game> ssh administrador@192.168.1.114 'get-windowsfeature -name rds-rd-server'
administrador@192.168.1.114's password:

Display Name                                            Name                   
------------                                            ----                   
    [ ] Host de sesi�n de Escritorio remoto             RDS-RD-Server          
```

* Usando el programa -> OK (Comando whoami)

```
david@camaleon:~/proy/tools/sysadmin-game> ./tests/manual/ssh.rb

Testing : {:ip=>"192.168.1.114", :username=>"Administrador", :password=>"profesorFP2018", :cmd=>"whoami"}
Output  : ["vargas42s12\\administrador\r"]

```

* Usando el programa -> ERROR!!!! (Comando get-windowsfeature) La salida está vacía.

```
david@camaleon:~/proy/tools/sysadmin-game> ./tests/manual/ssh.rb

Testing : {:ip=>"192.168.1.114", :username=>"Administrador", :password=>"profesorFP2018", :cmd=>"get-windowsfeature -name rds-rd-server"}
[ArgumentError] SSH on <Administrador@192.168.1.114> exec: get-windowsfeature -name rds-rd-server
Output  : []

```

---

# Problema

La librería `net/ssh` parece que no recoge el resultado cuando se ejecuta el comando de PowerShell `get-windowsfeature -name rds-server` en Windows 2012 server.

Pero si lo hago de forma manual SI funciona.

¿Puede ser que algunos comandos de PowerShell no se comportan como lo hacen todos los comandos y generan
una salida que no puede capturar bien la librería?
