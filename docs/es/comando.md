
# El comando `teuton`

## Ejecutar un reto

Para ejecutar una actividad lo haremos de cualquiera de las siguientes formas:

```
./teuton docs/example/example-01.rb           # RECOMMENDED: Use this!

./teuton start docs/example/example-01.rb     # Long way
ruby teuton docs/example/example-01.rb        # Windows way
ruby teuton start docs/example/example-01.rb  # Windows long way
```

---

## Sin parámetros

```
teuton> ./teuton
Commands:
  teuton create PROJECTNAME              # Create files for a new project
  teuton create-config-file PROJECTNAME  # Create YAML config file from script file
  teuton help [COMMAND]                  # Describe available commands or one specific command
  teuton lab PATH/TO/FILE/FOO.rb         # Show laboratory script objectives on screen
  teuton start PATH/TO/FILE/FOO.rb       # Run tests from script file
  teuton version                         # Show the program version

teuton>
```

---

## Comprobar un reto sin ejecutarlo

```
./teuton lab docs/examples/example-01.rb
[INFO] ScriptPath => docs/examples/example-01.rb
[INFO] ConfigPath => docs/examples/example-01.yaml
[INFO] TestName   => example-01

+---------------------------------------------+
| TASK: Create user obiwan using several ways |
+---------------------------------------------+
(001) target Way 1: Checking user <obiwan> using commands
      goto   localhost and {:exec=>"id obiwan| wc -l"}
      expect 1 (String)
      weight 1.0

(002) target Way 2: Checking user <obiwan> using count! method
      goto   localhost and {:exec=>"id obiwan"}
      alter  count!
      expect 1 (String)
      weight 1.0

(003) target Way 3: Checking user <obiwan> using find! and count! methods with String arg
      goto   localhost and {:exec=>"cat /etc/passwd"}
      alter  find!(obiwan) & count!
      expect 1 (String)
      weight 1.0

(004) target Way 4: Checking user <obiwan, obi-wan> using find! and count! methods with Regexp arg
      goto   localhost and {:exec=>"cat /etc/passwd"}
      alter  find!((?-mix:obiwan|obi-wan)) & count!
      expect 1 (String)
      weight 1.0

+--------------+-------+
| DSL Stats    | Count |
+--------------+-------+
| Tasks        | 1     |
| Targets      | 4     |
| Goto         | 4     |
|  * localhost | 4     |
| Uniques      | 0     |
| Logs         | 0     |
|              |       |
| Gets         | 0     |
| Sets         | 0     |
+--------------+-------+
[INFO] Reading Config File content...
teuton>
```

---

| Comando          | Descripción                     |
| ---------------- | ------------------------------- |
| ./teuton         | Muestra la ayuda del programa   |
| ./teuton version | Muestra la versión del programa |
