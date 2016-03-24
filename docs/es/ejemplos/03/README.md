

##example-03

```
* En este ejemplo, vamos necesitar varias máquinas: 
    (a) la del profesor y 
    (b) varias de estudiantes para ser evaluadas.
* La máquina del profesor tiene el script que evalua el grado de cumplimiento 
  de los objetivos de las diferentes máquinas de los estudiantes.    
* Usaremos el fichero de configuración para definir las diferentes máquinas remotas.   
* Usaremos SSH como vía de comunicación entre las máquinas.
```

* Script: [example-03.rb](../../../examples/example-03.rb) 
* Fichero de configuración: [example-03.yaml](../../../examples/example-03.yaml)
* Descripción: Evalua varios casos entrando en *máquinas remotas*.
* Requisitos: En este ejemplo se ejecutan comandos de GNU/Linux en las *máquinas remotas*.
*localhost* puede ser cualquier otro sistema operativo.

##Script

En este ejemplo, debemos fijarnos que las instrucciones `goto` no se ejecuta en localhost,
porque se ha especificado `goto :host1, ...`. De modo, que se ejecutarán dentro
la máquina `host1` (Ya veremos quien es).

Supondremos que en nuestro ejemplo cada alumno/grupo tendrá una máquina que llamaremos
por ejemplo `host1`. Podemos usar el nombre que queramos para nombrar las máquinas.

Para podernos conectar con las máquinas remotas, éstas deben tener instalado el servicio SSH.
Además la máquina donde ejecutamos el script debe tener instalado el cliente SSH.

##Fichero de configuración

En este ejemplo, el fichero de configuración contiene una variable global
`:host1_username` con el valor `root`. Esto quiere decir que en todos los casos
cuando se establezca la conexión SSH desde el equipo del profesor al `host1` del alumno,
se usará como usuario de la conexión el valor `root` en todos los casos. Esto no siempre
tiene que ser así, pero ahora en nuestro ejemplo nos vale.

Además el fichero de configuración tiene definidos más parámetros en cada caso.
Estos son:
* `host1_ip`: define la IP de host1 par ese caso. Lógicamente cada máquina de cada caso
deberá tener una iP diferente para poder conectarnos correctamente
* `host1_password`: cada caso tiene definida una clave deferente en cada máquina para
el usuario que usaremos en la conexión SSH (En nuetro caso dijimos que sería `root`).
Todos las máquinas podrían tener la misma clave para el usuario `root` pero... no.
Eso no está bien.
* `host1_hostname`: Es el FQDN del equipo host1 en cada caso. Cada caso tendrá
una personalización de la máquina `host1` diferente.
* `username`: Será el nombre de un usuario que cada alumno/grupo debe tener
creado dentro de su `host1`.

Recordar que la etiqueta host1 identifica a diferentes máquinas
según se define en el fichero de configuración para cada caso.

En el ejemplo anterior (`example-01`) vimos que tenía el objetivo de
comprobar la existencia de un usuario concreto. Si queremos comprobar 
un nombre de usuario diferente, tendríamos que modificar el script de 
evaluación... Pero ¿y si sacamos los parámetros que pueden cambiar 
de la prueba, a un fichero de configuración externo? ¿Mejor? ¿verdad?

En este ejemplo vamos a poner los nombres de usuarios a comprobar (objetivos)
en el fichero de configuración, y para leer dichos valores desde el script usaremos
la instrucción *get*.

##Fichero de configuración

Vemos que en el script hay una nueva intrucción:
* **get**: Lee el valor del parámetro indicado, del contenido del fichero 
de configuración. Para cada caso podrá ser diferente. Las acciones de 
comprobación toman el valor configurado para cada caso del fichero 
de configuración, y de esta forma cada caso se evalúa con diferentes valores.
* *get* intenta primero leer el valor solicitado en la configuración del caso,
y si no lo encuentra lo intenta leer de la configuración global. De esta forma
podemos tenemos parámetros específicos para cada caso, o comunes para todos
ellos.

En este ejemplo no tenemos definidas variables globales de configuración.
Para cada caso se definen los parámetros `tt_members` y `username`.
* **username**: Este parámetro tiene diferente valor para cada caso, de modo
que cuando se ejecuta la accción de comprobación, ésta será diferente en cada
caso.
* Consulta el fichero de configuración de este ejemplo.

##Ejecución del script
Ejecutamos el script con `./docs/examples/example-03.rb` y vemos la siguiente 
[salida por pantalla](./resume.txt).

Lo más significativo es ver en TARGETS HISTORY el resumen de todos los casos analizados
con su evaluación final. En este ejemplo, tenemos los siguientes 3 casos con distinta
puntuación final.

##Informes de salida

Para tener más información sobre cada caso, y averiguar lo que ha pasado
con cada uno para obtener las puntuaciones finales, debemos consultar 
los informes. Los informes se graban en `var/example-03/out`.

```
var/example-03/out/
├── case-01.txt
├── case-02.txt
├── case-03.txt
└── resume.txt
```

###Informe de salida para `case-01`

Veamos el [informe del caso 01](./case-01.txt), consultando el fichero `var/example-03/out/case-01.txt`.

En este caso, se ha establecido una conexión con la máquina remota (SSH),
pero sólo se ha cumplido satisfactoriamente 1 de los 3 objetivos previstos.

 
###Informe de salida para `case-02`

Veamos el [informe del caso 02](./case-02.txt), consultando el fichero `var/example-03/out/case-02.txt`.

Se han intentadon evaluar los objetivos, y todos sin éxito, puesto que el valor
esperado no coincide con el valor obtenido.

Si nos fijamos veremos en la sección *TARGETS HISTORY* una línea de ERROR.
Esta línea con el mensaje nos dice que no ha sido posible establecer 
una conexión SSH con dicha IP. En nuestro ejemplo, la máquina estaba apagada.

Cuando no hay conexión, no se puede consultar el estado de los objetivos 
y por tanto la nota final será 0%.

Algunos de los motivos por los que puede no funcionar la conexión SSH a las máquinas remotas:
* La máquina remota está apagada.
* La máquina remota tiene mal configurada la red.
* La máquina remota no tiene instalado el servicio SSH.
* La máquina remota no tiene configurado el acceso SSH para nuestro usuario.
* El cortafuegos de la máquina remota y/o la máquina del profesor cortan las comunicaciones SSH.

###Informe de salida para `case-03`

Veamos el [informe del caso 03](./case-03.txt), consultando el fichero `var/example-03/out/case-03.txt`.

En esta caso, podemos comprobar que todos los objetivos se han cumplido correctamente.

##Recordatorio

Si tenemos bien configurada la conexión SSH desde el profesor a las máquinas clientes la 
evaluación podrá realizarse adecuadamente.

Podemos tener tantos casos como queramos. El hecho de tener más alumnos/grupos que evaluar
no aumenta el tiempo de evaluación puesto que las evaluaciones de todos los casos se hacen
en paralelo usando técnicas de programación multihilo.

Como la evaluación termina al evaluar todos los casos en paralelo, puede pasar que el proceso
se demore más de la cuenta al tener que esperar las máquinas rápidas por alguna que
sea más lenta.

En nuestro ejemplo cada alumno/grupo hacía uso de una máquina para realizar su trabajo.
Pero podemos realizar actividades más complejas donde cada alumno/grupo tiene una o varias
máquinas diferentes. Lo único a tener en cuenta es que hay que darles nombres y especificar
su configutración de IP, usuario, y clave en el fichero de configuración.
