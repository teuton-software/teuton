
[Ejemplo anterior](./example-03.md) | [Listado de Ejemplos](./ejemplos.md) | Ejemplo siguiente

##example-04

```
    En este ejemplo, vamos necesitar varias máquinas: la del profesore y varias de estudiantes.
    Las máquinas de los estudiantes tienen el contenido que va a ser evaluado.
    La máquina del profesor tiene el script que evalua el grado de cumplimiento de los objetivos de las diferentes máquinas de los estudiantes.
    Usaremos el fichero de configuración para definir las diferentes máquinas remotas.
    Usaremos SSH como vía de comunicación entre las máquinas.
```

* Script: [example-04.rb](../examples/example-04.rb) 
* Fichero de configuración: [example-04.yaml](../examples/example-04.yaml)
* Descripción: Evalua varios casos entrando en *máquinas remotas*, dejando 
copia del informe en el directorio temporal de la *máquina remota*.
* Requisitos: En este ejemplo se ejecutan comandos de GNU/Linux en las *máquinas remotas*.
*localhost* puede ser cualquier otro sistema operativo.

##Script

La diferencia con el ejemplo anterior, son las instrucciones al final del script:

```
start do
  show
  export
  send_copy :to => :host1
end
```

La instrucción `send_copy` copia el informe con los resultados en la
máquina :hos1 de cada caso.

##Ejecución del script
Ejecutamos el script con `./docs/examples/example-04.rb` y vemos la siguiente salida por pantalla:

```
=============================================
Executing [sysadmin-game] tests (version 0.7)
[INFO] Running in parallel (2016-02-25 19:27:48 +0000)
!???...?.?
[INFO] Duration = 5.340914829 (2016-02-25 19:27:53 +0000)


=============================================
INITIAL CONFIGURATIONS
+----------------+-----------------------------------------------+
| tt_title       | Executing [sysadmin-game] tests (version 0.7) |
| tt_scriptname  | ./docs/examples/example-04.rb                 |
| tt_configfile  | ./docs/examples/example-04.yaml               |
| host1_username | root                                          |
| host1_password | profesor                                      |
| tt_testname    | example-04                                    |
| tt_sequence    | false                                         |
+----------------+-----------------------------------------------+
TARGETS HISTORY
  -  Case_01 =>   0 ? darth-maul
  -  Case_02 =>  33 ? r2d2
  -  Case_03 => 100   obiwan kenobi
FINAL VALUES
+-------------+---------------------------+
| start_time  | 2016-02-25 19:27:48 +0000 |
| finish_time | 2016-02-25 19:27:53 +0000 |
| duration    | 5.340914829               |
+-------------+---------------------------+
[ OK  ] obiwan kenobi: scp </tmp/case-03.txt>
[ERROR] darth-maul: scp <var/example-04/tmp/../out/case-01.txt> => </tmp/case-01.txt>
[ OK  ] r2d2: scp </tmp/case-02.txt>
```

Cuando termina la evaluación de las máquinas, se copia de informe 
en todas aquellas máquinas remotas que tienen conexión SSH. La máquina
de `darth-maul` está apagada.

##Informes de salida

En el directorio temporal de cada máquina remota `:host1` de cada caso,
se ha guardado copia de cada informe.

Esto permite que los alumnos tengan un feedback casi de forma inmediata, si
nos parece adecuado.
