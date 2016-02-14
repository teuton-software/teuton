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

