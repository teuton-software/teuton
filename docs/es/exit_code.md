
# Exit code

## Introducción

Exit code o código de salida es un valor numérico que devuelven los programas cuando terminan su ejecución. Por defecto, el valor 0 indica que el programa/comando ha terminado correctamente. Un valor distinto de cero indica que ha ocurrido alguna situación inesperada o error, y su significado dependerá de cada programa concreto.

En SO GNU/Linux para consultar por terminal este valor hacemos `echo $?`. Veamos dos ejemplos:

* Ejemplo que termina correctamente:
```
> id root
uid=0(root) gid=0(root) grupos=0(root)
> echo $?
0
```

* Ejemplo que termina con error:
```
> id vader
id: «vader»: no existe ese usuario
> echo $?
1
```

## Solicitud de nueva feature

Se nos ha solicitado incorporar en `Teuton` la opción de leer no sólo la salida del comando que se ejecuta con la instrucción `run`, sino también el valor devuelto por el **exit code** del mismo.

De momento no está implementado porque la forma de leer el valor exit code es diferente en cada SO, y `Teuton` (de momento) no tiene capacidad de "adivinar" el SO del host que se está monitorizando/evaluando.

> NOTA: Estamos trabajando en adivinar el SO de host con la nueva herramienta [guess_os](https://rubygems.org/gems/guess_os), pero todavía está un poco "verde".

_¿Cómo solucionamos el problema de leer el exit code en Teuton?_

## Propuesta

De momento hacemos la siguiente propuesta (hay varias formas de afrontarlo) para leer el exit code con `Teuton`.

> NOTA: Para hacerlo todo más sencillo hemos creado dos instrucciones nuevas `expect_last` y `expect_first`.

* Veamos un ejemplo que devuelve 0:
```ruby
  target "Exist user root"
  run "id root;echo $?"
  expect_last "0"
```
* Veamos un ejemplo que devuelve 1:
```ruby
  target "Exist user vader"
  run "id vader;echo $?"
  expect_last "1"
```

## Observaciones

Estos ejemplos se probaron en GNU/Linux pero para que sirvan en Windows, etc, hay que cambiar `echo $?` por su equivalente en cada SO.
