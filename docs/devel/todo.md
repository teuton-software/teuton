[<< back](../../README.md)

# Roadmap Teuton v3.0.0 - 2026

# 1. Revisar

* Revisar (tests): result.grep(a).grep(b)
* "Limpiar" las funciones "deprecated"
* Aplicar las recomendaciones del informe de seguridad de Andrés.
* verify get(:key) and get('key') works fine!
* Formatter: xml
* Revisar la utilidad de action.assets al generar README.

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

* La idea está desarrollada en el enlace siguiente.
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

> * Docker?? → https://www.cloudbees.com/blog/ssh-into-a-docker-container-how-to-execute-your-commands

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

## 4.6 Excepciones vs exit 

La buena práctica es la separación de responsabilidades:

* La librería nunca debe hacer exit ni abort. Su trabajo es exclusivamente levantar excepciones personalizadas cuando algo sale mal.
* El ejecutable (CLI) es el único que debe capturar esas excepciones, mostrarlas de forma amigable por la terminal y decidir cuándo terminar el proceso con exit 1.

* **Paso 1: Definir excepciones personalizadas**: 

```ruby
# lib/teuton/errors.rb
module Teuton
  class Error < StandardError; end
  class ConfigurationError < Error; end
  class ExecutionError < Error; end
end
```
* **Paso 2: Reemplazar los exit 1 en la librería por `raise`**

```ruby
# lib/teuton/runner.rb
def run
  if invalid_config?
    raise Teuton::ConfigurationError, "Configuración inválida"
  end
end
```

* Paso 3: Capturar las excepciones en CLI
* Integración con Thor

1. Hacer que Thor devuelva un código de salida 1 en errores de Thor

```ruby
# lib/teuton/cli.rb
require "thor"

module Teuton
  class CLI < Thor
    # Esto asegura que si Thor falla internamente (ej: comandos/opciones inválidas),
    # el programa salga con código 1 en lugar de 0.
    def self.exit_on_failure?
      true
    end

    desc "run", "Ejecuta un script de Teuton"
    def run
      # Aquí llamas a la lógica de tu gema
      # Si hay un error, tu lógica lanzará una excepción (ej: Teuton::Error)
      Teuton::Runner.new.execute
    end
  end
end
```

2. Lanzar excepciones personalizadas en la lógica de tu librería.

```ruby
# lib/teuton/runner.rb
module Teuton
  class Runner
    def execute
      if algun_error_detectado?
        raise Teuton::Error, "Ocurrió un error al ejecutar los tests"
      end
    end
  end
end
```

3. Capturar excepciones en el ejecutable bin/teuton

```ruby
#!/usr/bin/env ruby
# bin/teuton

require "teuton"

begin
  # Thor ejecuta el comando indicado por los argumentos
  Teuton::CLI.start(ARGV)
rescue Teuton::Error => e
  # Capturamos únicamente los errores previstos de tu gema
  warn "Error: #{e.message}"
  exit 1
rescue Interrupt
  # Opcional: Manejar si el usuario cancela con Ctrl+C
  puts "\nEjecución cancelada por el usuario."
  exit 130
rescue StandardError => e
  # Capturamos cualquier bug imprevisto para mostrarlo o depurarlo
  warn "Error inesperado: #{e.message}"
  exit 1
end
```

# 5. Proyectos

Ideas que emepzaron como un nuevo feature pero por sus dimensiones, funcionalidades y características van ha derivar a su propio proyecto independiente:

## 5.1 Editor de tests

* Editor de tests ?! .... lo veo complejo... a menos que se empiece por una versión simplificada..
* El DSL es tan sencillo que no le veo sentido a un editor de retos.
* Pero si podemos aprovechar y crear una" librería " de los módulos más frecuentes?!... una ayuda para facilitar la creación de test... esto se puede emparejar con el editor de test...
