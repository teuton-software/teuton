
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

##desc, description

`desc "Escribe aquí la descripción de tu objetivo con tus propias palabras"`

* Nos permite introducir una descripción del objetivo que vamos a evaluar,
usando nuestras propias palabras, de modo que cualquiera pueda entender
facilmente lo que estamos tratando de hacer.
* Además, dicho texto aparecerá en los informes de salida, para ayudarnos
a analizar la información más facilmente.

##goto

`goto :host1, :execute => "id david|wc -l"`

* Con esta instrucción damos la orden de conectarnos con la máquina `host1`,
y de ejecutar el comando especificado dentro de ella.
* `host1` es una etiqueta que identifica una máquina determinada. La definición
concreta de dicha máquina (ip, username, password) vendrá en el fichero
de configuración que acompaña al script.

##expect

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

We put this action at the end of every script, so it is the timr to begin
running the tests over the machines.


##show
* `show`, it's the same as `show :resume`
* `show :resume`, show a resume on the screen when the script finish.
* `show :details`, show details of every case when the script finish.
* `show :all`, it's the same as `show :resume` and `show :details`.

##export
* `export`, it's the same as `export :all`
* `export :all`, create ouput file with the results of every single case.
By default use TXT format ouput.
* `export :all, :format => :txt`, create ouput text file with the results of every single case.

Other values for `:format` option are:
* `:txt`, plain text
* `:html`, HTML
* `:xml`, XML
