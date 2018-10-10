
# 03 - Encoding

---

# Introducción

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

# Problema

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

# Solución

La solución que se propone es poner la siguiente instrucción en esos casos:

`goto :win1, :exec => "get-windowsfeature -name rds-rd-server", :encoding => "ISO-8859-1"`

Esto es, para las salidas de los comandos que requieran conversión de tipo, se debe
especificar con `:encoding` el tipo de codificación que se recibirá. Luego ésta se convierte
internamente a 'UTF-8' y a partir de ahí todo funcionará correctamente.

---

# Comentarios

Entiendo que es una molestia indicar la codificación en algunos comandos/servidores especiales.
Pero por ahora no se puede asumir que siempre se recibirán los caracteres con la misma codificación.
