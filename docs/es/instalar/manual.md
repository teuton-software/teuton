
# Instalación manual

Para usar *Teuton* hay distintos [modos](./modos.md).
Pero cada modo hay dos tipos de nodos o instalaciones. Estas son:

* **Instalación de Nodo-T o nodo teutón**: Es un host que tiene instalado el software Teutón.
* **Instalación de Nodo-S o nodo SSH**: Es un host que tiene instalado el servidor SSH.

---

# NODO-T: Instalación manual

| Id | Paso             | Descripción |
| -- | ---------------- | ----------- |
| 1  | Instalar git     |  |
| 2  | Instalar ruby    | Se requiere porque el programa está desarrollado en ruby. Ejecutar `ruby -v` (2.1.3p242) para comprobar la versión actual de ruby. |
| 3  | Instalar rake | Usar comando `gem install rake`. Luego para comprobar la versión hacer `rake --version` (>= 10.4.2) |
| 4  | Descargar el proyecto | (a) `git clone https://github.com/dvarrui/teuton.git` (b) Descargando el zip desde la página del repositorio GitHub |
| 5  | Instalar las gemas | `cd teuton`, entrar en la carpeta del proyecto, y ejecutar `rake gems` para instalar las bibliotecas (gemas) necesarias en nuestro sistema |
| 6  | Descargar los retos de ejemplo | `rake get_challenges` |
| 7  | Comprobación final | `rake` |

> **Recuerda**
>
> Para ejecutar un test de TEUTON (Por ejemplo el test challenges/demo) hacemos lo siguiente:
> * `cd teuton`
> * `ruby teuton challenges/demo`
>
> Los informes se guardan en `var/demo/out`.

---

# NODO-S: Instalación manual

* Instalar el servidor SSH.
