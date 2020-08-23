
******************** [DEBUG] count=0 ********************
*********************************************************

******************** [DEBUG] count=0 ********************
*********************************************************
```
Test unit name : learn-05-debug
Date           : 2020-04-11 20:17:01 +0100
Teuton version : 2.1.9
```

# learn-05-debug

### Required hosts

| ID | Host | Configuration |
| -- | ---- | ------------- |
|1|WINDOWS1|username=sysadmingame|

> NOTE: SSH Service installation is required on every host.

### Required params
* windows1_hostname
* windows1_ip
* windows1_password

> NOTE:
> * Teuton software must known this information!
> * Save every ':param: value' into config file.

## Windows: external configuration


Go to [LOCALHOST](#required-hosts) host, and do next:
* Localhost: Verify connectivity with [windows1_ip](#required-params).
* Localhost: netbios-ssn service working on [windows1_ip](#required-params).

## Windows: internal configurations


Go to [WINDOWS1](#required-hosts) host, and do next:
* Ensure Windows version is 6.1.
* Ensure Windows COMPUTERNAME is [windows1_hostname](#required-params).
* Configure gateway with [192.168.1.1](#global-params).
* Ensure gateway is working.
* Ensure DNS is working.

---
# ANEXO

## Global params

Global parameters that can be modified:

| Global param | Value |
| ------------ | ----- |
|gateway|192.168.1.1|
|dns|8.8.4.4|

## Created params

Params created during challenge execution:

| Created params | Value |
| -------------- | ----- |
