
#example-01

* Script: [example-01.rb](../examples/example-01.rb) 
* Fichero de configuración: [example-01.yaml](../examples/example-01.yaml)
* Descripción: Comprueba si existe el usuario *obiwan* en la máquina *localhost*.

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

##Informes
