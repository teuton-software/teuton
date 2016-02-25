
#Palabras clave del DSL

Para definir y ejecutar nuestra actividad de evaluación, usaremos
las siguientes palabras clave del DSL *sysadmin-game*.

##check

```
    check :nombre_del_test do 
      ... 
    end
```

* Sirve para definir un grupo de objetivos o elementos de comprobación.
* Como mínimo es obligatorio crear un `check` donde podremos definir nuestros
objetivos o elementos de evaluación.
* Podemos usar `check`, tantas veces como queramos. Principalmente sirve
para agrupar objetivos que están relacionados por razones de claridad para nosotros.
No porque lo requiera la herrramienta.

###desc, description

`desc "Escribe aquí la descripción de tu objetivo con tus propias palabras"`

* Nos permite introducir una descripción del objetivo que vamos a evaluar,
usando nuestras propias palabras, de modo que cualquiera pueda entender
facilmente lo que estamos tratando de hacer.
* Además, dicho texto aparecerá en los informes de salida, para ayudarnos
a analizar la información más facilmente.

###goto

`goto :host1, :execute => "id david|wc -l"`

* Con esta instrucción damos la orden de conectarnos con la máquina `host1`,
y de ejecutar el comando especificado dentro de ella.
* `host1` es una etiqueta que identifica una máquina determinada. La definición
concreta de dicha máquina (ip, username, password) vendrá en el fichero
de configuración que acompaña al script.

###expect

`expect result.to_i.equal?(1)`

* Después de ejecutar un comando en una maquina determinada, obtenemos un resultado.
Éste se guarda en `result`.
* Con la instrucción `expect` evaluamos si el resultado obtenido coincide o no con el valor
esperado.

##start

```
    start do
      ...
    end
```

* Escribiremos estra instrucción al final de cada script.
* Las instrucciones `check` definen las pruebas que queremos realizar, pero la instrucción
`start` es la que finalmente inicia la ejecución de las pruebas de evaluación 
dentro de cada una de las máquinas de cada caso.
* Si no escribimos esta instrucción las pruebas no se van a ejecutar.

###show

```
    start do
      show
    end
```

* `show`, esto es lo mismo que `show :resume`
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
* `export :all, :format => :txt`, Ésta es la forma de definir los ficheros de salida
que queremos crear y el formato de los mismos.

Otros valores para el formato de salida, pueden ser: `:txt`, `colored_text`, `:html` y `:xml`.

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
