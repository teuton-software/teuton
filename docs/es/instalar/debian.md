
# Instalación en Debian

Para usar *Teuton* hay distintos [modos](./modos.md).
Pero cada modo hay dos tipos de nodos o instalaciones. Estas son:

* **Instalación de Nodo-T o nodo teutón**: Es un host que tiene instalado el software Teutón.
* **Instalación de Nodo-S o nodo SSH**: Es un host que tiene instalado el servidor SSH.

---

# NODO-T: Instalación para Debian

* `curl https://raw.githubusercontent.com/dvarrui/teuton/master/bin/debian_t-node_install.sh | sh`, para descargar y ejecutar el instalador.

> **Recuerda**
>
> Para ejecutar un test de TEUTON (Por ejemplo el test challenges/demo) hacemos lo siguiente:
> * `cd teuton`
> * `./teuton challenges/demo`
>
> Los informes se guardan en `var/demo/out`.

---

# NODO-S: Instalación para Debian

Descargar [fichero](../../bin/debian_s-node_install.sh) y ejecutarlo:

`curl https://raw.githubusercontent.com/dvarrui/teuton/master/bin/debian_s-node_install.sh | sh`
