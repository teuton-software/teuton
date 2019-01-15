
# Instalación

A continuación se explica el proceso de instalación:
* Instalar Teuton  (En la máquina del profesor)
* Instalar Servidor SSH (En las máquinas de los alumnos)

---

# Máquina del profesor (Equipo principal)

> Dependiendo de la plataforma que tengamos el proceso de instalación puede variar.

Un equipo debe ser el host principal o del profesor.

Este equipo es el que inicia los test de comprobación hacia el resto de las máquinas.

* [Proceso general de instalación](./general/profesor.md).
* [Instalación en OpenSUSE 13.2](./opensuse/profesor.md).
* [Instalacion en Debian 8.6 Jessie](./debian/profesor.md)
* Instalación en Ubuntu 16.4: Seguimos los mismos pasos que la instalación para Debian.

---

# Máquinas de los alumnos (Equipos remotos)

> Dependiendo de la plataforma que tengamos el proceso de instalación puede variar.

Los equipos remotos serán cada uno de los equipos usados por los estudiantes
para realizar la actividad. A veces cada estudiante sólo necesitará una máquina, pero en otros casos cada estudiante puede necesitar más de una.

* Sólo hay que instalar el acceso remoto SSH y/o Telnet.
    * [Acceso remoto](./general/alumno.md).
    * [Acceso remoto en OpenSUSE 13.2](./opensuse/alumno.md).
    * [Acceso remoto en Debian 8.6 Jessie](./debian/alumno.md)
* El usuario del equipo principal debe conocer usuario/clave de cada equipo
remoto con perfil de administrador.
