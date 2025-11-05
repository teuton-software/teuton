[<< back](../../README.md)

# Installation

**Teuton installation**

We call a device with Teuton installed as t-node. [T-NODE](t-node.md) host monitors one or severals S-NODE hosts.
1. Install Ruby on your system.
2. `gem install teuton`

**SSH server installation**

We call e device with SSH/Telnet service as s-node. [S-NODE](s-node.md) hosts are monitorized by T-NODE host.
1. Install SSH service.

Read [modes of use](modes_of_use.md) to know more about differents T-NODE/S-NODE schemes.

## Tested OS list

| Type      | O.S.      | Version        | Arch   | T-node | S-node |
| --------- | --------- | -------------- | ------ | ------ | ------ |
| GNU/Linux | CentOS    | 7              | x86-64 |        |        |
|           | Debian    | 9.7.0          | x86-64 | Ok     |        |
|           | Fedora    | Workstation 29 | x84-64 | Ok     |        |
|           | LinuxMint | 18.3           | x86-64 | Ok     |        |
|           | openSUSE  | Leap 15        | x86-64 | Ok     | Ok     |
|           | openSUSE  | Tumbleweed     | x86-64 | Ok     | Ok     |
|           | Ubuntu    | 18.04          | x86-64 | Ok     | Ok     |
| Microsoft | Windows   | 7 Enterprise   | x86    | Ok     |        |
|           | Windows   | 10 Pro         | x86-64 | Ok     | Ok     |
|           | Windows   | Server 2012 R2 | x86-64 |        |        |
| Apple     | Mac OS X  | Capitán (10.11.6) | x86-64 | Ok  | Ok     |
|           | Mac OS X  | Sierra (10.12)    | x86-64 | Ok  |        |
