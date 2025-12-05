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
- tt_members: VALUE
  nginx_ip: VALUE
  nginx_username: VALUE
  nginx_password: VALUE
```

_¡Guau! ¡Qué bueno!_ Después de leer el test, él es capaz de deducir los parámetros que hacen falta para cada alumno (case).

