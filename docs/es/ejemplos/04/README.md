
##example-04

```
* En este ejemplo, vamos necesitar varias máquinas: 
    (a) la del profesor y 
    (b) varias de estudiantes.
* La máquina del profesor tiene el script que evalua el grado de cumplimiento 
  de los objetivos de las diferentes máquinas de los estudiantes.
* Usaremos el fichero de configuración para definir las diferentes máquinas remotas.
* Usaremos SSH como vía de comunicación entre las máquinas.
```

* Script: [example-04.rb](../../../examples/example-04.rb) 
* Fichero de configuración: [example-04.yaml](../../../examples/example-04.yaml)
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

Ejecutamos el script con `./docs/examples/example-04.rb` y vemos la siguiente 
[salida por pantalla](./resume.colored_text).

Cuando termina la evaluación de las máquinas, se copia el informe 
de cada caso en el directorio temporal de su máquina remota. Como la máquina
de `rd2d2` está apagada, no podrá recibir el fichero.

##Informes de salida

Los informes de salida se han creado en `var/example-04/out` de la máquina
local.

```
var/example-04/out/
├── case-01.colored_text
├── case-02.colored_text
├── case-03.colored_text
└── resume.colored_text
``` 

Además, en el directorio temporal de cada máquina remota `:host1` de cada caso,
se ha guardado una copia del informe.

Esto permite que los alumnos tengan un feedback de forma casi inmediata, si
así lo decide el profesor.
