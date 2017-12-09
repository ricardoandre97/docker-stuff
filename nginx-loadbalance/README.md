Automated Nginx load Balancer
============================


This project initializes a nginx reverse proxy service for you. It has 2 important containers:
- A nginx container which will serve as proxy
- A docker-gen container which will be watching for docker events, and will generate a new config for nginx, besides sending a sighup signal to reload the service, and apply the new config.
- An application container which will be scaled and proxied. This container may vary.

Requirements
============

- docker-ce
- docker-compose

How to create the service
========================

To create the server you just have to type ./run.sh

```
$ ./run.sh
Creating nginx ... 
Creating nginx ... done
Creating watcher ... 
Creating watcher ... done
Creating myproject_app_1 ... 
Creating myproject_app_1 ... done
##############
Scaling app...
##############
Starting myproject_app_1 ... done
Creating myproject_app_2 ... 
Creating myproject_app_3 ... 
Creating myproject_app_2 ... done
Creating myproject_app_3 ... done
```
Customizing your app
====================

You should edit the `run.sh` file, and change two things:
- `The name of your project`. I'm sure your project's name is not "myproject".
- `The number for scaling`. By default it is 3, but you can set whatever number you want.

You should of course, edit the `docker-compose.yml` file, and define:
- `Your own config`. Image, volumes, ports, and all that docker stuff.
- `The domain`. You should define your own domain, which will be the upstream for nginx. If you don't have one, just use the IP of your docker host.
- `The port where your app runs`. By default, the proxied port is `80`, but if your app listens on another one, you should change it.
- `Sticky Sessions`. If your app needs sticky session, set the var `USE_IP_HASH` to 1. Else, forget about this point. 

Checking the service
====================

If you set the domain to a fqdn, and didn't use ip_hash, your requests will go to any container, by using round robin.

```
curl http://hola.prueba.com
```
If you set your domain to your IP address, check your IP.

```
curl http://my-ip
```
If you need more info about something, you can check the nginx logs, at nginx/logs, or even watch at the docker-gen process, by typing `docker logs -f watcher`

Credits
=======

The main idea was taken from `https://hub.docker.com/r/tpcwang/nginx-proxy/`
