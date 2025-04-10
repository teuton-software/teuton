
# TEUTON (ES)

[![Gem Version](https://badge.fury.io/rb/teuton.svg)](https://badge.fury.io/rb/teuton)
![GitHub](https://img.shields.io/github/license/dvarrui/teuton)

_Crear test unitarios para tus máquinas y prueba tu infraestructura como si fuera código._

![logo](./docs/images/logo.png)

El test de infraestructura es útil para:
* Profesores de administración de sistemas que quieren evaluar a las máquinas remotas de los alumnos.
* Alumnos que quieren evaluar su proceso de aprendizaje.
* Profesionales que desean monitorizar sus máquinas remotas.

# Instalación

Primero es necesario tener instalado `Ruby`y a continuación instalamos Teuton con el siguiente comando:

```console
gem install teuton
```

> Para instalar Teuton sin privilegios de root: `gem install --user-install teuton`

# Modo de uso

Usaremos el comando `teuton` para ejecutar los tests:

```console
> teuton run examples/01-target

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | anonymous | 100.0 | ✔     |
+------+-----------+-------+-------+
```

> Más información sobre los [comandos](docs/commands/README.md)

# Características

* DSL sencillo para definir los tests: `target`, `run`,`expect`, etc.
* Se usa conexiones SSH o Telnet para acceder a los dispositivos remotos.
* Formatos de salida: `txt`, `html`, `json`, `yaml`, etc.
* Multiplatforma.
* [Licencia de Software Libre](LICENSE).

# Documentación

* [Instalación](docs/install/README.md)
* [Aprender](docs/learn/README.md)
* [Ejemplos](examples)
* [Comandos](docs/commands/README.md)
* [DSL](docs/dsl/README.md)
* [Blogs y videos](docs/videos.md)

# Contacto

* **Email**: `teuton.software@protonmail.com`

# Contribuciones

1. Asegúrate de tener `Ruby`instalado.
1. Haz un "fork" del proyecto.
1. Crear tu rama "feature" (`git checkout -b my-new-feature`)
1. Haz "commit" de tus cambios (`git commit -am 'Add some feature'`)
1. Haz "push" a la rama (`git push origin my-new-feature`)
1. Crear un "pull request" nuevo.

También se pueden [crear issues](https://github.com/teuton-software/teuton/issues) con peticiones, incidencias o sugerencias.
