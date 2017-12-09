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
========================

To create the server you just have to type ./run.sh reset_db

```
$ ./run.sh reset_db

guacamole-db is up-to-date
guacamole-daemon is up-to-date
guacamole-web is up-to-date
guacamole-proxy is up-to-date

Waiting for db to start...
DB is ready
Applying changes...
```
Notes
-----

The `reset_db` argument should be passed to create a clean database (Any existing database will be deleted), like when you create your service for the first time. 
If you then add some users, or shells on your config, make sure to backup your database regularly.

You can just type `./run.sh` to start your stopped containers.

Checking the service
====================

After you are done, hit `http://localhost` and see the magic.

The default user and password for web login is `guacadmin`

Happy Guacamoling!
