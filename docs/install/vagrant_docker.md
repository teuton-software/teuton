[<< back](README.md)

# Vagrant and Docker installation

1. Vagrant
2. Docker

---
# 1. Install using Vagrant

* First, install `Vagrant` and `VirtualBox` on your host.
* Create directory for vagrant project. For example, `mkdir teuton-vagrant`.
* Move into that directory: `cd teuton-vagrant`.
* Choose and download [Vagrantfile](../../install/vagrant).
* Run `vagrant up` to create your Virtual Machine.

# 2. Install using Docker

First:
* Install `docker` on your host.

Second, choose:
* Pulling docker image from remote or
* Rebuild local docker image.

## 2.1 Pulling docker images from remote

Run this command to pull **dvarrui/teuton** image from Docker Hub and create teuton container:

`docker run --name teuton -v /home/teuton -i -t dvarrui/teuton /bin/bash`

## 2.2 Rebuild local docker image

1. Create Dockerfile like this:

```
FROM debian:latest

MAINTAINER teuton 2.1

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y vim tree
RUN apt-get install -y ruby
RUN gem install teuton
RUN mkdir /home/teuton

EXPOSE 80

WORKDIR /home/teuton
CMD ["/bin/bash"]
```
1. Build local docker image **dvarrui/teuton** with `docker build -t dvarrui/teuton .`
1. Create **teuton** container with `docker run --name teuton -v /home/teuton -i -t dvarrui/teuton /bin/bash`.

> Notice `/home/teuton` folder is persistent volume.
