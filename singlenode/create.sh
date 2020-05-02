#!/bin/bash
echo "#####################################"
echo "# Starting MongoDB Docker Container #"
echo "#####################################"
echo

echo "---------------------------"
echo "docker - removing old stuff"
echo "---------------------------"
./clean.sh

echo
echo "-------------------------"
echo "docker - volumes - create"
echo "-------------------------"
docker volume create mongodb-myproject-data
docker volume create mongodb-myproject-log
docker volume create --driver local \
      --opt type=none \
      --opt device="$PWD"/config \
      --opt o=bind \
      mongodb-myproject-config

docker volume create --driver local \
      --opt type=none \
      --opt device="$PWD"/scripts \
      --opt o=bind \
      mongodb-myproject-scripts

echo
echo "----------------------------------------------"
echo "docker - mongodb - create and start containers"
echo "----------------------------------------------"
docker run -p 30001:27017 \
           --name mongodb-myproject \
           -v mongodb-myproject-config:/etc/mongo/config\
           -v mongodb-myproject-scripts:/etc/mongo/scripts \
           -v mongodb-myproject-data:/data/db \
           -v mongodb-myproject-log:/var/log/mongodb \
           -d \
           mongo mongod --config /etc/mongo/config/mongod.conf
