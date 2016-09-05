#Instalación

Proceso de instalación y software requerido.

##Equipo principal o del profesor

Un equipo debe ser el host principal o controlador.
Será el que use el profesor y/o juez de la competición.

* Software requerido en el host principal:
   * Software SSH cliente: Se usará para conectar con el resto de máquinas.
   * `ruby -v` => 2.1.3p242
   * `rake --version` =>10.4.2
* Proceso de instalación:
   * Instalar ruby (`apt-get install ruby` en Debian, `zypper in ruby` en OpenSUSE, etc)
   * Instalar rake (`gem install rake`)
   * Descargar este proyecto.
   * `cd sysadmin-game`
   * Ejecutar `rake install_gems` para instalar las gemas necesarias en nuestro sistema.

> Ejemplo de clonación usado comandos `git`:
> ![git-clone](../images/git-clone.png)
>
> Comprobar las versiones de `ruby`, `rake` antes de instalar las gemas (Librerías):
> ![ruby-rake-gems](../images/ruby-rake-gems.png)
>
> Error que se produce cuando tenemos una versión incorrecta de `ruby`:
> ![error-version](../images/error-version.png)

##Equipos remotos

Los equipos remotos serán cada uno de los equipos usados por los estudientes para realizar
la actividad. A veces cada estudiante sólo necesitará una máquina, pero en otros casos
cada estudiante puede necesitar más de una.

* Software requerido en cada equipo remoto:
   * El software de acceso remoto SSH server.
   * El usuario del equipo principal debe conocer usuario/clave de cada equipo remoto
     con perfil de administrador.
