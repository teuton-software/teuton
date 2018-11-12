
# Samba activity

## Parámetros de configuración

* Tenemos un fichero de configuración de ejemplo `config.yaml.sample`.
* El fichero de configuración real debe llamarse `config.yaml`.

### Parámetros globales

|Parámetro | Descripción  |
|:-------- |:------------ |
|gateway_ip|IP de la puerta de enlace|
|client1_username| Nombre de usuario para conexión remota con el equipo client1|
|client1_protocol|Protocolo de conexión remota para el equipo client1|
|server_username| Nombre de usuario para conexión remota con el equipo server|
|server_domain| Nombre de dominio del equip server|
|share1_group| Nombre del grupo de share1|
|share1_users|Usuarios del grupo share1|
|share1_resource|Nombre del recurso|
|share1_perm|Permisos del recurso|
|share2_group| Nombre del grupo de share2|
|share2_users|Usuarios del grupo share2|
|share2_resource|Nombre del recurso|
|share2_perm|Permisos del recurso|
|share3_users|Usuarios del grupo share3|
|share3_resource|Nombre del recurso|
|share3_perm|Permisos del recurso|

### Parámetros de cada caso

|Parámetro | Descripción  |
|:-------- |:------------ |
|tt_members| Nombre del alumno|
|id        | Código de identificación|
|username  | Nombre de usuario|
|lastname  | Apellido|
|client1_password| Clave de acceso equipo clien1|
|server_ip| IP del equipo server|
|server_password| Clave de acceso equipo server|

---

## Comprobaciones que hace este test

* Puertos 139 y 445 abiertos en el equipo server.
* `smbtree` muestra los recursos compartidos:
IPC$, share1_resource, share2_resource y share3_resource.
* Los servicios smb y nmb activos en el equipo server.

* Existen en el sistema los usuarios share1_users.
* Los usuarios share1_users pertenecen al grupo share1_group.
* Los usuarios share1_users tienen clave en Samba.
* Existen en el sistema los usuarios share2_users.
* Los usuarios share2_users pertenecen al grupo share2_group.
* Los usuarios share2_users tienen clave en Samba.

* Existen los directorios /srv/sambaID, /srv/sambaID/share1_resource.d, /srv/sambaID/share2_resource.d y
/srv/sambaID/share3_resource.d, con los permisos que les corresponden.
* Los recursos share1, share2 y share3 están correctamente definidos en smb.conf.
