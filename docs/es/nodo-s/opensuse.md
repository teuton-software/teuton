
# Instalación del NODO-S en OpenSUSE

Instalar y configurar OpenSUSE como nodo-S:
* Descargar [fichero](../../../bin/opensuse_s-node_install.sh).
* Ejecutar `sudo opensuse_s-node_install.sh`

---

# Explicación

## Servicio SSH

* Instalar el software de acceso remoto SSH server.
    * `Yast -> Instalación de Software -> OpenSSH` por el modo gráfico.
    * `zypper install openssh` por comandos.
* El usuario del NODO-T debe conocer un usuario/clave para poder entrar de forma remota a esta máquina.
* Modificar el fichero `/etc/ssh/sshd_config` con `PermitRootLogin yes`.
* Para reiniciar el servicio hacemos `systemctl restart sshd`.
