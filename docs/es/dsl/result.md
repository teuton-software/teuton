
# result

* Después de ejecutar un comando con `goto`, en una máquina local o remota, se
obtiene un resultado, que se guarda en `result`.
* Podemos leer el contenido de `result` o modificarlo.

# Ejemplos

Funciones que devuelven información:
* `result.value`, devuelve la primera línea/valor del resultado.
* `result.content`, devuelve todas las líneas del resultado.
* `result.alterations`, muestra las transformaciones que se han realizado al resultado.
* `result.debug`, muestra el contenido del objeto result en pantalla. Esta función sólo las usaremos para realizar tareas de depuración.

Funciones booleanas:
* `result.eq(VALUE)`, devuelve `true` si el resultado es igual a VALUE    
* `result.neq(VALUE)`, devuelve `true` si el resultado no es igual a VALUE
* `result.gt(VALUE)`, devuelve `true` si el resultado es mayor que VALUE
* `result.ge(VALUE)`, devuelve `true` si el resultado es mayor o igual que VALUE
* `result.lt(VALUE)`, devuelve `true` si el resultado es menor que VALUE
* `result.le(VALUE)`, devuelve `true` si el resultado es menor o igual que VALUE.

Funciones de transformación/filtrado:
* `result.find!(VALUE)` o `result.grep!(VALUE)`, transforma el resultado,
de modo que sólo quedan las líneas que contengan VALUE. VALUE puede ser:.
    * VALUE puede ser un texto. Por ejemplo, `"Hello"`, filtra el contenido con
    las líneas que contengan dicho texto
    * VALUE puede ser una expresión regular. Por ejemplo: `/[H|h]ello]`, filtra el contenido
    con todas las líneas que contengan "Hello" o "hello".
    * VALUE puede ser un array Por ejemplo: `["Hi","Hello"]`, filtra el contenido
    con todas las líneas que contengan "Hi" o "Hello".
* `result.not_find!(VALUE)` o `result.grep_v!(VALUE)`, transforma el resultado,
de modo que sólo quedan las líneas que no contengan VALUE. VALUE puede ser texto,
una expersión regular o un array.
* `result.count!`, transforma el resultado, guardando el valor numérico del número de líneas actual.
* `result.restore!`, vuelve a restaurar el contenido del resultado a su valor original antes de las transformaciones/filtrados.
