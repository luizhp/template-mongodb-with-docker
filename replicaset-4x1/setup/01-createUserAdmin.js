var counter = 0;

while (++counter <= 100) {

    print('isMaster?', db.isMaster().ismaster);

    if (db.isMaster().ismaster) {
        db.createUser({
            user: "sysop",
            pwd: "87654312",
            roles: [{
                role: "root",
                db: "admin"
            }]
        });
        break;
    }

    sleep(1000);

}