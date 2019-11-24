#!/bin/bash

cd /etc/mongo/config
openssl rand -base64 756 > mongodb-keyfile
chmod 400 mongodb-keyfile
chown mongodb:mongodb mongodb-keyfile
