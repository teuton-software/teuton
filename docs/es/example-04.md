
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
Executing [sysadmin-game] tests (version 0.6)
[INFO] Running in parallel (2016-02-25 19:00:45 +0000)
...!????.?
[INFO] Duration = 5.351382427 (2016-02-25 19:00:50 +0000)


=============================================
INITIAL CONFIGURATIONS
  tt_title: Executing [sysadmin-game] tests (version 0.6)
  tt_scriptname: ./docs/examples/example-04.rb
  tt_configfile: ./docs/examples/example-04.yaml
  host1_username: root
  host1_password: profesor
  tt_testname: example-04
  tt_sequence: false
TARGETS HISTORY
  -  Case_01 =>   0 ? darth-maul
  -  Case_02 =>  33 ? r2d2
  -  Case_03 => 100   obiwan kenobi
FINAL VALUES
  start_time: 2016-02-25 19:00:45 +0000
  finish_time: 2016-02-25 19:00:50 +0000
  duration: 5.351382427
[ERROR] darth-maul: scp <var/example-04/tmp/../out/case-01.txt> => </tmp/case-01.txt>
[ OK  ] obiwan kenobi: scp </tmp/case-03.txt>
[ OK  ] r2d2: scp </tmp/case-02.txt>

```

Aquí lo más importante es ver que después de evaluarse las máquinas, se
deja copia del informe en todas aquellas que tienen conexión SSH.

##Informes de salida

En el directorio temporal de cada máquina `:host1` de cada caso.
