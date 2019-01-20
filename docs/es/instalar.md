
# Instalación

Para usar *Teuton* hay distintos [modos](./modos.md).
Pero cada modo hay dos tipos de nodos o instalaciones. Estas son:

* **Instalación de Nodo-T o nodo teutón**: Es un host que tiene instalado el software Teutón.
* **Instalación de Nodo-S o nodo SSH**: Es un host que tiene instalado el servidor SSH.

---

# Instalación del NODO-T

## NODO-T: Instalación para OpenSUSE

Instalar y configurar OpenSUSE como nodo-T:
* Descargar [fichero](../../../bin/opensuse_t-node_install.sh).
    * `curl https://raw.githubusercontent.com/dvarrui/teuton/master/bin/opensuse_t-node_install.sh`
* Ejecutar `sudo opensuse_t-node_install.sh`

## NODO-T: Instalación para Debian

Instalar y configurar Debian como nodo-T:
* Descargar [fichero](../../../bin/debian_t-node_install.sh).
    * `curl https://raw.githubusercontent.com/dvarrui/teuton/master/bin/debian_t-node_install.sh`
* Ejecutar `sudo debian_t-node_install.sh`

## NODO-T: Instalación en Windows

* Instalar Git.
* Instalar Ruby.
* Descargar [fichero](../../../bin/windows_t-node_install.sh).
    * `curl https://raw.githubusercontent.com/dvarrui/teuton/master/bin/windows_t-node_install.sh`
* Ejecutar `windows_t-node_install.bat`

## NODO-T: Instalación manual

**Instalar git**

**Instalar ruby:**
* Se requiere porque el programa está desarrollado en ruby.
* ruby -v => 2.1.3p242. Comprobamos nuestra versión actual de ruby.

**Instalar rake**
* gem install rake, para instalar
* rake --version, comprobar la versión instalada (>= 10.4.2).

**Decargar el proyecto**
(a) git clone https://github.com/dvarrui/teuton.git
(b) Descargando el zip desde la página del repositorio GitHub.

**Instalar las gemas**
* cd teuton, entrar en la carpeta del proyecto.
* Ejecutar sudo rake gems para instalar las gemas necesarias en nuestro sistema.

**Descargar los retos de ejemplo**
* Ejecutar sudo rake get_challenges para descargar algunos retos de prueba.
* Ejecutar rake para comprobar que todo está correcto.

---

# Instalación del NODO-S

Esto es, cómo instalar el servidor SSH.

> El usuario del NODO-T debe conocer usuario/clave del NODO-S.

## NODO-S: Instalación para OpenSUSE

Instalar y configurar OpenSUSE como nodo-S:
* Descargar [fichero](../../../bin/opensuse_s-node_install.sh).
    * `curl https://raw.githubusercontent.com/dvarrui/teuton/master/bin/opensuse_s-node_install.sh`
* Ejecutar `sudo opensuse_s-node_install.sh`

## NODO-S: Instalación para Debian

Instalar y configurar Debian como nodo-S:
* Descargar [fichero](../../../bin/debian_s-node_install.sh).
    * `curl https://raw.githubusercontent.com/dvarrui/teuton/master/bin/debian_s-node_install.sh`
* Ejecutar `sudo debian_s-node_install.sh`

## NODO-S: Configuración en Windows

**Instalar SSH en Windows**

`EN CONSTRUCCIÓN!!!`

**Instalar cliente Telnet en Windows (No recomendado)**

* Ir a `Caracteristicas -> Servidor Telnet`.
* Asegurarse de que el servicio está iniciado. Ia a `Administrar el equipo -> Servicios -> Servidor Telnet`.
* En el caso de los SSOO Windows hay que crear un usuario, en cada
máquina de alumno, miembro de los grupos `Administradores` y `TelnetClients`.
