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
  webserver_ip: 192.168.122.254
  webserver_username: user
  webserver_password: secret
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

* El alumno 1 tiene una nota final de 0. Esto es porque todavía no ha realizado la práctica.

> **NOTA**: Como profesores, mientras estamos diseñando el test, es muy útil tener una MV que haga de la máquina del alumno para ir haciendo las pruebas durante el proceso.

Por motivos didácticos, vamos a añadir una segunda MV (del alumno2), para simular que tenemos un grupo de clase donde tenemos que a un alumno le sale la práctica mal y a otro bien.
* Entonces ampliamos el fichero de configuración con 2 cases:

```yaml
---
global:
cases:
# Máquina del alumno 1
- tt_members: Alumno 1
  webserver_ip: 192.168.122.254
  webserver_username: user
  webserver_password: secret
# Máquina del alumno 2
- tt_members: Alumno 2
  webserver_ip: 192.168.122.108
  webserver_username: user
  webserver_password: secret
```

> **NOTA**: 
> * Los valores de las IP son los de mis MV ahora pero pueden ser diferentes. 
> * Estoy usando el hipervisor KVM para crear las MV dentro de máquina real, pero se pueden usar otros como VirtualBox, Qemu, Parallel, Hyper-V, includo contenedores con SSH en ejecución.

* Este es el resultado esperado al ejecutar el test cuando nuestros alumnos todavía no han realizado la práctica:
```
$ teuton run nginx/v02 
------------------------------------
Started at 2025-12-06 16:25:10 +0000
FFFF
Finished in 0.601 seconds
------------------------------------
 
CASE RESULTS
+------+----------+-------+-------+
| CASE | MEMBERS  | GRADE | STATE |
| 01   | Alumno 1 | 0.0   | ?     |
| 02   | Alumno 2 | 0.0   | ?     |
+------+----------+-------+-------+
```

## 5. Optimizando el fichero de configuración

Ahora mismo, sólo tenemos dos alumnos (cases) registrados en el fichero de configuración, pero sabemos que este número va a aumentar bastante. También vemos que tenemos unos parámetros con valores repetidos en cada case: `webserver_username: user` y `webserver_password: secret`.

Para no repetirnos (DRY: Don't repeat Yourself) usamos también la sección `global` de la siguiente forma:

```yaml
---
global:
  webserver_username: user
  webserver_password: secret
cases:
# Máquina del alumno 1
- tt_members: Alumno 1
  webserver_ip: 192.168.122.254
# Máquina del alumno 2
- tt_members: Alumno 2
  webserver_ip: 192.168.122.108
```

## 6. Haciendo la práctica

Por motivos didácticos, me voy a convertir en el alumno2 y voy a ir haciendo la práctica sólo en su MV para que pueda obtener la máxima puntuación mientras que el alumno1 se queda en 0.

* Voy a la MV de alumno2.
* Lo primero que pide el enunciado es instalar el servidor web nginx. Como al alumno2 tiene una SO Debian, haremos como root `apt install nginx`.
* Ejecutamos los tests para ver el cambio:

```
$ teuton run nginx/v02 
------------------------------------
Started at 2025-12-06 16:41:11 +0000
F.FF
Finished in 0.581 seconds
------------------------------------
 
CASE RESULTS
+------+----------+-------+-------+
| CASE | MEMBERS  | GRADE | STATE |
| 01   | Alumno 1 | 0.0   | ?     |
| 02   | Alumno 2 | 38.0  | ?     |
+------+----------+-------+-------+
```

El alumno2 ha subido un poco la nota, pero tiene un valor extraño de un 38%, o lo que es lo mismo un 3,8. ¿De dónde sale ese valor?

## 7. Puntuaciones y pesos

El test ahora mismo tiene los siguientes objetivos (`targets`)

| Target | Descripción                                              | Peso |
| ------ | -------------------------------------------------------- | ---- |
| 01     | Comprobar el estado del servicio Nginx                   | 3    |
| 02     | Comprobar que index.html contiene el texto 'Hola Mundo!' | 5    |

Si se completa el 100% de los targets entonces se obtiene un total de 8 puntos (3+5), por lo tanto, si sólo se completan 3 de 8 tenemos un grado de cumplimiento del 38% (3,8) 
```
Fórmula aplicada      : (3/8) * 100 = 37,5
Redondeando nos queda : 38
```

Es muy posible que no nos covenzan los valores actuales de los pesos (`weight`), es normal, de hecho no los hemos puesto nosotros. Fue Gemini cuando le preguntamos el que nos hizo esa sugerencia.

* Cambiemos los pesos según nuestro criterio. Si no sabemos que poner, no pongas pesos y por defecto todos los targets tendrán el mismo peso (weight: 1). Como profesor, lo normal es darle más peso a los targets que consideramos más importantes.

```
...
  target "Comprobar el estado del servicio Nginx", weight: 4
...
  target "Comprobar que index.html contiene el texto 'Hola Mundo!'", weight: 6
...
```

```
$ teuton run nginx/v02
------------------------------------
Started at 2025-12-06 16:53:14 +0000
.FFF
Finished in 0.542 seconds
------------------------------------
 
CASE RESULTS
+------+----------+-------+-------+
| CASE | MEMBERS  | GRADE | STATE |
| 01   | Alumno 1 | 0.0   | ?     |
| 02   | Alumno 2 | 40.0  | ?     |
+------+----------+-------+-------+
```

## 8. Continuamos con la práctica

Seguimos haciendo la práctica en la MV del alumno2. 
* Ahora toca resolver el segundo target: "Comprobar que index.html contiene el texto 'Hola Mundo!'".
* Ejecutamos el test:
```
$ teuton run nginx/v02
------------------------------------
Started at 2025-12-06 16:59:08 +0000
.F.F
Finished in 0.642 seconds
------------------------------------
 
CASE RESULTS
+------+----------+-------+-------+
| CASE | MEMBERS  | GRADE | STATE |
| 01   | Alumno 1 | 0.0   | ?     |
| 02   | Alumno 2 | 100.0 | ✔     |
+------+----------+-------+-------+
```

_El test lo tenemos listo para llevar al aula con nuestros alumnos._

## 9. Vamos a personalizar el test

Cuando empezamos con estas prácticas, es bastante común, que el profesor prepare una MV base para los alumnos y que luego se clone esta MV base para cada uno. De modo que al empezar todos tengan exactamente lo mismo.

También podemos partir de una MV base similar pero donde cada alumno debe realizar una serie de personalizaciones para que las MV de cada uno se vayan diferenciando poco a poco y prevenir que un alumno presente una MV clonada de un compañero.

De modo que vamos a añadir un poco de personalización a las máquinas. Los alumnos, como parte de la práctica, tendrá que personalizar sus máquinas para que cada uno tenga usuario y passwords diferentes.

* Modificamos el fichero de configuración para que los usuarios/passwords de cada MV sean diferentes:

```yaml
---
global:
cases:
# Máquina del alumno 1
- tt_members: Alumno 1
  webserver_ip: 192.168.122.254
  webserver_username: alumno1
  webserver_password: secret1
# Máquina del alumno 2
- tt_members: Alumno 2
  webserver_ip: 192.168.122.108
  webserver_username: alumno2
  webserver_password: secret2
```

* Por motivos didácticos, vamos a quitar todos los pesos, o lo que es lo mismo que todos tengan valor 1.

* Modificamos el segundo target para que el mensaje que aparezca en la página web sea difernte para cada alumno/MV, mostrando algo como "Hola alumno1!"

```ruby
# File: custom.rb (Tests específicos de la personalización de la MV)

group "Comprobar la personalización de la MV" do
  target "Comprobar que existe el usuario del alumno"
  run "id alumno1", on: :webserver
  expect_ok
end
```

* Incluimos la refencia a este fichero en el script principal.
```ruby
# File: start.rb (Script principal)

use "nginx"
use "custom"

start do
  show
  export
end
```

> **NOTA**: Hemos introducido la instrucción `expect_ok` que devuelve true si el comando `id alumno1` se ejecuta correctamente. Si el usuario no existe, el comando falla y por tanto el resultado es false.

* Ejecutamos el test:
```❯ teuton run nginx/v03.custom
------------------------------------
Started at 2025-12-06 17:30:14 +0000
F.F..F
Finished in 0.697 seconds
------------------------------------
 
CASE RESULTS
+------+----------+-------+-------+
| CASE | MEMBERS  | GRADE | STATE |
| 01   | Alumno 1 | 33.0  | ?     |
| 02   | Alumno 2 | 67.0  |       |
+------+----------+-------+-------+
```

Aparece algo inesperado, el alumno1 mejora su puntuación pero al alumno2 la empeora. Analizar o depurar el proceso se puede complicar pero podemos consultar los informes que se generan:

```
$ tree var 
var
└── v03.custom
    ├── case-01.txt
    ├── case-02.txt
    ├── moodle.csv
    └── resume.txt
```

* El informe `var/v03.custom/case.01-txt` corresponde al alumno1 y vemos que de los 3 targets, sólo ha acertado al crear el usuario `alumno1`.
* Recordar que como hemos puesto todos los pesos a 1. Como el alumno1 consigió 1 de 3 entonces su nota en 33% (3,3).
* El informe `var/v03.custom/case-02.txt` corresponde al alumno2 y vemos que de los 3 targets, acierta todos menos el último correspndiente a crear el usuario `alumno1`. ¡Aquí está el problema! 
* Recordar que como hemos puesto todos los pesos a 1. Como el alumno2 consigió 2 de 3 entonces su nota es 67% (6,7).

La instrucción `run "id USERNAME", on: :webserver` debe rehacerse de tal manera que USERNAME sea "alumno1" para case 1 y "alumno2" para el case 2. Es necesario por tanto, leer los parámetros de configuración en la creación del comando a ejecutar. Para leer los parámetros de configuración usamos la instrucción `get`. En este caso sería: `get(:webserver_username)`.

Reconstruimos la instrucción `run` de la siguiente forma: 
```
   run "id " + get(:webserver_username), on: :webserver
```

* Ejecutamos el test:
```
$ teuton run nginx/v03.custom   
------------------------------------
Started at 2025-12-06 17:42:26 +0000
.F.F..
Finished in 0.590 seconds
------------------------------------
 
CASE RESULTS
+------+----------+-------+-------+
| CASE | MEMBERS  | GRADE | STATE |
| 01   | Alumno 1 | 33.0  | ?     |
| 02   | Alumno 2 | 100.0 | ✔     |
+------+----------+-------+-------+
```

> **NOTA**: Cuanta mayor personalización añadamos a nuestros tests, más complicado (pero no imposible) les será a los alumnnos "copiar" el trabajo de otros mediante el clonado de MV.

---
# EN CONSTRUCCTION!
---

debian-b: 192.168.122.108

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
