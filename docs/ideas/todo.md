
# Ideas

Esta es una lista de ideas para que no se me olvide... lo podemos ir ajustando 😊

1. TEST-EN-CADENA (smart-shell): es un proyecto en curso que trabajará en colaboración ceon teuton. Detecta las acciones del usuario dentro de la shell y automáticamente lanza el test para validar el cumplimiento de los objetivos. Si se supera un % se pasa al siguiente test.

2. SERVIDOR TEUTON: Teuton web para recibir peticiones de los clientes... ?! Enganchar con teuton-server y teuton-client
NO. quizás mejor enfoque. Tener un servidor dedicado con una página Web para lanzar test desde el propio servidor.

3. Editor de ficheros de configuración.... una especie de asistente de ayuda..
no le veo mucho sentido tener un editor específico pero si al ejecutar un reto
si hay valores con NODATA... entonces que pregunte al usuario y complete la
configuración sobre la marcha???

4. Editor de tests ?! .... lo veo complejo... a menos que se empiece por una versión simplificada.. El DSL es tan sencillo que no le veo sentido a un editor de retos. Pero si podemos aprovechar y crear una" librería " de los módulos más frecuentes?!... una ayuda para facilitar la creación de test... esto se puede emparejar con el editor de test...

5. `result.test("...")`
6. `send :email_to => :members_emails`

7. Empaquetar tests para facilitar su movilidad . Esto se combina muy bien con la opción de búsqueda de retos.... pensar en firma gpg o md5 de comprobación etc..  
Al ejecutar un test poder hacerlo "teuton run PATH/TO/FILE.zip"


# Gamification ideas

* When students demand help they could recibe some advises.
* Define a loop of executions of our activity. For example:
  every 5 minutes, run the activity, and repeat this 10 times.
  `start :times=>10, :duration=>5 do`      
* More ideas: bonus, lives, etc.

# Ideas para QA

* actualizar las pruebas con vagrant para la versión actual. Mejora de la calidad del código.

# Ideas para PROMOCIONAR

* Documentar y hacer videos.
* Tener foros de la comunidad o presencia en reddit o stackoverflow.... o algo parecido???

Create 2 evaluation modes:
1. Evaluate targets (current mode): `start :score=>:targets do ...`
1. Evaluate task: `start :score=>:groups do ...`


## Pending

### moodle.csv and save partial grades.

* Before play challenge read previous moodle.cvs. Then play challenge and when creates new moodle.csv... we could preseve old cases(grades) 100% for example.

### expect keyword

* `expect_equal "camaleon"`, same as `expect result.equal "camaleon"`.
* `expect_not_equal "lagarto"`, same as not expect equal.
* `expect regexp("val1|var2")`, regexp function creates regular expresion from String.
* `expect result.ok?`, result from previous goto exec.
* `result.exit_code`, exit code from previous goto exec.

### Reports and export keyword

* Work on more output formats: CSV, HTML, XML.
    * `export :format=>:html, :prefix => IAN`
    * `export :format=>:xml, :prefix => IAN`
    * `export :format=>:csv, :prefix => IAN`
* Improve RESUME report or create stat-report, with stat information:
    * the worst target/task/case,
    * the best target/task/case,
    * the slowest target/task/case,
    * the fastest target/task/case, etc.
    * Related targets: group of targets that always have the same state in every case.

### File extension

* Change ".rb" file extension by ".tt" for example. To avoid users think on ruby when using teuton files.
* So move "ruby language" documentation to other section like "expert mode"...
* Change "start.rb" or "play.rb" name to "run.tt".

### loop keyword

* Create keyword to do loops without using ruby style:
```
loop i: 1..5 do
 puts i
end

loop :a => [3,5,7] do
  puts a
end
```

### Feedback

Add new features to DSL
* `feedback or advise "Some usefull information"` provide this information when studends demand help.
## Working

### Remote temp folder

Modify send keyword so it could works with all OS. Now only work with GNU/Linux. So we need to detect remote OS, then choose remote teuton folder where uploading files.

* First goto open new session to remote host. And then:
    1. Detect remote OSTYPE: (a) GNU/Linux and MAC using "uname -a", (b) Windows using "ver" command.
    2. Create teuton remote uploading folder: (a) /tmp/teuton for GNU/Linux and MAC, (b) %windir%/temp/teuton for Windows.
* Every time we send files to remote host we will use this remote folder.

### Readme

* Pass usefull information into README.md:
```
readme do
  title ...
  intro ...
  author ...
  requirements ...
  tags ...
end
```

---

* teuton run into
* txt format -> remove conn_errors when errors = 0
