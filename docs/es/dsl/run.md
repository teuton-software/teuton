
# run

```
    run "id david"
```

* Con esta instrucción ejecutamos el comandos en la máquina local. Esto es, donde se está ejecutando el programa `Teuton`.
* De hecho es lo mismo que hacer `goto :localhost, :execute => "id david"`.
Entonces ¿por qué tener otra instrucción? Porque hay gente que le puede gustar más hacerlo de esta forma.

# Ejemplos

Ejecuta el comando `id obiwan` en la máquina local:
* `run "id obiwan"`

Ejecuta el comando `id david` en la máquina `localhost`.
* `run "id david"`
