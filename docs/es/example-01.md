
#example-01

* Script: [example-01.rb](../examples/example-01.rb) 
* Fichero de configuración: [example-01.yaml](../examples/example-01.yaml)
* Descripción: *Comprueba si existe el usuario *obiwan* en la máquina *localhost*.*

Vemos que en el script hay las siguientes intrucciones:
* **desc**: Texto que describe el objetivo que buscamos.
* **goto**: Moverse a la máquina *localhost*, y ejecutar el comando.
* **expect**: Evalua si el resultado es igual al valor esperado.

El fichero de configuración no establece ninguna variable global, y 
sólo contiene un caso. Este caso tiene los siguientes parámetros:

* **tt_members**: Estos son los nombres de los miembros del grupo separados por comas.
* **tt_emails**: Contiene las direcciones de correo de los miembros del grupo separados por coma.
Esta información se usará para enviar por correo a cada estudiante el informe de sus resultados.

##Ejecución
Ejecutamos el script con `./docs/examples/example-01.rb` y vemos la siguiente salida por pantalla:

```

=============================================
Executing [sysadmin-game] tests (version 0.5)
[INFO] Running in parallel (2016-02-14 12:33:34 +0000)
?
[INFO] Duration = 0.011921461 (2016-02-14 12:33:34 +0000)


=============================================
HEAD
  tt_title: Executing [sysadmin-game] tests (version 0.5)
  tt_scriptname: ./docs/examples/example-01.rb
  tt_configfile: ./docs/examples/example-01.yaml
  tt_testname: example-01
  tt_sequence: false
HISTORY
  -  Case_001 =>   0 ? student1
TAIL
  start_time: 2016-02-14 12:33:34 +0000
  finish_time: 2016-02-14 12:33:34 +0000
  duration: 0.011921461

```

Aquí lo importante es ver en HISTORY el resumen de todos los casos analizados
con su evaluación. En este ejemplo, sólo tenemos un caso que evaluado con 0%.
Esto quiere decir que no se ha completado ninguno de los objetivos previstos.

##Informe de salida

Para tener más información y averiguarlo que ha pasado con cada caso, debemos
consultar el informe del mismo. Los informes se graban en `var/example-01/out`.
Puesto que nuestro caso es el 01, consultaremo el fichero `var/example-01/out/case-01.txt`.

```
HEAD
+------------+--------------------+
| tt_members | student1           |
| tt_emails  | student1@email.com |
| tt_skip    | false              |
+------------+--------------------+
HISTORY
  - INFO: Begin exist_user_obiwan
  01 (0.0/1.0)
  		Description : Checking user <obiwan>
  		Command     : id obiwan| wc -l
  		Expected    : 1
  		Result      : 0
  - INFO: End exist_user_obiwan
TAIL
+--------------+---------------------------+
| case_id      | 1                         |
| start_time_  | 2016-02-14 12:33:34 +0000 |
| finish_time  | 2016-02-14 12:33:34 +0000 |
| duration     | 0.005904814               |
| unique_fault | 0                         |
| max_weight   | 1.0                       |
| good_weight  | 0.0                       |
| fail_weight  | 1.0                       |
| fail_counter | 1                         |
| grade        | 0.0                       |
+--------------+---------------------------+
```

Como vemos en HISTORY (que es donde se registran las acciones sobre los objetivos),
hay una acción puntuada con 0 puntos, en la que se esperaba como resultado un 1 y
se obtuvo un 0. El comando ejecutado fue `id obiwan|wc -l`. Por tanto, deducimos
que no se cumplió el objetivo de tener creado dicho usuario en el sistema.

El informe en la zona TAIL, nos da datos sobre:
* El número de identificación del caso. Por si fueran más de uno facilitar su identificación.
* Fecha/hora de inicio de la prueba de evaluación.
* Fecha/hora de finalización de la prueba de evaluación.
* Duración de la prueba de evaluación para ese caso concreto.
* `unique_fault`: En estea prueba no se usa. Lo veremos más adelante.
* Cada objetivo tiene un peso en la evaluación. Por defecto todos tienen pero 1, 
a menos que indiquemos otro valor.
* `fail_counter`: Es la cantidad de objetivos fallados.
* `grade`: Es la puntuación final en %. En este caso 0 %.
