

[Ejemplo anterior](./example-01.md) | [Listado de Ejemplos](./ejemplos.md) | [Ejemplo siguiente](./example-03.md)

#example-02

```
    En este ejemplo, vamos a hacer uso del fichero de configuración.
    Cada script (demo.rb) va acompañado de un fichero de configuración (demo.yaml).
    El contenido del fichero de configuración tiene formato YAML.
    Para leer el contenido del fichero de configuración desde el script, usaremos la instruccion get del DSL.
```

* Script: [example-02.rb](../examples/example-02.rb) 
* Fichero de configuración: [example-02.yaml](../examples/example-02.yaml)
* Descripción: *Personalizar cada caso usando el fichero de configuración.*
* Requisitos: El sistema operativo de la máquina *localhost* debe ser GNU/Linux.

##Script

En el ejemplo anterior (`example-01`) vimos que tenía el objetivo de
comprobar la existencia de un usuario concreto. Si queremos comprobar 
un nombre de usuario diferente, tendríamos que modificar el script de 
evaluación... Pero ¿y si sacamos los parámetros que pueden cambiar 
de la prueba, a un fichero de configuración externo? ¿Mejor? ¿verdad?

En este ejemplo vamos a poner los nombres de usuarios a comprobar (objetivos)
en el fichero de configuración, y para leer dichos valores desde el script usaremos
la instrucción *get* del DSL (Consultar [example-02.rb](../examples/example-02.rb)).

##Fichero de configuración

Vemos que en el script hay una nueva intrucción:
* **get**: Lee el valor del parámetro indicado, del contenido del fichero 
de configuración. Para cada caso podrá ser diferente. Las acciones de 
comprobación toman el valor configurado para cada caso del fichero 
de configuración, y de esta forma cada caso se evalúa con diferentes valores.
* *get* intenta primero leer el valor solicitado en la configuración del caso,
y si no lo encuentra lo intenta leer de la configuración global. De esta forma
podemos tenemos parámetros específicos para cada caso, o comunes para todos
ellos.

En este ejemplo no tenemos definidas variables globales de configuración.
Para cada caso se definen los parámetros siguientes: `tt_members`, `tt_emails` 
y `username`.
* **username**: Este parámetro tiene diferente valor para cada caso, de modo
que cuando se ejecuta la accción de comprobación, ésta será diferente en cada
caso.
* Consulta el fichero de configuración de este ejemplo.

##Ejecución del script
Ejecutamos el script con `./docs/examples/example-02.rb` y vemos la siguiente salida por pantalla:

```
=============================================
Executing [sysadmin-game] tests (version 0.5)
[INFO] Running in parallel (2016-02-14 13:05:02 +0000)
.?
[INFO] Duration = 0.013452716 (2016-02-14 13:05:02 +0000)

=============================================
INITIAL CONFIGURATIONS
  tt_title: Executing [sysadmin-game] tests (version 0.5)
  tt_scriptname: ./docs/examples/example-02.rb
  tt_configfile: ./docs/examples/example-02.yaml
  tt_testname: example-02
  tt_sequence: false
TARGETS HISTORY
  -  Case_01 => 100   Student-name-1
  -  Case_02 =>   0 ? Student-name-2
FINAL VALUES
  start_time: 2016-02-14 13:05:02 +0000
  finish_time: 2016-02-14 13:05:02 +0000
  duration: 0.013452716
```

Aquí lo más importante es ver en TARGETS HISTORY el resumen de todos los casos analizados
con su evaluación final. En este ejemplo, tenemos 2 casos: case_01 con 
puntuación del 100% y case_02 con puntuación de 0%.

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

###case-01
Veamos el informe del caso 01, consultando el fichero `var/example-02/out/case-01.txt`.
```
INITIAL CONFIGURATIONS
+------------+--------------------+
| tt_members | Student-name-1     |
| tt_emails  | student1@email.com |
| username   | root               |
| tt_skip    | false              |
+------------+--------------------+
TARGETS HISTORY
  - INFO: Begin exist_username
  01 (1.0/1.0)
  		Description : Checking user <root>
  		Command     : id root| wc -l
  		Expected    : 1
  		Result      : 1
  - INFO: End exist_username
FINAL VALUES
+--------------+---------------------------+
| case_id      | 1                         |
| start_time_  | 2016-02-14 13:05:02 +0000 |
| finish_time  | 2016-02-14 13:05:02 +0000 |
| duration     | 0.006277666               |
| unique_fault | 0                         |
| max_weight   | 1.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 0.0                       |
| fail_counter | 0                         |
| grade        | 100.0                     |
+--------------+---------------------------+
```

###case-02
Ahora vemos el informe del caso 02, consultando el fichero `var/example-02/out/case-02.txt`.
```
INITIAL CONFIGURATIONS
+------------+--------------------+
| tt_members | Student-name-2     |
| tt_emails  | student2@email.com |
| username   | darth-maul         |
| tt_skip    | false              |
+------------+--------------------+
TARGETS HISTORY
  - INFO: Begin exist_username
  01 (0.0/1.0)
  		Description : Checking user <darth-maul>
  		Command     : id darth-maul| wc -l
  		Expected    : 1
  		Result      : 0
  - INFO: End exist_username
FINAL VALUES
+--------------+---------------------------+
| case_id      | 2                         |
| start_time_  | 2016-02-14 13:05:02 +0000 |
| finish_time  | 2016-02-14 13:05:02 +0000 |
| duration     | 0.005351234               |
| unique_fault | 0                         |
| max_weight   | 1.0                       |
| good_weight  | 0.0                       |
| fail_weight  | 1.0                       |
| fail_counter | 1                         |
| grade        | 0.0                       |
+--------------+---------------------------+
```

##Recordatorio

Dentro del fichero de configuración, podemos crear todas las variables 
que necesitamos para nuestro script/actividad.

Si las definimos en la zona `global` serán accesibles para todos los casos, y
en el caso de definarlas dentro de cada caso, sólo serán accesibles para dicho
caso.

Tener en cuenta que podemos usar los nombres que queramos para nuestras variables
de configuración, pero evitar que comiencen por `tt_`. Este prefijo está reservado
para variables de configuración específicas de la aplicación. Algunos ejemplos son:
* `tt_members`: Que guarda una lista con los nombres de los miembros del grupo de trabajo.
* `tt_emails`: Que guarda una lista con las cuentas de correo de los miembros del grupo de trabajo.
* `tt_skip`: Toma los valores true/false. Y define si debemos procesar/evaluar este caso o no.
