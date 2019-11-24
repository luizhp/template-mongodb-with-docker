#!/bin/bash

echo "---------------------------"
echo "docker - removing old stuff"
echo "---------------------------"
docker container prune --force && docker volume prune --force && docker network prune --force

docker container stop mongo-myproject-05-arbiter mongo-myproject-04-host mongo-myproject-03-host mongo-myproject-02-host mongo-myproject-01-host
docker container kill mongo-myproject-01-host mongo-myproject-02-host mongo-myproject-03-host mongo-myproject-04-host mongo-myproject-05-arbiter
docker volume rm mongo-myproject-config mongo-myproject-setup

docker container prune --force && docker volume prune --force && docker network prune --force

docker volume rm mongo-myproject-01-host-data mongo-myproject-01-host-log mongo-myproject-02-host-data mongo-myproject-02-host-log mongo-myproject-03-host-data mongo-myproject-03-host-log mongo-myproject-04-host-data mongo-myproject-04-host-log mongo-myproject-05-arbiter-data mongo-myproject-05-arbiter-log
