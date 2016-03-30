

#example-02

```
* En este ejemplo, vamos a hacer uso del fichero de configuración.
* Cada script (.rb) va acompañado de un fichero de configuración (.yaml).
* El contenido del fichero de configuración tiene formato YAML.
* Para leer el contenido del fichero de configuración desde el script, usaremos la instruccion get del DSL.
```

* Script: [example-02.rb](../../../examples/example-02.rb) 
* Fichero de configuración: [example-02.yaml](../../../examples/example-02.yaml)
* Descripción: *Personalizar cada caso usando el fichero de configuración.*
* Requisitos: En este ejemplo se ejecutan comandos de GNU/Linux en *localhost*.

##Script

En el ejemplo anterior (`example-01`) vimos que tenía el objetivo de
comprobar la existencia de un usuario concreto. Si queremos comprobar 
un nombre de usuario diferente, tendríamos que modificar el script de 
evaluación... Pero ¿y si sacamos los parámetros que pueden cambiar 
de la prueba, a un fichero de configuración externo? ¿Mejor? ¿verdad?

En este ejemplo vamos a poner los nombres de usuarios a comprobar (objetivos)
en el fichero de configuración, y para leer dichos valores desde el script usaremos
la instrucción *get*.

##Fichero de configuración

Vemos que en el script hay una nueva instrucción:
* **get** lee el valor del parámetro indicado, del contenido del fichero 
de configuración. Para cada caso podrá ser diferente. Las acciones de 
comprobación toman el valor configurado para cada caso del fichero 
de configuración, y de esta forma cada caso se evalúa con diferentes valores.
* *get* intenta primero leer el valor solicitado en la configuración del caso,
y si no lo encuentra lo intenta leer de la configuración global. De esta forma
podemos tenemos parámetros específicos para cada caso, o comunes para todos
ellos.

En este ejemplo no tenemos definidas variables globales de configuración.
Para cada caso se definen los parámetros `tt_members` y `username`.
* **username**: Este parámetro tiene diferente valor para cada caso, de modo
que cuando se ejecuta la accción de comprobación, ésta será diferente en cada
caso.
* Consulta el fichero de configuración de este ejemplo.

> Podemos tener tantos parámetros como queramos. Eso sí, todos los casos deben
tener los mismos parámetros, pero pueden tener valores diferentes.

##Ejecución del script

Ejecutamos el script con `./project docs/examples/example-02.rb` y vemos la 
siguiente [salida por pantalla](./resume.txt).

Aquí lo más importante es ver en TARGETS HISTORY el resumen de todos los casos analizados
con su evaluación final. En este ejemplo, tenemos 2 casos:
* case_01 con puntuación del 100% y 
* case_02 con puntuación de 0%.

##Informes de salida

Para tener más información sobre cada caso, y averiguar lo que ha pasado
con cada uno para obtener las puntuaciones finales, debemos consultar 
los informes. Los informes se graban en `var/example-02/out`.

```
var/example-02/out/
├── case-01.txt
├── case-02.txt
└── resume.txt
```

###Informe de salida para `case-01`

Veamos el informe del caso 01, consultando el fichero `var/example-02/out/case-01.txt`.
[Consultar fichero](./case-01.txt).

###Informe de salida para `case-02`
Ahora vemos el informe del caso 02, consultando el fichero `var/example-02/out/case-02.txt`.
[Consultar fichero](./case-02.txt).

##Recordatorio

Dentro del fichero de configuración, podemos crear todas los parámetros/valor 
que necesitamos para nuestro script/actividad.

Si las definimos en la zona `global` serán accesibles para todos los casos, y
si las definimos dentro de cada caso, sólo serán accesibles para dicho
caso particular.

Tener en cuenta que podemos usar los nombres que queramos para nuestras variables
de configuración, pero evitar que comiencen por `tt_`. Este prefijo está reservado
para variables de configuración específicas de la aplicación *SyadminGame*.

Algunos ejemplos son:
* `tt_members`: Que guarda una lista con los nombres de los miembros del grupo de trabajo.
* `tt_skip`: Toma los valores true/false. Y define si debemos procesar/evaluar este caso o no.
Por defecto, toma el valor `True`, y no es necesario especificarlo.
