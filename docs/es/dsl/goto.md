
###goto

```
    goto :host1, :exec => "id obiwan"
    goto :host1, :execute => "id david"
```

> Ya sé que a los programadores no les gusta la sentencia `goto`, pero ésta
es diferente. Piensa en ella como si hablaras en inglés, no como programador.

* Con esta instrucción nos conectamos con la máquina remota  identificada por `host1`,
y de ejecutamos el comando especificado dentro de ella.
* `host1` es una etiqueta que identifica una máquina determinada. La definición
concreta de dicha máquina (ip, username, password, protocol) vendrá en el fichero
de configuración que acompaña al script.

