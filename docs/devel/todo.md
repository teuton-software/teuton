[<< back](../../README.md)

# Roadmap Teuton v3.0.0 - 2026

# 1. Cambios menores

* Revisar (tests): result.grep(a).grep(b)
* "Limpiar" las funciones "deprecated"
* Renombrar "teuton readme" por "teuton doc".
    * Modificar código, documentación y los ejemplos
    * Modificar los ejemplos de dvarrui/teuton-tests
* Añadir opciones de lenguaje a `teuton doc`.
    * Por defecto se usará `--lang=en`.
    * Pero poder especificar el idioma usando el paráemetro `lang`. Por ejemplo :`teuton doc --lang=es`
* Ampliar las estadísticas de salida en el report `resume`:
    * Improve RESUME report or create stat-report, with stat information.
    * the worst target/task/case,
    * the best target/task/case,
    * the slowest target/task/case,
    * the fastest target/task/case, etc.
    * Related targets: group of targets that always have the same state in every case.
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

# 2. Cambios mayores

* Aplicar las recomendaciones del informe de seguridad de Andrés.
* Documentación:
    * Nuevo repo `teuton-book`: para documentación, tutoriales en español.
    * Documentar y hacer videos. Tener foros de la comunidad o presencia en reddit o stackoverflow.... o algo parecido???

# 3. Lo más solicitado

* Nueva feature "eventos".
    * La idea está documentada mejor en el enlace siguiente.
    * [Propuesta](https://github.com/dvarrui/teuton-book/blob/main/docs/03.eventos/index.md)
* La gema `teuton-panel`

# 4. Nueva gema teuton-panel (v2.0.0)

> Consultar en el repostorio `teuton-panel`. EN PROCESO!!!

Este TO-DO debería estar en el propio repo de la nueva gema.

* Crear nueva gema `teuton-panel` (v2) que sustituirá la versión obsoleta actual.
* Modificar/ampliar las funciones de `teuton config` para facilitar el trabajo a `teuton-panel`.
    * tt_include
    * tt_include_params
    * aplanar/desaplanar config file.
* En las pruebas hemos usado `sinatra` para implementarlo.

Funcionalidades del interfaz web:

* config cases: 
    * config/remote: 
      * accept-remote-config. activar/desactivar configuraciones remotas
      * Aceptar post formulario y vía get curl con ruta.
    * config/list: mostrar listado con info de alumnos
    * Elegir ubicación de almacenamiento de las configuraciones
* run:
    * Ejecutar por el profesor
        * Todos
        * Una selección de cases
        * every: repeticiones en bucle de I iteraciones, cada T tiempo.
    * El alumno solicita su propia ejecución vía curl
    * Elegir ubicación de almacenamiento de los informes
    * Al finalizar cada ejecución se muestre un listado con los resultados
* readme/doc:
    * activar auto "teuton doc" a página web para los alumnos.
* config panel:
    * panel/new: crear fichero de configuración del panel
    * panel/save: save configuración del panel

# 5. Cambios internos

* Default port values ssh/telnet and default username values (root, Administrator)
* `expect_equal "camaleon"`, same as `expect result.equal "camaleon"`.
* REVISE
    * verify get(:key) and get('key') works fine!
    * Formatter: xml
* RENAME
    * Laboratory to Checker
    * Add tt_label as alias of tt_members
* Unify messages ERROR, INFO, WARN. etc
* **TEST**:
    * HallOfFame test
    * actualizar las pruebas con vagrant para la versión actual. Mejora de la calidad del código (Todo lo de Vagrant debería estar deprecated).

# 6. Mejorar la integración con los contenidores Docker/podman

> facilitar integración con DSL específico
>
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

# ANEXO: Varias ideas para pensarlas bien

Listado de ideas para que no se nos olviden...

* Implement "scp" over Telnet ¿?
* Use travis???
* **EDITOR de tests**:
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
* **PENSAR**: Change export to show full command output into reports.   

