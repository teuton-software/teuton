
# Instalación

A continuación se explica el proceso de instalación para
* La máquina del profesor y
* Las máquinas de los alumnos

> Dependiendo de la plataforma que tengamos el proceso de instalación puede variar.

## Máquina del profesor (Equipo principal)

Un equipo debe ser el host principal o del profesor.

Este equipo es el que inicia los test de comprobación hacia el resto de las máquinas.

* [Proceso general de instalación](./general/profesor.md).
* [Instalación en OpenSUSE 13.2](./opensuse/profesor.md).
* [Instalacion en Debian 8.6 Jessie](./debian/profesor.md)

## Máquinas de los alumnos (Equipos remotos)

Los equipos remotos serán cada uno de los equipos usados por los estudiantes
para realizar la actividad. A veces cada estudiante sólo necesitará una máquina,
pero en otros casos cada estudiante puede necesitar más de una.

* Sólo hay que instalar el acceso remoto SSH y/o Telnet.
    * [Acceso remoto](./general/alumno.md).
    * [Acceso remoto en OpenSUSE 13.2](./opensuse/alumno.md).
    * [Acceso remoto en Debian 8.6 Jessie](./debian/alumno.md)
* El usuario del equipo principal debe conocer usuario/clave de cada equipo
remoto con perfil de administrador.

---

# Máquina preinstalada

Máquinas Virtuales para  descargar, con el software preinstalado.
* Descargar [MV OpenSUSE 13.2](http://dvarrui.webfactional.com/sysadmingame/sysadmingame-opensuse-noviembre16.ova)
 (Fichero de comprobación [MD5](http://dvarrui.webfactional.com/sysadmingame/sysadmingame-opensuse-noviembre16.md5))

```
     Fecha 20161104 (versión 0.21.0)
     Fichero OVA de 1,8 GB
     MV VirtualBox con SO OpenSUSE 13.2 (64bits)
     Desktop XFCE 64 bits.
     Usuarios/clave: root/profesor, profesor/profesor
     Directorio /home/profesor/sysamdin-game
```
* Descargar [MV Debian 8.6](http://dvarrui.webfactional.com/sysadmingame/sysadmingame-debian-noviembre16.ova)
 (Fichero de comprobación [MD5](http://dvarrui.webfactional.com/sysadmingame/sysadmingame-debian-noviembre16.md5))

```
     Fecha 20161120 (versión 0.21.0)
     Fichero OVA de 1,4 GB
     MV VirtualBox con SO Debian 8.6 (64bits)
     Desktop XFCE 64 bits.
     Usuarios/clave: root/profesor, profesor/profesor
     Directorio /home/profesor/sysamdin-game
```
