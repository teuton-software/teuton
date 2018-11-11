
# Palabras clave del DSL

Para definir y ejecutar nuestra actividad/script de evaluación,
podemos usar las siguientes palabras clave del DSL *sysadmin-game*.


# Instrucciones para definir

Éstas son las principales palabras clave del DSL, fundamentalmente para
definir elementos que se pueden evaluar.

| DSL                  | Descripción |
| :------------------- | :---------- |
| [task](./task.md)    | Definir un grupo de objetivos o elementos de comprobación. |
| [target](./target.md)| Describir el objetivo que vamos a evaluar. |
| [goto](./goto.md)    | Ejecutar un comando en las máquinas remotas o en local. |
| [run](./run.md)    | Ejecutar un comando en la máquina local. |
| [result](./result.md)| Contiene el resultado de la orden `goto`. |
| [expect](./expect.md)| Evalua si el resultado obtenido coincide o no con el valor esperado. |

# Instrucciones para ejecutar

La palabras clave del DSL para iniciar la ejecución de las tareas definidas
es `start`, y se usa de la siguiente forma:

```
    start do
      ...
    end
```

* Escribiremos esta instrucción al final de cada script, para indicar que puede
comenzar el proceso de evaluación.
* Las instrucciones `task` definen las pruebas que queremos realizar, pero la instrucción
`start` es la que finalmente inicia la ejecución de las pruebas de evaluación
dentro de cada una de las máquinas de cada caso.
* Si no escribimos esta instrucción las pruebas no se van a ejecutar.

# Instrucciones para los informes

Otras palabras clave del DSL.

| DSL                  | Descripción |
| :------------------- | :---------- |
| [show](./show.md)    | Muestra en pantalla del resultado de las evaluaciones. |
| [export](./export.md)| Crea un informe con los resultados de la evaluación. |
| [send](./send.md)    | Envia una copia del informe a los equipos remotos. |
