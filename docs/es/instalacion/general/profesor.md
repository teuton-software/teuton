
#Instalación general del equipo del profesor

## Software requerido en el host principal

Software SSH cliente
* Se usará para conectar con el resto de máquinas.
* También se puede usar el cliente Telnet si hace falta.

Instalar ruby
* `ruby -v` => 2.1.3p242. Comprobamos nuestra versión actual de ruby.
* Se requiere porque el programa está desarrollado en `ruby`.

Instalar rake
* `rake --version`, comprobar la versión instalada (>= 10.4.2).
* `sudo gem install rake`, para instalar

> Comprobar las versiones de `ruby`, `rake`:
> ![ruby-rake-gems](../../../images/ruby-rake-gems.png)
>

## Proceso de instalación SysadminGame

Tenemos dos formas de descargar el proyecto:
* (a) `git clone https://github.com/dvarrui/sysadmin-game.git`
* (b) Descargando el zip desde la página del [repositorio GitHub](https://github.com/dvarrui/sysadmin-game).

> Ejemplo de clonación usado comandos `git`:
> ![git-clone](../../../images/git-clone.png)
>

* `cd sysadmin-game`, entrar en la carpeta del proyecto.
* Ejecutar `sudo rake gems` para instalar las gemas necesarias en nuestro sistema.

> Error que se produce cuando tenemos una versión incorrecta de `ruby`:
> ![error-version](../../../images/error-version.png)