[<< back](../../README.md)

# Roadmap Teuton v3.0.0 - 20260209

Cambios menores:
* "Limpiar" las funciones "deprecated"
* Cambiar "teuton readme" por "teuton doc".
    * Modificar código, documentación y los ejemplos
    * Modificar los ejemplos de dvarrui/teuton-tests
* Añadir opciones de lenguaje a `teuton doc`.
    * Por defecto se usará `lang=en`. 
    * Pero poder especificar el idioma usando el paráemetro `lang`. Por ejemplo :`teuton doc --lang=es`
* Ampliar las estadísticas de salida. 
    * Improve RESUME report or create stat-report, with stat information.
    * the worst target/task/case,
    * the best target/task/case,
    * the slowest target/task/case,
    * the fastest target/task/case, etc.
    * Related targets: group of targets that always have the same state in every case.

Cambios mayores:
* Aplicar las recomendaciones del informe de seguridad de Andrés.
* Crear nueva gema `teuton-panel` (v2) que sustituirá la versión obsoleta actual.
* Modificar/ampliar las funciones de `teuton config` para facilitar el trabajo a `teuton-panel`.
    * tt_include
    * tt_include_params
* Nueva feature "eventos". 
    * [Propuesta](https://github.com/dvarrui/teuton-book/blob/main/docs/03.eventos/index.md)
* Nueva gema `teuton-panel`
* Nuevo repo `teuton-book`: para documentación, tutoriales en español.

---

# teuton-panel (v2.0.0)

* **FEATURE** Define a loop of executions of our activity.
  * For example: every 5 minutes, run the activity, and repeat this 10 times. `start :times=>10, :every=>5 do`
  * teuton run TEST --auto=5. Execute TEST every 5 minutes
* **FUTURO**. TEST-EN-CADENA (smart-shell): es un proyecto en curso que trabajará en colaboración ceon teuton. Detecta las acciones del usuario dentro de la shell y automáticamente lanza el test para validar el cumplimiento de los objetivos. Si se supera un % se pasa al siguiente test.
* SERVIDOR TEUTON: Teuton web para recibir peticiones de los clientes... ?! Enganchar con teuton-server y teuton-client. NO. quizás mejor enfoque. Tener un servidor dedicado con una página Web para lanzar test desde el propio servidor.
* Editor de ficheros de configuración.... una especie de asistente de ayuda.. no le veo mucho sentido tener un editor específico pero si al ejecutar un reto si hay valores con NODATA... entonces que pregunte al usuario y complete la
configuración sobre la marcha???

---

# TODO list

## Ideas

Esta es una lista de ideas para que no se me olvide... lo podemos ir ajustando 😊

* **IDEA**. Editor de tests:
    * Editor de tests ?! .... lo veo complejo... a menos que se empiece por una versión simplificada..
    * El DSL es tan sencillo que no le veo sentido a un editor de retos.
    * Pero si podemos aprovechar y crear una" librería " de los módulos más frecuentes?!... una ayuda para facilitar la creación de test... esto se puede emparejar con el editor de test...
* **SEND**. `send :email_to => :members_emails`... esto requiere que cada caso tenga un email y que además el profesor tenga configurado el acceso a su cuenta de correo... para poder enviar copias de los informes....
* **HELP**. When students demand help they could recibe some advises. More ideas: bonus, lives, etc.
* **FEATURE - SAVE STATE**:
    * Save case state or progress. var/tesname/states.db ¿?
    * save partial grades. Before play challenge read previous moodle.cvs.
    * Then play challenge and when creates new moodle.csv... we could preseve old cases(grades) 100% for example.
    * Create 2 evaluation modes:
        1. Evaluate targets (current mode): `start eval: :targets`
        1. Evaluate task: `start eval: :groups` and perhaps add group weight?
        1. config file with `tt_eval: groups`
* Propuestas de sdelquin
    * Docker en vez de vagrant?? → https://www.cloudbees.com/blog/ssh-into-a-docker-container-how-to-execute-your-commands
    * Tablas "bonitas" en terminal → https://github.com/piotrmurach/tty-markdown#17-table
    * Documentación en https://readthedocs.org/ ??
* **DOCUMENTACION**
    * Snode Dockerfile with SSH server
    * **PENSAR**: Script to set **static IP**
* FEATURE: Auto Parse new input format, and detect parse errors
* **FEATURE - EXPORT**. Sign reports generated with GPG... just to verify autenticity if needed.
* **ngrok**:
    * Doc ngrok use. Use cases and tutorial
    * Doc host1_route combined with ngrok
* **FEATURE**: Host object so "host(:debian)" return a Host object so

```
   h = host(:debian)
   h.ip -> get(:debian_ip)
   h.username -> get(:debian_username)
   h.password -> get(:debian_password)
   h.port
   h.route
   h.protocol
```

* **PENSAR**: Change export to show **command output** into reports.   

## Internal changes

* Implement "scp" over Telnet ¿?
* Default port values ssh/telnet and default username values (root, Administrator)
* Use travis
* `expect_equal "camaleon"`, same as `expect result.equal "camaleon"`.
* REVISE: verify get(:key) and get('key') works fine!
* REVISE: Formatter: xml
* HallOfFame test
* Rename Laboratory to Checker
* Unify messages ERROR, INFO, WARN. etc
* Add tt_label as alias of tt_members
* **TEST**: actualizar las pruebas con vagrant para la versión actual. Mejora de la calidad del código.
* **DOCS** PROMOCIONAR.  Documentar y hacer videos. Tener foros de la comunidad o presencia en reddit o stackoverflow.... o algo parecido???

## Docker/podman integration

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
