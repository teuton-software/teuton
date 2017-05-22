
# Instalación del equipo principal o del profesor en OpenSUSE 13.2

## Software requerido en el host principal

* Software SSH cliente: Se usará para conectar con el resto de máquinas.

> También se puede usar el cliente Telnet.

* `ruby -v` => 2.1.3p242. El programa está desarrollado en `ruby`.
* `rake --version` =>10.4.2. `rake` es como el `make` de `ruby`.

## Proceso de instalación en el host principal

> No hay que instalar ruby, ni rake porque vienen por defecto.

* `sudo zypper in git`, para instalar git.
* `git clone https://github.com/dvarrui/sysadmin-game.git`, para descargar este proyecto.

> Ejemplo de clonación usado comandos `git`:
> ![git-clone](../../../images/git-clone.png)

* `cd sysadmin-game`, entrar dentro de la carpeta del proyecto.
* `sudo zypper install ruby`, para instalar ruby.
    * `ruby -v`, para comprobar que la versión instalada >= 2.1.3.
* `sudo gem install rake`para instalar rake.
    * `rake --version` para comprobar que la versión instalada =>10.4.2.
* `sudo rake opensuse`, para instalar las gemas necesarias en nuestro sistema.
* `./project -v`, para comprobar se ejecuta el proyecto.
* `rake check`, para comprobar que está todo bien instalado.

¡Ya lo tenemos!
