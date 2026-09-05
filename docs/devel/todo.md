[<< back](../../README.md)

# Roadmap Teuton v3.0.0 - 2026

# 1. Revisar

* Revisar (tests): result.grep(a).grep(b)
* "Limpiar" las funciones "deprecated"
* Aplicar las recomendaciones del informe de seguridad de Andrés.
* Eliminar/limpiar toda referencia a Vagrant.
* verify get(:key) and get('key') works fine!
* Formatter: xml

# 2. Documentacion

* Nuevo repo `teuton-book`: para documentación, tutoriales en español.
* Documentar y hacer videos. Tener foros de la comunidad o presencia en reddit o stackoverflow.... o algo parecido???
* Snode Dockerfile with SSH server
* **ngrok**:
    * Doc ngrok use. Use cases and tutorial
    * Doc host1_route combined with ngrok
* **PENSAR**: Script to set **static IP**

# 3. Features

## 3.1. teuton readme -> teuton doc

* Renombrar "teuton readme" por "teuton doc".
    * Modificar código, documentación y los ejemplos
    * Modificar los ejemplos de dvarrui/teuton-tests
* Añadir opciones de lenguaje a `teuton doc`.
    * Por defecto se usará `--lang=en`.
    * Pero poder especificar el idioma usando el paráemetro `lang`. Por ejemplo :`teuton doc --lang=es`

## 3.2. Feature: export stats on resume

Ampliar las estadísticas de salida en el report `resume`:
* Improve RESUME report or create stat-report, with stat information.
* the worst target/task/case,
* the best target/task/case,
* the slowest target/task/case,
* the fastest target/task/case, etc.
* Related targets: group of targets that always have the same state in every case.

## 3.3. Feature: Eventos

Nueva feature "eventos".

* La idea está documentada mejor en el enlace siguiente.
* [Propuesta](https://github.com/dvarrui/teuton-book/blob/main/docs/03.eventos/index.md)

Idea antigua: `ensure`

* ensure: es como un target pero que no puntua
* Puede puntuar 0, poner grade a 0, dejar un log y terminar
* Puede puntuar 0 y dejar un log
* Puede puntuar negativo y dejar un log
* para controlar los hacking de los alias/fake scripts

## 3.4. Feature: libs vs macros

libs/module

* Cambiar las macros por lib/modules
* Permitir crear librerías reutilizables
* bloques "TRE" target/run/expect
* Conjuntos de bloques <TRE>
* cualquier lógica reutilizable

## 3.5 Integración con contenedores

Modificar el DSL/configuración para mejorar la integración con los contenidores Docker/podman:

> * Docker en vez de vagrant?? → https://www.cloudbees.com/blog/ssh-into-a-docker-container-how-to-execute-your-commands

Host definition example:

```
  host1_ip:
  host1_port:
  host1_username:
  host1_password:

  host1_docker_image: "debian:latest"
  host1_docker_name (default value) -> "testname_hostname_case01" as dockername
  host1_docker_preffix: (Code added to docker name) "idp" -> "idp_hostname_case01"

  host1_docker_vol_rw: "_, _, _"
  host1_docker_vol_ro: "_, _, _"
```

* Folders to mount docker volumes
  Create temp folders for every case/host.
  but... When create theses folders?
  (1) While running? This may be done automaticaly at running first step
      It's easy but temp folders that not exists before running test
  (2) Before run?    New command as: "teuton create-temp" TESTNAME
      It's usefull if we need to put files into temp folders (volumes)
      before running test.

```
var
└── test_1
    └── tmp
        ├── case01
        │   ├── host1
        │   └── host2
        ├── case02
        │   ├── host1
        │   └── host2
        └── case03
            ├── host1
            └── host2
```

## 3.6 SEND email

* `send :email_to => :members_emails`... esto requiere que cada caso tenga un email y que además el profesor tenga configurado el acceso a su cuenta de correo... para poder enviar copias de los informes....

## 3.7 varios

* **HELP**. When students demand help they could recibe some advises. More ideas: bonus, lives, etc.

# 4. Refactor internal code

## 4.1. Host object

* Host object so "host(:debian)" return a Host object so

```
   h = host(:debian)
   h.ip -> get(:debian_ip)
   h.username -> get(:debian_username)
   h.password -> get(:debian_password)
   h.port
   h.route
   h.protocol
```

## 4.2 Cambios internos

* Default port values ssh/telnet and default username values (root, Administrator)
* `expect_equal "camaleon"`, same as `expect result.equal "camaleon"`.
* RENAME
    * Laboratory to Checker
    * Add tt_label as alias of tt_members
* Unify messages ERROR, INFO, WARN. etc
* **TEST**:
    * HallOfFame test
    * actualizar las pruebas con vagrant para la versión actual. Mejora de la calidad del código (Todo lo de Vagrant debería estar deprecated).

## 4.3 FEATURE - SAVE STATE

* Save case state or progress. var/tesname/states.db ¿?
* save partial grades. Before play challenge read previous moodle.cvs.
* Then play challenge and when creates new moodle.csv... we could preseve old cases(grades) 100% for example.
* Create 2 evaluation modes:
    1. Evaluate targets (current mode): `start eval: :targets`
    1. Evaluate task: `start eval: :groups` and perhaps add group weight?
    1. config file with `tt_eval: groups`

## 4.4 varios

* Implement "scp" over Telnet ¿?
* Use travis???
* **FEATURE - EXPORT**. Sign reports generated with GPG... just to verify autenticity if needed.
* **PENSAR**: Change export to show full command output into reports.   
* Propuestas de sdelquin
    * Tablas "bonitas" en terminal → https://github.com/piotrmurach/tty-markdown#17-table
    * Documentación en https://readthedocs.org/ ??
* FEATURE: Auto Parse new input format, and detect parse errors

## 4.5 Async or Ractors

Expandir el modo de ejecución y medir rendimiento:

- Secuencial
- Hilos
- Fibras
- Actores

# 5. Proyectos

Ideas que emepzaron como un nuevo feature pero por sus dimensiones, funcionalidades y características van ha derivar a su propio proyecto independiente:

## 5.1 Editor de tests

* Editor de tests ?! .... lo veo complejo... a menos que se empiece por una versión simplificada..
* El DSL es tan sencillo que no le veo sentido a un editor de retos.
* Pero si podemos aprovechar y crear una" librería " de los módulos más frecuentes?!... una ayuda para facilitar la creación de test... esto se puede emparejar con el editor de test...
