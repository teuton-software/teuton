```
Test unit name : learn-03-remote-hosts
Date           : 2020-04-11 20:11:25 +0100
Teuton version : 2.1.9
```

# learn-03-remote-hosts

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

## How to test remote windows hosts


Go to [HOST1](#required-hosts) host, and do next:
* Update hostname with [host1_hostname](#required-params).
* Ensure network DNS configuration is working.
* Create user [username](#required-params).
