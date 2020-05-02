#!/bin/bash
echo
echo "##################################"
echo "# Stop MongoDB Docker Containers #"
echo "##################################"

docker container stop mongodb-acme

echo
echo "##################################"
echo "# Show MongoDB Docker Containers #"
echo "##################################"
docker container ls -a
