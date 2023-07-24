[<< back](../CHANGELOG.md)

# CHANGELOG

## [0.22.1] June 2017

* Now it's posible to use config files with YAML and JSON format
* Preparing migration of CLI command to use Thor gem

## [1.0.0] July 2017

* New stable version

## 2019

## [1.10.0] Janyary 2019

* SysadminGame change his name by TEUTON. "project" command replaced by "teuton".
* Challenges (Teuton scripts) moved to "teuton-challenges" github repository.
* Execute "rake get_challenges" to get sample teuton challenges

## [2.0.4] August 2019

* TEUTON project grew up and was divided into the folowing repositories: teuton, challenges, panel, resources and vagrant.
* Documentation has been moved into respository teuton wiki. Only maintain English docs.

## [2.1.0]

**Export grades on csv file using Moodle format**

* Automaticaly exports `moodle.csv` file with all cases grades, using adecuate format so it could be imported directly into Moodle platform.
* We need to configure some params like this:

```
---
:global:
:cases:
- :tt_members: ...
  :tt_moodle_id: User Moodle Identity
```

**readme keyword**

We currently use the "teuton readme pry-folder" command to export README file from the challenge.

* This example shows how to use readme keyword to add group description or target description:

```
group "GROUPNAME" do
  readme "Description for this group"

  target "target1"
  readme "Description for this target"
  goto :host, :exec => 'id root'
  expec_one 'root'
```

**Installation process**

* Use Bundler to install gems instead of rake.
* It will be usefull use sysadming-game as gem? And install it with `gem install teuton`.
* Vagrant: test how to use vagrant machines as case hosts.

**Info sobre novedades de la versión 2.1**

1. Teuton readme y dsl readme
2. Macros de define macro
3. Export yaml y html
4. Teuton --no-color
5. teuton run --case
6. teuton run --cname
7. teuton run --cpath
8. actualizar formatos de salida
9. instalación mediante gemas
10. teuton panel
11. teuton client y server
12. nuevos nombres de comandos...
13. cambio de goto a run

## [2.2.0]

**New features**

* Let's see new features examples:
    * 10 result and moodle_id
    * 11 get_vars
    * 12 alias
    * 13 include (tt_include config param)
    * 14 macros

**Configuration file**

* Por defecto los valores de clave de los ficheros de configuración serán Strings en lugar de símbolos, aunque lo símbolos seguirán funcionando.

**get_vars: To think - We are not sure about this***

* "get" keyword simplification: Simplify getting and setting params process. For example: `_username_`, may be alias for `get(:username)`. Then

```
target "Create user #{_username_}"
run "id #{_username_}"
expect_one _username_
```
Same as

```
target "Create user "+get(:username)
run "id " + get(:username)
expect_one get(:username)
```

* Promocinar el proyecto:
    * Documentar y hacer videos.
    * Charlas y talleres

**Fixed**

* Solucionar fallo en --cname
* Revisar doc options como cpanel
