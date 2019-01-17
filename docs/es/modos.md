
# Instalación y Modos de uso

Hay distintas formas de usar *Teuton*, o modos de uso.
Pero cada modo hay dos tipos de nodos o instalaciones. Estas son:

* [Instalación de Nodo-T o nodo teutón](./instalar/nodo-t/): Es un host que tiene instalado el software Teutón.
* [Instalación de Nodo-S o nodo SSH](./instalar/nodo-s/): Es un host que tiene instalado el servidor SSH.

---

# Modo aula

En este modo usamos la herramienta *Teuton* para que un profesor pueda evaluar el trabajo realizado por sus alumnos en sus máquinas reales y/o virtuales. Además dichas máquinas pueden estar en remoto. Sólo se necesita poder acceder a ellas a través de la red.

En este caso tendremos:

| Nodo        | Descripción |
| ----------- | ----------- |
| Nodo Teuton | El equipo del profesor tendrá Teutón instalado. Y se conecta de forma remota a las MV de los alumnos |
| Nodo SSH    | Cada uno de los equipos de los alumnos |

---

# Modo concurso

En esta modalidad tendremos concursantes que deciden hacer una serie de retos y ejecutan Teutón en sus máquinas para verificar que van cumpliendo los retos.

En cada ejecución Teutón envía los resultados al equipo central de los jueces.

| Nodo        | Descripción |
| ----------- | ----------- |
| Nodo Teuton | Cada concursante instala Teutón en su PC y se conectará vía SSH al servidor de los jueces |
| Nodo SSH    | El servidor que usan los jueces para acumular todos los resultados |

---

# Modo reto solitario

Lo instalamos en nuestra máquina y vamos haciendo los retos que queramos a nuestro ritmo. Es una forma de aprender en solitario.

| Nodo        | Descripción |
| ----------- | ----------- |
| Nodo Teuton | Instalamos Teutón en nuestra máquina de retos |
| Nodo SSH    | No es necesario |
