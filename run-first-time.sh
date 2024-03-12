#!/bin/bash

# INSTALL PACKAGE
composer install
# npm install


# GET FOLDER NAME
result=$(basename "${PWD}" | tr '[:upper:]' '[:lower:]')

# HANDLE IF FOLDER NAME EMPTY
result=${result:-default_name}

# BUILDING DOCKER IMAGE
docker build -t "$result" .

# RUN DOCKER
docker run --name "$result" -d -v "${PWD}":/var/www/html/ --volume /var/www/html/node_modules -p 8000:80 -p 3000:3000 "$result"

# SET PERMISSION DOCKER
docker exec "$result" chmod -R 777 /var/www/html/

# Executing a shell inside the running container
docker exec -it "$result" /bin/bash
