
#example-02

* Script: [example-02.rb](../examples/example-02.rb) 
* Fichero de configuración: [example-02.yaml](../examples/example-02.yaml)
* Descripción: *Personalizar cada caso con el fichero de configuración.*

Vemos que en el script hay la siguiente nueva intrucción:
* **get**: Lee el valor del parámetro del fichero de configuración. Para cada caso 
será diferente. Las acciones de comprobación toman el valor configurado para
cada caso del fichero de configuración, de esta forma cada caso se evalúa
con diferentes valores.

En este ejemplo no tenemos definidas variables globales de configuración.
Para cada caso se definen los parámetros siguientes: `tt_members`, `tt_emails` 
y `username`.
* **username**: Este parámetro tiene diferente valor para cada caso, de modo
que cuando se ejecuta la accción de comprobación, ésta será diferente en cada
caso.

##Ejecución
Ejecutamos el script con `./docs/examples/example-02.rb` y vemos la siguiente salida por pantalla:

```
=============================================
Executing [sysadmin-game] tests (version 0.5)
[INFO] Running in parallel (2016-02-14 13:05:02 +0000)
.id: darth-maul: no existe ese usuario
?
[INFO] Duration = 0.013452716 (2016-02-14 13:05:02 +0000)


=============================================
HEAD
  tt_title: Executing [sysadmin-game] tests (version 0.5)
  tt_scriptname: ./docs/examples/example-02.rb
  tt_configfile: ./docs/examples/example-02.yaml
  tt_testname: example-02
  tt_sequence: false
HISTORY
  -  Case_001 => 100   Student-name-1
  -  Case_002 =>   0 ? Student-name-2
TAIL
  start_time: 2016-02-14 13:05:02 +0000
  finish_time: 2016-02-14 13:05:02 +0000
  duration: 0.013452716
```

Aquí lo importante es ver en HISTORY el resumen de todos los casos analizados
con su evaluación. En este ejemplo, tenemos 2 casos. Uno 100% bien y el 
otro evaluado con 0%.

##Informes de salida

Para tener más información y averiguarlo que ha pasado con cada caso, debemos
consultar el informe del mismo. Los informes se graban en `var/example-02/out`.

Primero vemos el informe del caso 01, consultando el fichero `var/example-02/out/case-01.txt`.
```
HEAD
+------------+--------------------+
| tt_members | Student-name-1     |
| tt_emails  | student1@email.com |
| username   | root               |
| tt_skip    | false              |
+------------+--------------------+
HISTORY
  - INFO: Begin exist_username
  01 (1.0/1.0)
  		Description : Checking user <root>
  		Command     : id root| wc -l
  		Expected    : 1
  		Result      : 1
  - INFO: End exist_username
TAIL
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


Ahora vemos el informe del caso 02, consultando el fichero `var/example-02/out/case-02.txt`.
```
HEAD
+------------+--------------------+
| tt_members | Student-name-2     |
| tt_emails  | student2@email.com |
| username   | darth-maul         |
| tt_skip    | false              |
+------------+--------------------+
HISTORY
  - INFO: Begin exist_username
  01 (0.0/1.0)
  		Description : Checking user <darth-maul>
  		Command     : id darth-maul| wc -l
  		Expected    : 1
  		Result      : 0
  - INFO: End exist_username
TAIL
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
