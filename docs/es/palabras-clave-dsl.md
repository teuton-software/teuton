
#Palabras clave del DSL

Para definir y ejecutar nuestra actividad/script de evaluación, 
podemo usar las siguientes palabras clave del DSL *sysadmin-game*.

##task

```
    task "nombre_de_la_tarea" do 
      ... 
    end
```

* Sirve para definir un grupo de objetivos o elementos de comprobación.
* Como mínimo es obligatorio crear un `task` donde podremos definir nuestros
objetivos o elementos de evaluación.
* Podemos usar `task`, tantas veces como queramos. Sirve para:
    * Agrupar objetivos que están relacionados por razones de claridad para nosotros.
    * En el futuro, servirá para aumentar la velocidad de las evaluaciones, permitiendo
    la ejecución de varias tareas de forma simultánea.

###target

`target "Escribe aquí la descripción del objetivo con tus propias palabras"`

* Nos permite introducir una descripción del objetivo que vamos a evaluar,
usando nuestras propias palabras, de modo que cualquiera pueda entender
fácilmente lo que estamos tratando de hacer.
* Además, dicho texto aparecerá en los informes de salida, para ayudarnos
a analizar la información más facilmente.

###goto

`goto :host1, :execute => "id david"`

> Ya sé que a los programadores no les gusta la sentencia `goto`, pero ésta
es diferente. Piensa en ella como si hablaras en inglés, no como programador.

* Con esta instrucción nos conectamos con la máquina remota  identificada por `host1`,
y de ejecutamos el comando especificado dentro de ella.
* `host1` es una etiqueta que identifica una máquina determinada. La definición
concreta de dicha máquina (ip, username, password, protocol) vendrá en el fichero
de configuración que acompaña al script.

###result

* Después de ejecutar un comando con `goto`, en una maquina remota, se
obtiene un resultado, que se guarda en `result`.
* Podemos leer el contenido de `result` o modificarlo.
* Veamos ejemplos:
    * `result.value`, devuelve la primera línea/valor del resultado.
    * `result.content`, devuelve todas las líneas del resultado.
    * `result.eq(VALUE)`, devuelve true si el resultado es igual a VALUE    
    * `result.neq(VALUE)`, devuelve true si el resultado no es igual a VALUE
    * `result.gt(VALUE)`, devuelve true si el resultado es mayor que VALUE
    * `result.ge(VALUE)`, devuelve true si el resultado es mayor o igual que VALUE
    * `result.lt(VALUE)`, devuelve true si el resultado es menor que VALUE
    * `result.le(VALUE)`, devuelve true si el resultado es menor o igual que VALUE
    * `result.find!(VALUE)` o `result.grep!(VALUE)`, transforma el resultado, 
    de modo que sólo quedan las líneas que contengan VALUE. VALUE puede ser 
    texto (Por ejemplo, `"Hello"`) o una expresión regular (Por ejemplo: `/[Hi|Hello]/`.
    * `result.not_find!(VALUE)` o `result.grep_v!(VALUE)`, transforma el resultado, de modo que sólo quedan las líneas que no contengan VALUE
    * `resutl.alterations`, muestra las transformaciones que se han realizado al resultado.
    * `result.restore!`, vuelve a restaurar el contenido del resultado a su valor original antes de las transformaciones.
    * `result.count!`, transforma el resultado, guardando el valor numérico del número de líneas actual.

###expect

`expect result.eq(1)`

* Después de ejecutar un comando en una maquina determinada, obtenemos un resultado, que
se guarda en `result`.
* Con la instrucción `expect` evaluamos si el resultado obtenido coincide o no con el valor
esperado.

##start

```
    start do
      ...
    end
```

* Escribiremos esta instrucción al final de cada script, para indicar que debe comenzar el proceso
de evaluación.
* Las instrucciones `task` definen las pruebas que queremos realizar, pero la instrucción
`start` es la que finalmente inicia la ejecución de las pruebas de evaluación 
dentro de cada una de las máquinas de cada caso.
* Si no escribimos esta instrucción las pruebas no se van a ejecutar.

###show

```
    start do
      show
    end
```

* `show`, esto es lo mismo que `show :resume`. Es la opción por defecto.
* `show :resume`, muestra un resumen en pantalla del resultado cuando terminan las evaluaciones.
* `show :details`, muestra todos los detalles de los casos en pantalla al terminar las evaluaciones.
* `show :all`, esto es lo mismo que `show :resume` y `show :details`.

###export

```
    start do
      export
    end
```

* `export`, Esto es lo mismo que `export :all`
* `export :all`, crea un fichero de salida para cada caso, con los resultados 
de la evaluación. Por defecto se usa TXT como formato de salida.
* `export :format => :txt`, Ésta es la forma de definir los ficheros de salida
que queremos crear y el formato de los mismos.

Otros valores para el formato de salida, pueden ser: `:txt` y `colored_text`.
Actualmente en desarrolo están los formatos `:html`, `:xml`, y `:csv`.

###send

```
    start do
      export
      send :copy_to => :host1
    end
``` 

* La instrucción `send` se debe ejecutar después de haber generado los
informes de salida. Esto es, después de un `export`.
* `host1`, Es la etiqueta de uno de los host que hayamos definido para los alumnos.
* `send :copy_to => :host1`, copia el informe de cada caso en el directorio
temporal de la máquina `host1`.

> En el futuro tendremos la opción `send :copy_via => :email`.
De modo que se envíen copia de los informes de cada caso a todos los miembros
del grupo, vía correo electrónico.

Otros parámetros de `send`:
* `send :copy_to => :host1, :remote_dir => "c:\Users\david\"`, En este caso se copiará
el informe en el directorio "c:\Users\david" de cada equipo `host1`.
* `send :copy_to => :host1, :prefix => "2016_"`, En este caso se copiará
el informe en el directorio temporal de cada equipo `host1`, el archivo tendrá
un nombre como `2016_case-XX.txt`.
