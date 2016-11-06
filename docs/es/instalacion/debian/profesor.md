
```
Autor: Manuel Martínez Carbonell
```

#Instalación en el equipo del profesor con Debian 8.6

A continuación se indica el proceso de instalación y cuáles son los paquetes
de software requeridos.

Antes de proceder con la instalación se recomienda leer el apartado final *"Posibles inconvenientes"*.

#1. Software requerido

* Software SSH cliente: Se usará para conectar con el resto de máquinas.
> También se puede usar el cliente Telnet.

* `ruby -v` => 2.1.3p242. El programa está desarrollado en ruby.
* `rake --version` =>10.4.2. rake es como el make de ruby.
* Descargar el proyecto Sysadmin-game.

#2. Instalación

* `sudo apt-get install ruby`, para instalar ruby.
* `sudo gem install rake`para instalar rake.
* `sudo apt-get install git`, para instalar git.
* `git clone https://github.com/dvarrui/sysadmin-game.git`, para descargar este proyecto.

> Ejemplo de clonación usado comandos `git`:
> ![git-clone](../../../images/git-clone.png)

* `cd sysadmin-game`, entrar dentro de la carpeta del proyecto.
* `sudo rake debian`, para instalar las gemas necesarias en nuestro sistema.

> Error que se produce cuando tenemos una versión incorrecta de `ruby`:
> ![error-version](../../../images/error-version.png)

* `./project -v`, para comprobar que está todo bien.

¡Ya lo tenemos!


#3. Otras formas de hacer las instalaciones

##3.1 Instalar Ruby desde el código fuente

A la hora de instalar Ruby tenemos varias opciones:
* Usar el sistema de gestión de paquetes de la propia distribución.
* Usar instaladores, manejadores para poder cambiar entre distintas versiones de Ruby en el sistema y,
* Compilar el código fuente.

> Enlace para obtener [más información sobre la instalación](https://www.ruby-lang.org/en/documentation/installation/)

En esta sección se muestra cómo hacerlo compilando el código fuente.

> * El proyecto está testado para ruby 2.1.3, por lo debe funcionar para versiones superiores
> * Recomendaría instalar desde el código fuente cuando la versión de ruby fuera
menor a 2.1.3. En caso contrario con `apt-get install ruby` tenemos.

* Primero nos aseguramos de tener instaladas las siguientes librerías antes de continuar:
```
# apt-get install zlib1g-dev
# apt-get install libssl-dev
```
* Luego descargamos la versión necesaria de Ruby, se descomprime el archivo.
    * [Descargar ruby 2.1.3](https://www.ruby-lang.org/en/news/2014/09/19/ruby-2-1-3-is-released/)
    * Ruby ya va por una versión posterior a la 2.1.3.
* Dentro del directorio se ejecuta:
```
$ ./configure
$ make
# make install
```
![configure.png](./images/configure.png)

> * Este es el proceso estándar para compilar código fuente.
> * Enlace sobre [más información sobre la instalación de Ruby](https://www.ruby-lang.org/es/documentation/installation/#building-from-source)

* Comprobamos la versión de Ruby con `# ruby -v`

![ruby-v.png](./images/ruby-v.png)

##3.2 Instalación de rake

* Puedes descargar la [versión 10.4.2 de rake](https://rubygems.org/gems/rake/versions/10.4.2?locale=es).
* En el directorio donde hayas descargado rake se debe ejecutar: `# gem install rake -v 10.4.2`

![gem-install-rake.png](./images/gem-install-rake.png)

> Creo que el comando `gem install rake -v 10.4.2` instala descargando la gema
directamente desde los repositorios de internet, y no usa lo ficheros descargados.

* Comprobar la versión de rake con: `$ rake --version`

![rake-version.png](./images/rake-version.png)

##3.3 Descargar el proyecto Sysadmin-game

* Descargar y descomprimir el proyecto.
* Entrar el directorio `sysadmin-game-master`.
* Ejecutar `rake install_gems` para que se instalen el resto de las gemas necesarias en nuestro sistema.

![descargar-proyecto.png](./images/descargar-proyecto.png)

> Error que se produce cuando tenemos una versión incorrecta de ruby:
>
> ![rake-install-gems-error.png](./images/rake-install-gems-error.png)
>
> Las gemas (librerías de ruby) que se usan, necesitan una versión de ruby
superior a 2.0
> `net-ssh` es la gema que permite la conexión SSH entre las máquinas.

##3.4 Posibles inconvenientes

Tras la instalación de Ruby, al intentar instalar rake puede que se produzca el siguiente error:

![gem-install-rake-error.png](./images/gem-install-rake-error.png)

Para solucionar el error anterior se deben instalar los siguientes paquetes:
```
# apt-get install zlib1g-dev
# apt-get install libssl-dev
```

En caso de que no se instale la librería `libssl-dev`, se obtendría el siguiente
error al intentar instalar `rake`:

![gem-install-rake-error2.png](./images/gem-install-rake-error2.png)

Cuando se hayan instalado los dos paquetes anteriores hay que recompilar Ruby
(previamente se debe ejecutar un `make clean`):
```
$ make clean
$ ./configure  > Este paso no es necesario
$ make
# make install
```
Ahora si que se podrá instalar rake sin problemas: `# gem install rake -v 10.4.2`

![gem-install-rake-ok.png](./images/gem-install-rake-ok.png)
