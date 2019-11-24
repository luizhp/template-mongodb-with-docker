#!/bin/bash

echo
echo "─────────────────────────"
echo "Docker ➤ Volumes ➤ Create"
echo "─────────────────────────"

echo -ne " ➤ host: \033[0K"
docker volume create mongo-myproject-01-host-data
echo -ne " ➤ host: \033[0K"
docker volume create mongo-myproject-01-host-log
echo -ne " ➤ host: \033[0K"
docker volume create mongo-myproject-02-host-data
echo -ne " ➤ host: \033[0K"
docker volume create mongo-myproject-02-host-log
echo -ne " ➤ host: \033[0K"
docker volume create mongo-myproject-03-host-data
echo -ne " ➤ host: \033[0K"
docker volume create mongo-myproject-03-host-log
echo -ne " ➤ host: \033[0K"
docker volume create mongo-myproject-04-host-data
echo -ne " ➤ host: \033[0K"
docker volume create mongo-myproject-04-host-log
echo -ne " ➤ arbiter: \033[0K"
docker volume create mongo-myproject-05-arbiter-data
echo -ne " ➤ arbiter: \033[0K"
docker volume create mongo-myproject-05-arbiter-log
echo -ne " ➤ config: \033[0K"
docker volume create --driver local \
      --opt type=none \
      --opt device="$PWD"/config \
      --opt o=bind \
      mongo-myproject-config
echo -ne " ➤ setup: \033[0K"
docker volume create --driver local \
      --opt type=none \
      --opt device="$PWD"/setup \
      --opt o=bind \
      mongo-myproject-setup
echo

echo "─────────────────────────────────────────────────────────────"
echo "MongoDB - ReplicaSet - Deploying mongod.conf pre-installation"
echo "─────────────────────────────────────────────────────────────"
cp ./config/rs/mongod-rs-pre.conf ./config/mongod.conf --force
echo

echo "────────────────────────────────────────────────"
echo "Docker - MongoDB - Containers - Create and start"
echo "────────────────────────────────────────────────"

echo -ne " ➤ mongo-myproject-01-host: \033[0K"
docker run -p 30001:27017 \
           --name mongo-myproject-01-host \
           -v mongo-myproject-config:/etc/mongo/config \
           -v mongo-myproject-setup:/etc/mongo/setup:ro \
           -v mongo-myproject-01-host-data:/data/db \
           -v mongo-myproject-01-host-log:/var/log/mongodb \
           -d \
           mongo mongod --config /etc/mongo/config/mongod.conf

echo -ne " ➤ mongo-myproject-02-host: \033[0K"
docker run -p 30002:27017 \
           --name mongo-myproject-02-host \
           -v mongo-myproject-config:/etc/mongo/config:ro \
           -v mongo-myproject-setup:/etc/mongo/setup:ro \
           -v mongo-myproject-02-host-data:/data/db \
           -v mongo-myproject-02-host-log:/var/log/mongodb \
           -d \
           mongo mongod --config /etc/mongo/config/mongod.conf

echo -ne " ➤ mongo-myproject-03-host: \033[0K"
docker run -p 30003:27017 \
           --name mongo-myproject-03-host \
           -v mongo-myproject-config:/etc/mongo/config \
           -v mongo-myproject-setup:/etc/mongo/setup:ro \
           -v mongo-myproject-03-host-data:/data/db \
           -v mongo-myproject-03-host-log:/var/log/mongodb \
           -d \
           mongo mongod --config /etc/mongo/config/mongod.conf

echo -ne " ➤ mongo-myproject-04-host: \033[0K"
docker run -p 30004:27017 \
           --name mongo-myproject-04-host \
           -v mongo-myproject-config:/etc/mongo/config \
           -v mongo-myproject-setup:/etc/mongo/setup:ro \
           -v mongo-myproject-04-host-data:/data/db \
           -v mongo-myproject-04-host-log:/var/log/mongodb \
           -d \
           mongo mongod --config /etc/mongo/config/mongod.conf

echo -ne " ➤ mongo-myproject-05-arbiter: \033[0K"
docker run -p 30005:27017 \
           --name mongo-myproject-05-arbiter \
           -v mongo-myproject-config:/etc/mongo/config \
           -v mongo-myproject-setup:/etc/mongo/setup:ro \
           -v mongo-myproject-05-arbiter-data:/data/db \
           -v mongo-myproject-05-arbiter-log:/var/log/mongodb \
           -d \
           mongo mongod --config /etc/mongo/config/mongod.conf
echo

sleep 2

echo "──────────────────────────────────────────"
echo "Docker - MongoDB - ReplicaSet - Initialize"
echo "──────────────────────────────────────────"
docker exec -it mongo-myproject-01-host mongo localhost:27017/admin /etc/mongo/setup/00-initiate.js
echo

echo "─────────────────────────────────────────────"
echo "Docker - MongoDB - Wait for a Master Election"
echo "─────────────────────────────────────────────"
docker exec -it mongo-myproject-01-host mongo localhost:27017/admin /etc/mongo/setup/99-masterOn.js
echo

echo "─────────────────────────────────────────────────"
echo "Docker - MongoDB - ReplicaSet - Create Admin User"
echo "─────────────────────────────────────────────────"
docker exec -it mongo-myproject-01-host mongo localhost:27017/admin /etc/mongo/setup/01-createUserAdmin.js
echo

echo "─────────────────────────────────────────────────"
echo "Docker - MongoDB - ReplicaSet - Generate Key File"
echo "─────────────────────────────────────────────────"
docker exec -it mongo-myproject-01-host bash /etc/mongo/setup/02-setKeyfile.sh
echo

echo "──────────────────────────────────────────────────────────────"
echo "MongoDB - ReplicaSet - Deploying mongod.conf post-installation"
echo "──────────────────────────────────────────────────────────────"
cp ./config/rs/mongod-rs-pos.conf ./config/mongod.conf --force
echo

echo "─────────────────────────────────"
echo "MongoDB - Config Server - Restart"
echo "─────────────────────────────────"
docker container restart mongo-myproject-01-host mongo-myproject-02-host mongo-myproject-03-host mongo-myproject-04-host mongo-myproject-05-arbiter
echo

echo "───────────"
echo "Ready to go"
echo "───────────"
echo "String Connection: mongodb://sysop:87654312@127.0.0.1:30001,127.0.0.1:30002,127.0.0.1:30003,127.0.0.1:30004/admin?replicaSet=rsMYPROJECT01"
echo
