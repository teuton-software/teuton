
# result

* Después de ejecutar un comando con `goto`, en una maquina remota, se
obtiene un resultado, que se guarda en `result`.
* Podemos leer el contenido de `result` o modificarlo.

# Ejemplos

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
