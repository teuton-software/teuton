
# Proyecto: Servidor de retos

**Introducción**

Esta idea surgió a partir de varias conversaciones con _"Sergi"_.

Hablábamos mucho sobre _"ProgramaMe"_. Esto es un concurso donde los alumnos resuelven los retos de programación(Java, Python) en sus propias máquinas; y al terminar, el fichero con el programa, lo suben a la web central de _"ProgramaME"_. Aquí ProgramaMe se los corrige y puntúa.
A a los dos nos gusta mucho el proyecto de concurso de retos ProgramaMe... pero... queríamos incorporar otra línea de retos pero NO de programación. Esto es, retos de admnistradores de sistemas.

Si te interesa el tema, sigue leyendo que te proponemos una solución uniendo productos que ya existen y de licencia libre.

---

# Servidor

Para empezar necesitaremos un servidor o una máquina con IP pública.
La llamaremos (`castillo`). Esto normalmente se contrata.

En `castillo` instalaremos un servidor Web, donde pondremos descargar:
* `Aldeas`:
    * Una aldea es una máquinas virtual con el software `teuton` preinstalado.
    * Habrán aldeas Debian, OpenSUSE, Ubuntu, etc.
* `Retos`.
    * Habrá un conjunto de retos clasificados por dificultad.
    * Para cada reto tendremos: Un documento de texto y un fichero rb.
    * El documento de texto será una explicación/descripción del reto.
    * El fichero rb serán las instrucciones para verificar el reto.
* `Aventuras`
    * Las aventuras serán un conjunto organizado de retos.

---

# El profesor

* Tendrá el aula preparada con ordenadores para cada alumno y con el Virtual Box instalado.
* Elegirá una aventura donde inscribirá a sus alumnos y dará comienzo el juego.

---

# Los alumnos

1. Los alumnos empiezan descargando la `aldea` que necesitan.
2. Entran en la MV `aldea`.
3. Descargan también la `aventura` escogida (conjunto organizado de retos)
4. reto = 1
5. Resolvemos el reto
    * Leen la descripción/información del reto.
    * Realizan el reto dentro de la `aldea`.
    * Ejecutan `teuton` para el reto actual. Los resultados de envían automáticamente desde la `aldea` hasta el `castillo`
6. Los alumnos pueden consultar su puntuación y la clasificación desde la web del `castillo`. Si no les gusta el resultado pueden volver al punto 5 y repetirlo.
7. reto = reto + 1
8. Ir al paso 5. Así hasta que se acabe el tiempo o que se acaben los retos.
