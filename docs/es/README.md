# TEUTON Software

_(Antes se llamaba SysadminGame)_

```
TEUTON son unidades de pruebas para máquinas.
TEUTON comprueba toneladas de objetivos en toneladas de máquinas.
```

Es un DSL para escribir `Unidades de Prueba para todo`. Por ejemplo,
sirve para comprobar si un grupo de máquinas satisface una lista de objetivos o requisitos.

![logo](../logo.png)

---

# Descripción

Los pasos para trabajar en el modo aula son:

1. **El EVALUADOR define un test o actividad práctica** para un grupo de máquinas. Esto es una lista de objetivos a cumplir, y cómo comprobar dichos objetivos.
1. **Cada CONCURSANTE realiza el trabajo para cumplir los objetivos del test** en su propia máquina Virtual y/o Real.
1. **El EVALUADOR ejecuta la herramienta**. La herramienta automáticamente
evalúa los trabajos y crea informe individuales por máquina y resumen global.

> **NOTA**
> * Las máquinas evaluadas deben estar accesibles de forma remota por la máquina del evaluador.
> * Actualmente se pueden usar los protocolos de acceso remoto
SSH y Telnet.
> * Además el evaluador debe tener usuario/clave para entrar en las máquinas remotas.

---

# Demostración rápida

Cada test/reto/actividad consiste de 2 ficheros. Echemos un vistazo al siguiente ejemplo:

| Fichero | Descripción |
| ------- | ----------- |
| [./docs/examples/example-01.rb](../examples/example-01.rb) | Script que define el test/reto|
| [./docs/examples/example-01.yaml](../examples/example-01.yaml) | Fichero que contiene las configuraciones para cada máquina evaluada (casos) |

Para ejecutar el test/reto de ejemplo con [Teuton](./comando.md) haremos:

`./teuton play docs/example/example-01.rb`

> **Resultados**
> * Veremos un breve *informe en la pantalla*.
> * los *ficheros de salida* en su versión extendida se guardan en el directorio `./var/example-01/out/`.
> * Existen más actividades en el repositorio de GitHub `dvarrui/teuton-challenges`. Este es un buen sitio donde guardar los scripts que vayamos creando para definir nuestras actividades. Periódicamente irán apareciendo nuevos retos.

---

# Documentación

* [Ejemplos](./ejemplos/README.md)
* [Creando la primera actividad](./primera-actividad.md)
* [Palabras clave del DSL](./dsl/README.md)

