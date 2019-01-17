
# Instalación en los equipos de los alumnos con Debian 8.6

* Se requiere el software de acceso remoto SSH server.
    * `Inicio -> Gestor de Paquetes -> SSH server`, para instalarlo por entorno gráfico.
    * `apt-get install openssh-server`, para instalarlo por comandos.
* El usuario del equipo principal(profesor) debe conocer usuario/clave de cada equipo
remoto con perfil de administrador.
* Modificar el fichero `/etc/ssh/sshd_config` con `PermitRootLogin yes`.
* Para reiniciar el servicio hacemos `systemctl restart sshd` o `service sshd restart`.
