
# Creando nuestro primer reto

¿Cómo crear nuestro propio reto en tres pasos?

---

## PASO 1: Crear los ficheros base

Podemos crear los ficheros manualmente o bien ejecutar `./teuton create teuton-challenges/foo`.

Este comando nos crea:
* `teuton-challenges/foo/start.rb`: Script
* `teuton-challenges/foo/config.yaml`: Fichero de configuración YAML
* `teuton-challenges/foo/.gitignore`: Para prevenir la subida de ficheros YAML al repositorio Git.

> También podemos crear manualmente estos ficheros.

---

## PASO 2: Personalizar los objetivos

Segundo, escribimos los objetivos usando las palabras del DSL:
`target`, `goto` y `expect`. Veamos un ejemplo:

```
task "Crear el usuario gandalf" do

	target "Existe el usuario <gandalf>"
	goto :host1, :exec => "id gandalf"
	expect result.count.equal(1)

end
```

El ejemplo anterior comprueba que exista el usuario *gandalf* en la máquina *host1*.

> Veamos lo que significan estas palabras del DSL:
> * `target "Existe el usuario <gandalf>"`, Define un texto que describe el objetivo que vamos a comprobar con nuestras propias palabras. De esta forma cuando leamos el informe nos será más sencillo de interpretar los resultados.
> * `goto :host1, :exec => "id gandalf"`: Ejecuta el comando especificado
dentro de la máquina *host1*. Por defecto, la conexión con la máquina remota se hace usando SSH.
> * `expect result.count.equal(1)`: Después de ejecutar el comando necesitamos comprobar si contando el número de líneas del resultado obtenido coincide con el valor esperado. Esto es, 1.

---

## PASO 3: Personalizar el fichero de configuración

Como paso final, necesitamos un fichero de configuración en formato YAML
(`teuton-challenges/foo/config.yaml`). Este fichero contiene los parámetros y configuraciones de los hosts usados por nuestro script.

> Veamos un ejemplo:
>
> ```
> ---
> :global:
>   :host1_username: root
> :cases:
> - :tt_members: Student 01
>   :host1_ip: 1.1.1.1
>   :host1_password: clave-root-para-student-01
> - :tt_members: Student 02
>   :host1_ip: 2.2.2.2
>   :host1_password: clave-root-para-student-02
> ```

El fichero de configuración anterior configura 2 casos (concursantes)
con sus propios parámetros. El script usa esta información cuando ejecuta cada caso.

---

## PASO 4: Ejecutar el script

`./teuton teuton-challenges/foo/start.rb`

_¡Eso es todo!_
