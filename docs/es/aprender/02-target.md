[<< back](README.md)

# target

Un [target](../../dsl/target.md) es el objetivo que queremos evaluar. Los objetivos se definen dentro de una sección `group`.

## Target definition

Cada proceso de evaluación consta de 3 partes:

* [target](../../dsl/target.md): Descripción del elemento que va a ser evaluado.
* [run](../../dsl/run.md): Ejecutar el comando `id obiwan` en la máquina local.
* [expect](../../dsl/expect.md): Verificar que el resultado del comando devuelve el valor esperado.

```ruby
group "Aprender sobre los targets" do

  target "Existe el usuario <obiwan>"
  run "id obiwan"
  expect ["uid=", "(obiwan)", "gid="]

  target "No existe el usuario <vader>"
  run "id vader"
  expect_fail
end
```

> En este ejemplo estamo usando un SO GNU/Linux en la máquina local porque queremos ejecutar el comando `id obiwan`.

Cuando el usuario existe, esperamos encontrar estas palabras en la salida del comando: `uid=, (obiwan), gid=`.

```
> id obiwan
uid=1000(obiwan) gid=1000(obiwan) grupos=1000(obiwan)
```

Pero cuando el usuario no existe, se esperan una salida de error.

```
> id vader
id: «vader»: no such user

> echo $?
1

```

## Section de ejecución

Cuando se ejecuta el test, se procesa la sección `play`, la cual contiene las siguientes instrucciones:

* [show](../../dsl/show.md): mostrar por pantalla información del proceso.
* [export](../../dsl/export.md): generar informes de salida.

```ruby
play do
  show
  export
end
```

## Ejemplo

Usa este comando para ejecutar el test:

```console
> teuton run examples/02-target

CASE RESULTS
+------+-----------+-------+-------+
| CASE | MEMBERS   | GRADE | STATE |
| 01   | anonymous | 100.0 | ✔     |
+------+-----------+-------+-------+
```

Los informes de salida se crean en la carpeta `var/02-target/`:

```console
var
└── 02-target
    ├── case-01.txt
    ├── moodle.csv
    └── resume.txt
```

Veamos el contenido:

```
> cat var/02-target/case-01.txt

CONFIGURATION
+-------------+-----------+
| tt_members  | anonymous |
| tt_sequence | false     |
| tt_skip     | false     |
| tt_testname | 02-target |
+-------------+-----------+

GROUPS
- Learn about targets
    01 (0.0/1.0)
        Description : Create user obiwan
        Command     : id obiwan
        Output      : id: «obiwan»: no existe ese usuario
        Duration    : 0.002 (local)
        Alterations : find(uid=) & find((obiwan)) & find(gid=) & count
        Expected    : Greater than 0
        Result      : 0
    02 (1.0/1.0)
        Description : Delete user vader
        Command     : id vader
        Output      : id: «vader»: no existe ese usuario
        Duration    : 0.002 (local)
        Alterations : Read exit code
        Expected    : Greater than 0
        Result      : 1

RESULTS
+--------------+---------------------------+
| case_id      | 01                        |
| start_time   | 2023-06-16 08:42:13 +0100 |
| finish_time  | 2023-06-16 08:42:13 +0100 |
| duration     | 0.004527443               |
| unique_fault | 0                         |
| max_weight   | 2.0                       |
| good_weight  | 1.0                       |
| fail_weight  | 1.0                       |
| fail_counter | 1                         |
| grade        | 50                        |
+--------------+---------------------------+
```
