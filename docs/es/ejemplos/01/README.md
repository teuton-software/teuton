

#example-01

```
* En este ejemplo, veremos como definir un objetivo evaluable.
* Los objetivos son cada uno de los aspectos que medimos en los trabajos realizados.
* Cada trabajo será realizado por un alumno o varios, nosotros los llamaremos casos.
* Cada caso tiene un parámetro con la lista de sus miembros.
```

* Script: [example-01.rb](../../../examples/example-01.rb) 
* Fichero de configuración: [example-01.yaml](../../../examples/example-01.yaml)
* Descripción: *Comprueba si existe el usuario *obiwan* en la máquina *localhost*.*
* Requisitos: En este ejemplo se ejecutan comandos de GNU/Linux en *localhost*.
* SO localhost: GNU/Linux

##Script

Vemos que en el script hay las siguientes intrucciones:
* **target**: Texto que describe el objetivo que buscamos.
* **goto**: Moverse a la máquina *localhost*, y ejecutar el comando. Hay que hacer notar
que en este caso el comando se ejecutará en *localhost*, y puesto que el comando del
script es `id obiwan | wc -l`, el sistema operativo de *localhost* debe ser un GNU/Linux,
o en su defecto otro sistema operativo que entienda el comando a ejecutar.
* **expect**: Evalua si el resultado es igual al valor esperado.

##El fichero de configuración

El fichero de configuración no establece ninguna variable global, y 
sólo contiene un caso. Este caso tiene los siguientes parámetros:

* **tt_members**: Estos son los nombres de los miembros del grupo separados por comas.

##Ejecución del script

Para ejecutar el script hacemos `./project docs/examples/example-01.rb`, y 
veremos la siguiente [salida por pantalla](./resume.txt):

En la sección *TARGETS HISTORY* vemos el resumen de todos los casos analizados
con su evaluación final. En este ejemplo, sólo tenemos un caso (case_01) que 
tiene como resultado final un 0%. Esto quiere decir que no se ha completado ninguno 
de los objetivos previstos para dicho caso.

> Cuando el valor final de la evaluación de cada caso es menor a 50% se aparecerá
el símbolo '?'.

##Informe de salida

Para tener información más detalla y averiguar lo que ha pasado en cada caso, debemos
consultar el informe del mismo. Los informes se graban en `var/example-01/out`.
```
var/example-01/out/
├── case-01.txt
└── resume.txt
```

Puesto que nuestro caso es el 01, consultaremo el fichero `var/example-01/out/case-01.txt`.
[Ver ejemplo](./case-01.txt).

Como vemos en *TARGETS HISTORY* (que es donde se registran las acciones sobre los objetivos),
hay una acción puntuada con 0 puntos, en la que se esperaba como resultado un 1 y
se obtuvo un 0. El comando ejecutado fue `id obiwan|wc -l`. Por tanto, deducimos
que no se cumplió el objetivo de tener creado dicho usuario en el sistema.

En la zona *FINAL VALUES* del informe podemos ver los siguientes datos:
* El número de identificación del caso. Por si fueran más de uno facilitar su identificación.
En nuestro caso es `1`.
* Fecha/hora de inicio y finalización de la prueba de evaluación. Estos valores establecen
el periodo de tiempo en el que se realiza la prueba, y por tanto el periodo de tiempo en el
que se realiza la medición del cumplimiento de los objetivos. Es posible que el alumno
modifique el estado de la máquina fuera de dicho intervalo temporal, en cuyo caso, dichas
no modificaciones no serán tenidas en cuenta.
* Duración de la prueba de evaluación para ese caso concreto.
* `unique_fault`: En esta prueba no se usa. Lo veremos más adelante.
* Cada objetivo tiene un peso en la fórmulara de evaluación. Realmente para calcular
la nota final se usa una media ponderada de todos los objetivos. Por defecto 
todos tienen pero 1, a menos que indiquemos otro valor diferente (ya veremos un ejemplo).
* `fail_counter`: Es la cantidad de objetivos fallados.
* `grade`: Es la puntuación final en %. En este caso 0 %.

##Recordatorio

Podemos crear tantos objetivos evaluables como queramos, usando las instrucciones
`desc`, `goto` y `expect`. Cuantas más pongamos, más exhaustiva será nuestra 
evaluación.

Los objetivos deben ir siempre dentro de un bloque de tarea: `task "Task name" do ... end`.

Si tenemos muchos objetivos podemos agruparlos en varias tareas `task`.
Podemos tener tantas tareas y objetivos como necesitemos.

