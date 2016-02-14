
#Ejemplos

* [example-01](example-01.md): Comprueba si existe el usuario *obiwan* en la máquina *localhost*.


|Script   | Fichero de configuración | Descripción |
|-------- | ----------- |------------ |
|[example-02.rb](../examples/example-02.rb) | [example-02.yaml](../examples/example-02.yaml) | Test if exist username for every case into localhost |
|[example-03.rb](../examples/example-03.rb) | [example-03.yaml](../examples/example-03.yaml) | Test several targets for every case into diferents hosts |


##example-02
Test if exist specific username for every case into localhost:  

* **get**: Get the value for every case from the configuration YAML file. This
action takes the value configured for every case from the config file. So, we
could had diferents values for every diferent case.

In this example we do not have global parameters and for every case we have
the next params: tt_members, tt_emails and username.
* **username**: this param has diferent value for every case so when we execute
every check this actions gets the value associated to every case.

##example-03
Test several targets for every case into diferent hosts.

In this example we notice that the `goto` action is not executed into localhost,
because it is specified `goto :host1, ...`. So it will be executed into :host1.

The config file for this example has one global parameter `host1_username = root`.
This indicates that every case will use de value  `root` when reference the
username value into the host called `host1`.

Besides the config file has others parameters for every case.
* `host1_ip`: set the IP for host1.
* `host1_password`: set the password to login into host1.
* `host1_hostname`: set the FQDN for host1.
* `username`: set the name of the user that must be created into host1.

Notice that host1 it is diferent machine depending every case. So we can define
diferents machines for every student. But in our activity script,we call it with the
same name (host1).

