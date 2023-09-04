#!/bin/bash
# Script to run wp cli as a docker container.

# Define Variables
DB_HOST=db
DB_USER=
DB_PASSWORD=
DB_NAME=
DOCKER_NETWORK=
WP_CONTAINER=
WP_COMMAND="user list"

# Docker run it
docker run -it --rm \
	--volumes-from $WP_CONTAINER \
	--network $DOCKER_NETWORK \
	-e WORDPRESS_DB_HOST=$DB_HOST \
	-e WORDPRESS_DB_USER=$DB_USER \
	-e WORDPRESS_DB_PASSWORD=${DB_PASSWORD} \
	-e WORDPRESS_DB_NAME=$DB_NAME \
	wordpress:cli ${WP_COMMAND}