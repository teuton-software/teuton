
# task

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
