#!/bin/bash

echo
echo "─────────────────────────────────"
echo "Restart MongoDB Docker Containers"
echo "─────────────────────────────────"

docker container restart \
                 mongo-myproject-05-arbiter \
                 mongo-myproject-02-host \
                 mongo-myproject-03-host \
                 mongo-myproject-04-host \
                 mongo-myproject-01-host
secs=$((30))
while [ $secs -gt 0 ]; do
   echo -ne "  ${secs}s...\033[0K\r"
   sleep 1
   : $((secs--))
done

echo
echo "──────────────────────────────"
echo "Show MongoDB Docker Containers"
echo "──────────────────────────────"
docker container ls -a
