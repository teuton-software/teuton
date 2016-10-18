
#Palabras clave del DSL

Para definir y ejecutar nuestra actividad/script de evaluación,
podemos usar las siguientes palabras clave del DSL *sysadmin-game*.


| DSL                  | Descripción |
| :------------------- | :---------- |
| [task](./task.md)    | Definir un grupo de objetivos o elementos de comprobación. |
| [target](./target.md)| Describir el objetivo que vamos a evaluar. |
| [goto](./goto.md)    | Ejecutar un comando en las máquinas remotas. |
| [result](./result.md)| Contiene el resultado de la orden `goto`. |

###expect

```
    expect result.eq(1)
    expect result.eq("obiwan")
    expect result.eq("obiwan"), :weight => 2.0
```

* Después de ejecutar un comando en una maquina determinada, obtenemos un resultado, que
se guarda en `result`.
* Con la instrucción `expect` evaluamos si el resultado obtenido coincide o no con el valor
esperado. Esta información se guarda para incluirla en los informes finales.

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
      export :format => :colored_text
    end
```

* `export`, Esto es lo mismo que `export :all`
* `export :all`, crea un fichero de salida para cada caso, con los resultados
de la evaluación. Por defecto se usa TXT como formato de salida.
* `export :format => :txt`, Ésta es la forma de definir los ficheros de salida
que queremos crear y el formato de los mismos. Otros valores para
el formato de salida, pueden ser: `:txt` y `colored_text`.

> Actualmente están en desarrolo los formatos `:html`, `:xml`, y `:csv`.

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
