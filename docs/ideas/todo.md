
# TODO list

## Add

* `expect_equal "camaleon"`, same as `expect result.equal "camaleon"`.
* **FEATURE** Define a loop of executions of our activity. For example:
  every 5 minutes, run the activity, and repeat this 10 times.
  `start :times=>10, :every=>5 do`
* Script to set **static IP**
* Change export to show **command output** into reports.   
* **TEST**: actualizar las pruebas con vagrant para la versión actual. Mejora de la calidad del código.
* **DOCS** PROMOCIONAR.  Documentar y hacer videos. Tener foros de la comunidad o presencia en reddit o stackoverflow.... o algo parecido???
* Create 2 evaluation modes:
    1. Evaluate targets (current mode): `start eval: :targets`
    1. Evaluate task: `start eval: :groups` and perhaps add group weight?
    1. config file with `tt_eval: groups`

Improve RESUME report or create stat-report, with stat information:
* the worst target/task/case,
* the best target/task/case,
* the slowest target/task/case,
* the fastest target/task/case, etc.
* Related targets: group of targets that always have the same state in every case.

## Ideas

Esta es una lista de ideas para que no se me olvide... lo podemos ir ajustando 😊

1. TEST-EN-CADENA (smart-shell): es un proyecto en curso que trabajará en colaboración ceon teuton. Detecta las acciones del usuario dentro de la shell y automáticamente lanza el test para validar el cumplimiento de los objetivos. Si se supera un % se pasa al siguiente test.
2. SERVIDOR TEUTON: Teuton web para recibir peticiones de los clientes... ?! Enganchar con teuton-server y teuton-client. NO. quizás mejor enfoque. Tener un servidor dedicado con una página Web para lanzar test desde el propio servidor.
3. Editor de ficheros de configuración.... una especie de asistente de ayuda.. no le veo mucho sentido tener un editor específico pero si al ejecutar un reto si hay valores con NODATA... entonces que pregunte al usuario y complete la
configuración sobre la marcha???
4. Editor de tests ?! .... lo veo complejo... a menos que se empiece por una versión simplificada.. El DSL es tan sencillo que no le veo sentido a un editor de retos. Pero si podemos aprovechar y crear una" librería " de los módulos más frecuentes?!... una ayuda para facilitar la creación de test... esto se puede emparejar con el editor de test...
5. `send :email_to => :members_emails`... esto requiere que cada caso tenga un email y que además el profesor tenga configurado el acceso a su cuenta de correo... para poder enviar copias de los informes....
6. When students demand help they could recibe some advises. More ideas: bonus, lives, etc.
7. save partial grades. Before play challenge read previous moodle.cvs. Then play challenge and when creates new moodle.csv... we could preseve old cases(grades) 100% for example.

# Propuestas de sdelquin

- Docker en vez de vagrant?? → https://www.cloudbees.com/blog/ssh-into-a-docker-container-how-to-execute-your-commands
- Tablas "bonitas" en terminal → https://github.com/piotrmurach/tty-markdown#17-table
- Documentación en https://readthedocs.org/ ??
