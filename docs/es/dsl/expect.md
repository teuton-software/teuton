
# expect

```
    expect result.eq(1)
    expect result.eq("obiwan")
    expect result.eq("obiwan"), :weight => 2.0
```

* Después de ejecutar un comando en una máquina determinada, obtenemos un resultado, que
se guarda en `result`.
* Con la instrucción `expect` evaluamos si el resultado obtenido coincide o no con el valor
esperado. Esta información se guarda para incluirla en los informes finales.
