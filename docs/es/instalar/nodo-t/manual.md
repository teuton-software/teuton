
# Instalación del NODO-T

A continuación se explica el proceso de instalación manual.

## Software requerido en el host principal

Software SSH cliente
* Se usará para conectar con el resto de máquinas.
* También se puede usar el cliente Telnet si hace falta.

Instalar ruby
* Se requiere porque el programa está desarrollado en `ruby`.
* `ruby -v` => 2.1.3p242. Comprobamos nuestra versión actual de ruby.

Instalar rake
* `sudo gem install rake`, para instalar
* `rake --version`, comprobar la versión instalada (>= 10.4.2).

---

## Proceso de instalación

Tenemos dos formas de descargar el proyecto:
* (a) `git clone https://github.com/dvarrui/teuton.git`
* (b) Descargando el zip desde la página del [repositorio GitHub](https://github.com/dvarrui/teuton).

Instalar las gemas:
* `cd teuton`, entrar en la carpeta del proyecto.
* Ejecutar `sudo rake gems` para instalar las gemas necesarias en nuestro sistema.
* Ejecutar `sudo rake get_challenges` para descargar algunos retos de prueba.
* Ejecutar `rake` para comprobar que todo está correcto.
