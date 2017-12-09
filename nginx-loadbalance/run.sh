#!/bin/bash

DOCKER_COMPOSE=$(whereis docker-compose | awk '{print $NF}')
ACTION="$1"
ARGS="$2"

if [ -z "$ACTION" ]; then
  ACTION="up -d"
  export ACTION
fi

export COMPOSE_PROJECT_NAME="myproject"

$DOCKER_COMPOSE $ACTION $ARGS && \
echo "##############" && \
echo  Scaling app...  && \
echo "##############" && \
$DOCKER_COMPOSE scale app=3
