
# Instalación del NODO-T en OpenSUSE 13.2

Para instalar y configurar OpenSUSE como nodo-T podemos usar el siguiente script del directorio `bin`:

`opensuse_t-node_install.sh`

---

# Explicación

## Software requerido

* Software SSH cliente: Se usará para conectar con el resto de máquinas (También se podría usar el cliente Telnet).

* `ruby -v` => 2.1.3p242. El programa está desarrollado en `ruby`.
* `rake --version` =>10.4.2. `rake` es como el `make` de `ruby`.

## Proceso de instalación

> No hay que instalar ruby, ni rake porque vienen por defecto.

* `sudo zypper in git`, para instalar git.
* `git clone https://github.com/dvarrui/teuton.git`, para descargar este proyecto.

> Ejemplo de clonación usado comandos `git`:
> ![git-clone](../../../images/git-clone.png)

* `cd teuton`, entrar dentro de la carpeta del proyecto.
* Ruby ya debe estar instalado por defecto.
    * `ruby -v`, para comprobar que la versión instalada >= 2.1.3.
* `sudo gem install rake`para instalar rake.
    * `rake --version` para comprobar que la versión instalada =>10.4.2.
* `sudo rake opensuse`, para instalar las gemas necesarias en nuestro sistema.
* `./teuton version`, para comprobar se ejecuta el proyecto.
* `rake`, para comprobar que está todo bien instalado.

¡Ya lo tenemos!
