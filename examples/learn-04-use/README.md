```
Test unit name : learn-04-use
Date           : 2020-04-11 20:14:07 +0100
Teuton version : 2.1.9
```

# learn-04-use

### Required hosts

| ID | Host | Configuration |
| -- | ---- | ------------- |
|1|HOST1|username=root, password=profesor|

> NOTE: SSH Service installation is required on every host.

### Required params
* host1_hostname
* host1_ip
* username

> NOTE:
> * Teuton software must known this information!
> * Save every ':param: value' into config file.

## Use file: user configuration


Go to [HOST1](#required-hosts) host, and do next:
* Create user [username](#required-params).

## Use file: network configuracion


Go to [HOST1](#required-hosts) host, and do next:
* Update computer name with [host1_hostname](#required-params).
* Ensure DNS Server is working.
