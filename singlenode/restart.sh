#!/bin/bash
echo
echo "##################################"
echo "# Stop MongoDB Docker Containers #"
echo "##################################"

docker container restart mongodb-acme \
echo 30s...
sleep 10
echo 20s...
sleep 10
echo 10s...
sleep 10

echo
echo "##################################"
echo "# Show MongoDB Docker Containers #"
echo "##################################"
docker container ls -a
