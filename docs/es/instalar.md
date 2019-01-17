
# Instalación

Para usar *Teuton* hay distintos [modos](./modos.md).
Pero cada modo hay dos tipos de nodos o instalaciones. Estas son:

* **Instalación de Nodo-T o nodo teutón**: Es un host que tiene instalado el software Teutón.
* **Instalación de Nodo-S o nodo SSH**: Es un host que tiene instalado el servidor SSH.

---

# Instalación del NODO-T

Podemos hacer la instalación de varias formas:
* Instalar [NODO-T usando Vagrant](./nodo-t/vagrant.md)
* Instalar [NODO-T de forma manual](./nodo-t/manual.md)
* Instalar [NODO-T en OpenSUSE](./nodo-t/opensuse.md)
* Instalar [NODO-T en Debian](./nodo-t/debian.md)

---

# Instalación del NODO-S

* Instalar el software de acceso remoto SSH server en la máquina.

> El usuario del NODO-T debe conocer usuario/clave de cada equipo
remoto con perfil de administrador.

Puede consultar también:
* Configuración [NODO-S en OpenSUSE](./nodo-s/opensuse.md)
* Configuración [NODO-S en Debian](./nodo-s/debian.md)
* Configuración [NODO-S en Windows](./nodo-s/opensuse.md)

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
