#Instalación

Proceso de instalación y software requerido.

##Equipo principal
Un equipo debe ser el host principal o controlador.
* Software requerido en el host principal:
   * SSH cliente.
   * `rake --version` =>10.1.0
   * `ruby -v` => 1.9.3p194
* Proceso de instalación:
   * Descargar este proyecto.
   * `cd sysadmin-game`
   * Ejecutar `rake install_gems` para instalar las gemas necesarias en nuestro sistema.

##Equipos remotos
Varios equipos remotos que serán monitorizados por el principal.
* Software requerido en cada equipo remoto:
   * El software de acceso remoto SSH server.
   * El usuario del equipo principal debe conocer usuario/clave de cada equipo remoto.
