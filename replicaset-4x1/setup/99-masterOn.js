//https://docs.mongodb.com/manual/reference/command/replSetGetStatus/#replSetGetStatus.members
//https://docs.mongodb.com/manual/reference/replica-states/

var counter = (2 * 60);

//All Members Up ?
print ('Waiting for all members up');

while (counter-- >= 0) {

    var allMembersUp = true;

    for (m of rs.status().members) {

        print(m.name + ' - ' + m.health + ' - ' + m.state);
        if (!(m.health === 1 && (m.state === 1 || m.state === 2 || m.state === 7))) {
            allMembersUp = false;
            break;
        }

    }

    if (allMembersUp) {
        print('Members Up');
        break;
    }

    sleep(1000);

}

//Has a Master been elected?
print ('Waiting for a master');

while (counter-- >= 0) {

    var isMasterElected = false;

    for (m of rs.status().members) {

        if (m.state === 1) {
            isMasterElected = true;
            break;
        }

    }

    if (isMasterElected) {
        print('Master Elected');
        break;
    }

    sleep(1000);

}
