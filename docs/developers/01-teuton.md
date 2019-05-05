
# teuton (script)

Function: run teuton

require: 'thor'

require_relative
* 'lib/application'
* 'lib/project'
* 'lib/command/create'
* 'lib/command/download'
* 'lib/command/play'
* 'lib/command/test'
* 'lib/command/update'
* 'lib/command/version'

---

# lib/application.rb

Function: Singleton than contains application global params.

require: Singleton

Used by: teuton

---

# lib/command/create

* teuton -> Project.create(path_to_new_dir)

# lib/dommand/download

* teuton -> system

# lib/command/play

* teuton ->
    * Application.instance.options.merge! options
    * Project.play(path_to_rb_file)

# lib/command/test

* teuton ->(invoke)->
    * Project.test(path_to_rb_file, options)

# lib/command/update

* teuton -> system

# lib/command/version

* teuton -> puts

---

# Next

Project
* create
* play
* test
