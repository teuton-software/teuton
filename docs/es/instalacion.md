#Instalación

Proceso de instalación y software requerido.

##Equipo principal o del profesor
Un equipo debe ser el host principal o controlador.
* Software requerido en el host principal:
   * SSH cliente: Se usará para conectar con el resto de máquinas.
   * `rake --version` =>10.4.2
   * `ruby -v` => 2.1.3p242
* Proceso de instalación:
   * Descargar este proyecto.
   * `cd sysadmin-game`
   * Ejecutar `rake install_gems` para instalar las gemas necesarias en nuestro sistema.

##Equipos remotos
Los equipos remotos serán cada uno de los equipos usados por los estudientes para realizar
la actividad. A veces cada estudiante sólo necesitará una máquina, pero en otros casos
cada estudiante puede necesitar más de una.

* Software requerido en cada equipo remoto:
   * El software de acceso remoto SSH server.
   * El usuario del equipo principal debe conocer usuario/clave de cada equipo remoto.
