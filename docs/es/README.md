#SysadminGame

![logo](../logo.png)

#Introducción

Esta es una herramienta Open Source para usar en una clase con ordenadores.
*sysadmin-game* ayuda a los profesores a evaluar de forma remota y automática
el trabajo de clase realizado por los alumnos en sus máquinas.

También es útil para usar en concursos o competiciones de administración
de sistemas. Donde los concursantes compiten haciendo su trabajo en máquinas
reales y/o virtuales y al finalizar los jueces ejecutan *sysadmin-game*
para evaluarlas y puntuar a cada concursante.

Pasos:

1. **El profesor definie una actividad práctica** para el grupo de estudiantes. 
Esto es una lista de objetivos a cumplir, y la forma de cómo comprobar dichos objetivos.
1. **Cada estudiante realiza el trabajo de clase** en su propia máquina
Virtual y/o Real. 
1. **El profesor ejecuta la herramienta**. La herramienta automáticamente
evalúa los trabajos y crea informes para cada estudiante.

Estoy usando *sysadmin-game* con mis estudiantes. Está bien, pero se puede
mejorar (como todo en la vida). Me gustaría que otros usuarios (interesados
en la administración de sistemas y en la educacion) la conozcan, y recibir
comentarios, sugerencias o colaboraciones para mejorar la herramientas.

¡Muchas gracias!

#Demostración rápida

Cada actividad consiste de 2 ficheros. Echemos un vistazo al siguiente ejemplo:
* `./docs/examples/example-01.rb`: Este es el script que define la actividad.
* `./docs/examples/example-01.yaml`: Este fichero contiene las configuraciones para
cada máquina de cada estudiante (casos).

Para ejecutar la actividad de ejemplo hacemos `./project docs/example/example-01.rb`.

> **Resultados** 
> * Veremos un breve *informe en la pantalla*.
> * los *ficheros de salida* en su versión extendida se guardan en el directorio `./var/example-01/out/`.
> * Existen más actividades en el directorio `check`. Este es un buen sitio donde
guardar los scripts que vayamos creando para definir nuestras actividades.
> * Periódicamente irán apareciendo nuevas actividades dentro del directorio `check`.

#Documentación
* [Instalación](./instalacion.md)
* [Ejemplos](./ejemplos/README.md)
* [Creando la primera actividad](./primera-actividad.md)
* [Palabras clave del DSL](./palabras-clave-dsl.md)
