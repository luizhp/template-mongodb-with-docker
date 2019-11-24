#!/bin/bash

echo
echo "──────────────────────────────"
echo "Stop MongoDB Docker Containers"
echo "──────────────────────────────"

docker container stop mongo-myproject-02-host \
                 mongo-myproject-03-host \
                 mongo-myproject-04-host \
                 mongo-myproject-01-host \
                 mongo-myproject-05-arbiter

echo
echo "──────────────────────────────"
echo "Show MongoDB Docker Containers"
echo "──────────────────────────────"
docker container ls -a
