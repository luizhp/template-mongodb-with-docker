# Replicaset (Singlenode)
Singlenode

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
   - Replace every occurrence of the prefix "*mongodb-myproject*" to your project name

+ `./config/mongod.conf`
   - The [systemLog verbosity](https://docs.mongodb.com/manual/reference/configuration-options/#systemLog.verbosity):

     verbosity: *0*

## How to connect
Use this string Connection:
mongodb://127.0.0.1:30001

## Contributing

Contributions are always welcome! 👊

You can reach me out at Twitter [@luizhp](https://twitter.com/luizhp)
