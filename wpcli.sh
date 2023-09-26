#!/bin/bash
# Script to run wp cli as a docker container.
###############################################
# Define DB Variables
DB_USER=
DB_PASSWORD=
DB_NAME=
# Define the Network used by Docker Compose
# docker network ls
DOCKER_NETWORK=
# Define the full name of the Docker container
# docker container ls
WP_CONTAINER=
###############################################
DB_HOST=db
WP_COMMAND=$@

if [ -z "$1" ]; then
	echo Usage: `basename $0` WP_COMMAND
	echo Example: `basename $0` user list
	exit 1
fi

# Docker run it
docker run -it --rm \
	--volumes-from $WP_CONTAINER \
	--network $DOCKER_NETWORK \
	-e WORDPRESS_DB_HOST=$DB_HOST \
	-e WORDPRESS_DB_USER=$DB_USER \
	-e WORDPRESS_DB_PASSWORD=${DB_PASSWORD} \
	-e WORDPRESS_DB_NAME=$DB_NAME \
	wordpress:cli ${WP_COMMAND}