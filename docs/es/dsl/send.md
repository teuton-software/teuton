
# send

```
    start do
      export
      send :copy_to => :host1
    end
```

* La instrucción `send` se debe ejecutar después de haber generado los informes de salida. Esto es, después de un `export`.
* `host1`, Es la etiqueta de uno de los host que hayamos definido para los alumnos. Debe estar definido en el fichero de configuración (YAML)
* `send :copy_to => :host1`, copia el informe de cada caso en el directorio temporal de la máquina `host1`.

> En el futuro tendremos la opción `send :copy_via => :email`.
De modo que se envíen copia de los informes de cada caso a todos los miembros
del grupo, vía correo electrónico.

Otros parámetros de `send`:
* `send :copy_to => :host1, :remote_dir => "/home/david"`, En este caso se copiará
el informe en el directorio "/home/david" de cada equipo `host1`.
* `send :copy_to => :host1, :prefix => "2016_"`, En este caso se copiará
el informe en el directorio temporal de cada equipo `host1`, el archivo tendrá
un nombre como `2016_case-XX.txt`.
