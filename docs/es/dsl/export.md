
#export

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

