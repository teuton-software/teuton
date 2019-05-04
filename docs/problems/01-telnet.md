
# 01 - Conexión Telnet

> ¡Vale, lo sé! No debería estar usando Telnet ni Windows 2012.
> Pero ahora mismo es un reto personal y quiero descubrir qué está pasando.

---

# Herramientas que uso

He creado el siguiente [programa ruby](../../tests/manual/telnet.rb) para abrir
una conexión telnet a una máquina remota, ejecutar un comando y mostrar
el resutado en pantalla.

---

# Gema net/Telnet

Estoy usando la gema `net/telnet`, la cual en su [documentación](https://www.rubydoc.info/gems/net-telnet/0.2.0)
pone lo siguiente:

```
# Usage
# Log in and send a command, echoing all output to stdout

localhost = Net::Telnet::new("Host" => "localhost",
                             "Timeout" => 10,
                             "Prompt" => /[$%#>] \z/n)
localhost.login("username", "password") { |c| print c }
localhost.cmd("command") { |c| print c }
localhost.close
```

> Repositorio GitHub de la gema: https://github.com/ruby/net-telnet/

---

# Comprobaciones

## MV GNU/Linux Debian 9 con servidor telnet
* Manualmente -> OK
* Usando el programa -> OK

```
Testing : {:ip=>"192.168.1.106", :username=>"root", :password=>"profesor", :cmd=>"whoami"}
Output  : ["whoami", "root", "root@vargas42d:~# "]

Testing : {:ip=>"192.168.1.106", :username=>"profesor", :password=>"profesor", :cmd=>"whoami"}
Output  : ["whoami", "profesor", "profesor@vargas42d:~$ "]
```

## MV Windows 2008 server con servidor Telnet
* Manualmente -> OK
* Usando el programa -> OK

```
Testing : {:ip=>"192.168.1.115", :username=>"Administrador", :password=>"profesorFP2018", :cmd=>"whoami"}
Output  : ["whoami", "vargas42s08\\administrador", "", "C:\\Users\\Administrador>"]

Testing : {:ip=>"192.168.1.115", :username=>"profesor", :password=>"sayonaraBABY2018", :cmd=>"whoami"}
Output  : ["whoami", "vargas42s08\\profesor", "", "C:\\Users\\profesor>"]
```

## MV Windows 2012 server con servidor Telnet
* Manualmente -> OK

```
david@camaleon:~/proy/tools/sysadmin-game> telnet 192.168.1.114
Trying 192.168.1.114...
Connected to 192.168.1.114.
Escape character is '^]'.
Welcome to Microsoft Telnet Service

login: administrador
password:

*===============================================================
Microsoft Telnet Server.
*===============================================================
C:\Users\Administrador>whoami
vargas42s12\administrador

C:\Users\Administrador>
C:\Users\Administrador>exitConnection closed by foreign host.
david@camaleon:~/proy/tools/sysadmin-game> telnet 192.168.1.114
Trying 192.168.1.114...
Connected to 192.168.1.114.
Escape character is '^]'.
Welcome to Microsoft Telnet Service

login: profesor
password:

*===============================================================
Microsoft Telnet Server.
*===============================================================
C:\>whoami
vargas42s12\profesor

C:\>exiConnection closed by foreign host.
```
* Usando el programa -> OK

```
david@camaleon:~/proy/tools/sysadmin-game> ./tests/manual/telnet.rb

Testing : {:ip=>"192.168.1.114", :username=>"Administrador", :password=>"profesorFP2018", :cmd=>"whoami"}
Output  : ["whoami", "vargas42s12\\administrador", "", "C:\\Users\\Administrador>"]

Testing : {:ip=>"192.168.1.114", :username=>"profesor", :password=>"sayonaraBABY2018", :cmd=>"whoami"}
Output  : ["whoami", "vargas42s12\\profesor", "", "C:\\Users\\profesor>"]

```
---

# Problema

La aplicación falla cuando lo intento con Windows 2012 server.

Creo que la estoy usando correctamente, pero hay algo que funciona diferente
en Windows 2012 y no consigo identificar el qué.
