
[Ejemplo anterior](./example-03.md) | [Listado de Ejemplos](./ejemplos.md) | Ejemplo siguiente

##example-04

```
    En este ejemplo, vamos necesitar varias máquinas: la del profesor y varias de estudiantes.

    La máquina del profesor tiene el script que evalua el grado de cumplimiento 
    de los objetivos de las diferentes máquinas de los estudiantes.

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
  export :format => :colored_text
  send :copy_to => :host1
end
```

La instrucción `send` envía una copia del informe con los resultados 
de cada alumnos a la máquina `:host1` de cada caso.

##Ejecución del script

Ejecutamos el script con `./docs/examples/example-04.rb` y vemos la siguiente salida por pantalla:

```
=============================================
Executing [sysadmin-game] tests (version 0.8)
[INFO] Running in parallel (2016-03-15 19:49:24 +0000)
...!????.?
[INFO] Duration = 5.473399382 (2016-03-15 19:49:30 +0000)


=============================================
INITIAL CONFIGURATIONS
+----------------+-----------------------------------------------+
| tt_title       | Executing [sysadmin-game] tests (version 0.8) |
| tt_scriptname  | ./docs/examples/example-04.rb                 |
| tt_configfile  | ./docs/examples/example-04.yaml               |
| host1_username | root                                          |
| host1_password | profesor                                      |
| tt_testname    | example-04                                    |
| tt_sequence    | false                                         |
+----------------+-----------------------------------------------+
TARGETS HISTORY
  -  Case_01 =>  33 ? darth-maul
  -  Case_02 =>   0 ? r2d2
  -  Case_03 => 100   obiwan kenobi
FINAL VALUES
+-------------+---------------------------+
| start_time  | 2016-03-15 19:49:24 +0000 |
| finish_time | 2016-03-15 19:49:30 +0000 |
| duration    | 5.473399382               |
+-------------+---------------------------+
[ OK  ] obiwan kenobi: scp </tmp/case-03.colored_text>
[ERROR] r2d2: scp <var/example-04/tmp/../out/case-02.colored_text> => </tmp/case-02.colored_text>
[ OK  ] darth-maul: scp </tmp/case-01.colored_text>

```

Cuando termina la evaluación de las máquinas, se copia de informe 
en todas aquellas máquinas remotas que tienen conexión SSH. La máquina
de `rd2d2` está apagada.

##Informes de salida

En el directorio temporal de cada máquina remota `:host1` de cada caso,
se ha guardado una copia del informe.

Esto permite que los alumnos tengan un feedback de forma casi inmediata, si
así lo decide el profesor.
