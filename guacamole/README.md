Docker Guacamole 
================


This project initializes a guacamole service for you. It has 4 containers:
- A guacamole db using mysql
- A guacamole daemon
- A guacamole web service
- A proxy server for simplicity, and avoid typing URIs.

Requirements
============

- docker-ce
- docker-compose

How to create the service
=========================

To create the server you just have to type docker-compose up -d

```
$ docker-compose up -d

Creating guacamole-db ... done
Creating guacamole-daemon ... done
Creating guacamole-web ... done
Creating guacamole-proxy ... done
Creating guacamole-daemon ... 
Creating guacamole-web ... 
Creating guacamole-proxy ... 
```

Destroying the service
======================

```
$ docker-compose down
Stopping guacamole-proxy  ... done
Stopping guacamole-web    ... done
Stopping guacamole-daemon ... done
Stopping guacamole-db     ... done
Removing guacamole-proxy  ... done
Removing guacamole-web    ... done
Removing guacamole-daemon ... done
Removing guacamole-db     ... done
Removing network guacamole_net
```

Checking the service
====================

After you are done, hit `http://localhost` and see the magic.

The default user and password for web login is `guacadmin`

Happy Guacamoling!
