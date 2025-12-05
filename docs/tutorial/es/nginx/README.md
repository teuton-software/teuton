[<< back](../../../README.md)

# Tutorial: Nginx Web Server

Vamos a hacer un tutorial de cómo crear un test para checkear la instalación de un servidor web Nginx.

## 1. Prompt para la IA generativa

_¿Cómo no? En estos tiempos todo el mundo está hablando de la IA generativa. Así que vamos a usarla para que nos ayude con el test de Teuton? ;-)_

* Abro Gemini y le pongo el siguiente prompt:
```
Usando la siguiente plantilla de ejemplo de la herramienta Teuton:

 group "Learn about targets" do
  target "Create user obiwan", weight: 2
  run "id obiwan"
  expect ["uid=", "(obiwan)", "gid="]

  target "Delete user vader"
  run "id vader"
  expect_fail
end

start do
  show
  export
end

quiero que hagas un test para evaluar que tenemos activo el servicio web nginx 
y que la página principal index.html tiene en su contenido el texto "Hola Mundo!"
```

* La respuesta de Gemini es un buen inicio:
```ruby
group "Nginx Web Service Checks" do

  # Objetivo 1: Verificar que el servicio Nginx está activo
  # Se asume que el comando 'systemctl status' está disponible (en sistemas Linux basados en systemd)
  target "Check Nginx service status", weight: 3
  
  # Comando para verificar el estado del servicio
  run "systemctl status nginx" 
  
  # Expectativa: La salida del comando debe contener el texto "Active: active (running)"
  # para confirmar que el servicio está en ejecución.
  expect ["Active: active (running)"]


  # Objetivo 2: Verificar el contenido de la página principal (index.html)
  # Se asume que la página index.html está en el directorio raíz de Nginx (/var/www/html/ o similar)
  target "Check index.html content for 'Hola Mundo!'", weight: 5
  
  # Comando para leer el contenido del archivo de la página principal
  # NOTA: Ajusta la ruta del archivo si tu configuración Nginx es diferente.
  run "cat /var/www/html/index.html" 
  
  # Expectativa: El contenido del archivo debe incluir el texto exacto "Hola Mundo!"
  expect ["Hola Mundo!"]
end

start do
  show 
  export 
end
```

## 2. Refinamos manualmente los comentarios

Vamos a realizar algunos cambios manualmente:
* Vamos a poner los textos en español.
* Los textos de los comentarios que contengan información útil para el alumno, nos puede interesar incluirlos en el enunciado de la práctica. Para ello usamos la instrucción `readme`.
* El resto de los comentarios, me parecen evidentes, los elimino.
* En la instrucción `expect` podemos quitar los corchetes si sólo tenemos un filtro. Así, es más fácil de leer.
* El `readme` después del `group`es una aclaración de información del grupo, y el `readme` después del `target` es una aclaración de ese target concreto.

```ruby
group "Comprobar el servicio web Nginx" do
  readme "Necesitamos un SO GNU/Linux basado en systemd. Por ejemplo: OpenSUSE, Debian, etc"

  target "Comprobar el estado del servicio Nginx", weight: 3
  run "systemctl status nginx" 
  expect "Active: active (running)"

  target "Comprobar que index.html contiene el texto 'Hola Mundo!'", weight: 5
  readme "Se asume que Nginx está instalado en su ruta por defecto"
  run "cat /var/www/html/index.html" 
  expect "Hola Mundo!"
end

start do
  show 
  export 
end
```

> **NOTA**: Mientras estamos haciendo cambios en el test podemos usar los siguientes comandos para comprobar que todo va funcionando correctamente.
> * `teuton readme PATH/TO/FOLDER` para ver cómo se genera el enunciado asociado a la práctica.
> * `teutob check PATH/TO/FOLDER` para comprobar que no hay fallos en la sintaxis, etc.

## 3. Seguimos refinando y añadiendo fichero de configuración

Para tener mayor legibilidad en el futuro, el primer refinamiento que vamos a realizar es separar los tests del script principal. 
* `start.rb`: Script principal
* `nginx.rb`: Tests específicos de Nginx

```ruby
# File: start.rb (Script principal)
use "nginx"

start do
  show 
  export 
end
  
```

```ruby
# File: nginx.rb (Tests específicos de Nginx)

group "Comprobar el servicio web Nginx" do
  readme "* Necesitamos un SO GNU/Linux basado en systemd. Por ejemplo: OpenSUSE, Debian, etc."

  target "Comprobar el estado del servicio Nginx", weight: 3
  run "systemctl status nginx" 
  expect "Active: active (running)"

  target "Comprobar que index.html contiene el texto 'Hola Mundo!'", weight: 5
  readme "Se asume que Nginx está instalado en su ruta por defecto."
  run "cat /var/www/html/index.html" 
  expect "Hola Mundo!"
end
```

* Ahora mismo, el test se ejecuta directamente en la máquina `localhost`, pero vamos a modificarlo para que se pueda ejecutar en las máquinas remotas de nuestros alumnos.
* Modificamos la instrucción `run` para indicar dónde se tiene que ejecutar el comando: `run COMMAND, on: :webserver`. El nombre de host `:webserver` es completamente arbitrario. Lo ideal es poner algo significativo para nosotros como: `nginx` `server`, `host1`,  `linux`, etc. Cualquiera valdría.

```ruby
# File: nginx.rb (Tests específicos de Nginx)

group "Comprobar el servicio web Nginx" do
  readme "* Necesitamos un SO GNU/Linux basado en systemd. Por ejemplo: OpenSUSE, Debian, etc."

  target "Comprobar el estado del servicio Nginx", weight: 3
  run "systemctl status nginx", on: :webserver
  expect "Active: active (running)"

  target "Comprobar que index.html contiene el texto 'Hola Mundo!'", weight: 5
  readme "Se asume que Nginx está instalado en su ruta por defecto."
  run "cat /var/www/html/index.html", on: :webserver
  expect "Hola Mundo!"
end
```

Ahora hay que incluir un fichero de configuración para especificar la configuración específica de cada una de las máquinas de nuestros alumnos, que son las que queremos evaluar realmente.
* Nos vamos a ayudar del comando `teuton config PATH/FOLDER` para que nos sugiera un contenido a partir del test anterior.

```yaml
---
global:
cases:
- tt_members: TOCHANGE
  webserver_ip: TOCHANGE
  webserver_username: TOCHANGE
  webserver_password: TOCHANGE
```

> A partir del contenido del test, Teuton es capaz de deducir los parámetros que se necesitan para su ejecución.

* Ahora personalizamos los valores:

```yaml
---
global:
cases:
# Máquina del alumno 1
- tt_members: Alumno 1
  webserver_ip: 192.168.122.16
  webserver_username: alumno1
  webserver_password: secret1
```

## 4. Ejecutamos el test sobre las máquinas remotas

* Ahora vamos a ejecutar el test `teuton run PATH/TO/FOLDER`.

```
------------------------------------
Started at 2025-12-05 23:10:38 +0000
FF
Finished in 0.674 seconds
------------------------------------
 
CASE RESULTS
+------+----------+-------+-------+
| CASE | MEMBERS  | GRADE | STATE |
| 01   | Alumno 1 | 0.0   | ?     |
+------+----------+-------+-------+
```

* El alumno tiene una nota final de 0. Esto es porque todavía no ha realizado la práctica.

## 5. Haciendo la práctica

Me voy a convertir en el alumno1 y voy a ir haciendo la práctica.

* Lo primero que pide el enunciado es instalar el servidor web nginx. Como al alumno1 tiene una SO Debian

---
# EN CONSTRUCCTION!
---

## 4. Problema de conexión con el host remoto

* Ahora vamos a ejecutar el test `teuton run PATH/TO/FOLDER` pero nos encontramos un problema.

```
$ teuton run nginx/v02 
------------------------------------
Started at 2025-12-05 22:54:16 +0000
FF
Finished in 3.439 seconds
------------------------------------
 
CASE RESULTS
+------+---------+-------+-------+
| CASE | MEMBERS | GRADE | STATE |
| 01   | alumno1 | 0.0   | ?     |
+------+---------+-------+-------+

CONN ERRORS
+------+---------+-----------+-----------------------------+
| CASE | MEMBERS | HOST      | ERROR                       |
| 01   | alumno1 | webserver | error_authentication_failed |
+------+---------+-----------+-----------------------------+
```

La puntuación que obtiene el alumno1 es 0, pero vemos que ha habido un problema de "error de autenticación" al intentar conectar con el equipo `webserver`del alumno1.

**Comprobaciones:**
* Lo primero que pienso es que tengo el password mal puesto en el fichero de configuración, pero no, está bien configurado.
* Tenemos conectividad con el equipo remoto:
```bash
$ ping 192.168.122.16

PING 192.168.122.16 (192.168.122.16) 56(84) bytes de datos.
64 bytes desde 192.168.122.16: icmp_seq=1 ttl=64 tiempo=0.178 ms
64 bytes desde 192.168.122.16: icmp_seq=2 ttl=64 tiempo=0.459 ms
64 bytes desde 192.168.122.16: icmp_seq=3 ttl=64 tiempo=0.413 ms
^C
--- 192.168.122.16 estadísticas ping ---
3 paquetes transmitidos, 3 recibidos, 0% packet loss, time 2051ms
rtt min/avg/max/mdev = 0.178/0.350/0.459/0.123 ms
```
* Compruebo si el servicio SSH está funcionando correctamente:
```bash
webserver-alumno1# systemctl status sshd
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/usr/lib/systemd/system/ssh.service; enabled; preset: enabled)
     Active: active (running) since Fri 2025-12-05 22:12:34 WET; 46min ago
 Invocation: 78219b4a64204d3499f445c8bca7db04
```

* Tenemos funcionando el servicio SSH en el equipo remoto, pero vamos a probar si hay acceso SSH desde fuera:
```
profesor$ ssh root@192.168.122.16
root@192.168.122.16's password: 
Permission denied, please try again.
root@192.168.122.16's password: 
```
* Vuelvo a la máquina webserver alumno1 y modificamos el fichero de confifuración de SSHD y habilitamos el acceso remoto con el usuario root:
```
# File: /etc/ssh/sshd_config
...
PermitRootLogin yes
...
```

> **DUDA**:
> * Pregunta: ¿por qué necesitamos acceso root a la máquina remota?
> * Respuesta: para poder tener los permisos necesarios para leer los ficheros de confifuración de Nginx. En nuestro caso: `/var/www/html/index.html`. Volveremos a este asunto de los permisos más adelante a ver si podemos realizar el test sin necesidad de tener acceso privilegiado root.
