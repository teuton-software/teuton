
# 03 - Encoding (Charset)

---

# 1. Introducción

Supongamos que tenemos la siguiente instrucción de SysadminGame:

`goto :host1, :exec => "whoami"`

Con esta instrucción se abre una conexión remota al equipo `:host1` y se ejecuta el comando `whoami`.
Luego el texto obtenido se guarda en una variable String que luego se convierte en un Array con cada
una de las líneas del texto de salida del comando. Ejemplo:

```
# Si text es el texto devuelto por el comando entonces output es un Array de Strings
output = text.split("\n")
```

La variable String de ruby trabaja con codificación 'UTF-8'. En el momento de ejecutar
`text.split("\n")` se espera que text esté codificado 'UTF-8'. En caso contrario tenemos un error.

---

# 2. Problema

Cuando ejecutamos:

`goto :win1, :exec => "get-windowsfeature -name rds-rd-server"`

siendo `:win1` un Windows 2012 server tenemos un error.

Si ejecutamos el comando manualmente obtenemos la siguiente salida:

```
david@camaleon:~/proy/tools/sysadmin-game> ssh administrador@192.168.1.114 'get-windowsfeature -name rds-rd-server'
administrador@192.168.1.114's password:

Display Name                                            Name                   
------------                                            ----                   
    [ ] Host de sesi�n de Escritorio remoto             RDS-RD-Server          
```

Como podemos comprobar, este comando genera una salida con tildes codificada en ISO-8859-1. Y ahí están el problema.

---

# 3. Solución

La solución que se propone es poner la siguiente instrucción en esos casos:

`goto :win1, :exec => "get-windowsfeature -name rds-rd-server", :encoding => "ISO-8859-1"`

Esto es, para las salidas de los comandos que requieran conversión de tipo, se debe
especificar con `:encoding` el tipo de codificación que se recibirá. Luego ésta se convierte
internamente a 'UTF-8' y a partir de ahí todo funcionará correctamente.

---

# 4. Comentarios

Entiendo que es una molestia indicar la codificación en algunos comandos/servidores especiales. Pero por ahora no se puede asumir que siempre se recibirán los caracteres con la misma codificación.

---

# 5. ¿Cómo averiguar el encoding (charset) de forma automática?

Hablando con _Albérica_, el problema anterior, ella comenta la idea de buscar la forma de encontrar el `encoding`  de forma automática. Me pongo a pensar y escribo lo siguiente:

> **Leer el encoding de los ficheros y cómo cambiarlo**
>
> En ciertas ocasiones es necesario [cambiar el encoding de una archivo](http://lacapa8v2.blogspot.com/2012/07/como-saber-y-cambiar-el-charset.html#.XDvPZqHLfQo), Con el comando file y la opción mime se puede saber el charset de un archivo.
> Veamos un ejemplo:
>
>     $ file --mime test.html
>     test.html: text/plain; charset=iso-8859-1
>
> Para cambiar el charset, usaremos el comando iconv:
>
>     $ iconv --from-code=iso-8859-1 --to-code=utf-8 test.html > test_new.html

**¿Qué pasa con la salida de los comandos de un OpenSUSE en español?**

Me aseguro que tengo el sistema operativo en español:
```
> locale

LANG=es_ES.utf8
LC_CTYPE=es_ES.utf8
LC_NUMERIC="es_ES.utf8"
LC_TIME="es_ES.utf8"
LC_COLLATE="es_ES.utf8"
LC_MONETARY="es_ES.utf8"
LC_MESSAGES="es_ES.utf8"
LC_PAPER="es_ES.utf8"
LC_NAME="es_ES.utf8"
LC_ADDRESS="es_ES.utf8"
LC_TELEPHONE="es_ES.utf8"
LC_MEASUREMENT="es_ES.utf8"
LC_IDENTIFICATION="es_ES.utf8"
LC_ALL=
```
Ahora vamos a comprobar el charset de la salida de algún comando:
```
$ pwd > /tmp/pwd.tmp
$ file --mime /tmp/pwd.tmp
pwd.tmp: text/plain; charset=us-ascii
```

> Interesante... La salida de los comandos tienen charset `us-ascii`,
a pesar de que mi sistema está en español.
>
> Me pregunto ¿funcionarán todos los comandos de la misma forma? Lo lógico es pensar que sí. En dicho caso podremos asumir que todos los comandos de GNU/Linux generan la salida con enconding us-ascii.

**¿Qué pasa con los comandos de W2012 en español?**

Averiguar el encoding que está usando por el terminal:
```
$ ssh administrador@192.168.1.114 'chcp' > chcp.tmp
administrador@192.168.1.114's password:

$ more /tmp/chcp.tmp
P�gina de c�digos activa: 850

$ file --mime /tmp/chcp.tmp
/tmp/chcp.tmp: text/plain; charset=iso-8859-1
```

O sea, que según el comando tiene charser `850` y luego el resultado del comando está en `iso-8859-1`. Pero no queda claro porque hay comandos que generan la salida en una codificación y otros en otra. Veamos:

```
$ ssh administrador@192.168.1.114 'pwd' > win.tmp
administrador@192.168.1.114's password:

$ file --mime win.tmp
win.tmp: text/plain; charset=us-ascii

$ ssh administrador@192.168.1.114 'chcp' > chcp.tmp
administrador@192.168.1.114's password:

$ ssh administrador@192.168.1.114 'get-windowsfeature -name rds-rd-server' > gwf.tmp
administrador@192.168.1.114's password:

$ file --mime /tmp/gwf.tmp
/tmp/gwf.tmp: text/plain; charset=iso-8859-1
```

> Pues la salida de los comandos de W2012 son:
> * `us-ascii` algunas veces, y otras en
> * `iso-8859-1`
>
> ¿De qué depende? ¿Qué comandos usan cada encoding?
