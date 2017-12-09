#!/bin/bash

export GUAC_DB_USER="root"
export GUAC_DB_PASS="qpalwosk10"
export GUAC_DB_NAME="guacamole_db"
export COMPOSE_PROJECT_NAME="guacamole"
export PATH="$PATH:/usr/local/bin"

docker-compose up -d

if [ "$1" = "reset_db" ]; then
  docker cp initdb.sql guacamole-db:/tmp/initdb.sql && echo && \
  echo "Waiting for db to start..."

  while true ; do
    sleep 2 && \
    docker logs guacamole-db 2>&1 | grep 'port: 3306' > /dev/null 2>&1

      if [ "$?" -eq 0 ]; then
        echo "DB is ready" && \
        echo "Applying changes..." && \
        docker exec guacamole-db bash -c \
        'sleep 3 && mysql -u root -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /tmp/initdb.sql 2>&1 | grep -v "Using a password"'
        break
      fi

  done

fi  
