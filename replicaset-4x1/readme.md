# Replicaset (4 Hosts + 1 Arbiter)
4 Hosts + 1 Arbiter

## Installation
Just clone and use it

## How to use

1. Create
`./create.sh`
2. Stop
`./stop.sh`
3. Restart
`./restart.sh`
4. Clean
`./clean.sh`

### Components

If you wish, modify the content of these files to better suit your needs:

+ `./create.sh`, `./stop.sh`, `./restart.sh` and `./clean.sh`
   - Replace every occurrence of the prefix "*mongo-myproject*" to your project name

+ `./config/mongod-rs-pre.conf` and `./config/mongod-rs-pos.conf`
   - Modify your Replica Set name:

     replSetName: *rsMYPROJECT01* 

   - The [systemLog verbosity](https://docs.mongodb.com/manual/reference/configuration-options/#systemLog.verbosity):

     verbosity: *5*

+ `./00-initiate.js`
   - Change the fixed host IP to your desired IPs:

     host: "*192.168.2.103*:30001"

     host: "*192.168.2.103*:30002"

     host: "*192.168.2.103*:30003"

     host: "*192.168.2.103*:30004"

     host: "*192.168.2.103*:30005"


+ `./01-createUserAdmin.js`
   - Change User/Password

     user: "*sysop*"

     pwd: "*87654312*"


## How to connect
Use this string Connection:
mongodb://sysop:87654312@127.0.0.1:30001,127.0.0.1:30002,127.0.0.1:30003,127.0.0.1:30004/admin?replicaSet=rsMYPROJECT01

## Contributing

Contributions are always welcome! 👊

You can reach me out at Twitter [@luizhp](https://twitter.com/luizhp)
