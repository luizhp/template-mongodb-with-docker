#!/bin/bash
echo
echo "##################################"
echo "# Kill MongoDB Docker Containers #"
echo "##################################"

docker container stop mongodb-acme
docker container kill mongodb-acme
docker volume rm mongodb-acme-data mongodb-acme-log mongodb-acme-config mongodb-acme-scripts
docker container prune --force && docker volume prune --force && docker network prune --force

echo
echo "##################################"
echo "# Show MongoDB Docker Containers #"
echo "##################################"
docker container ls -a
