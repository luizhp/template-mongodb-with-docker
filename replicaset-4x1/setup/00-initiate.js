rs.initiate({
    _id: "rsMYPROJECT01",
    members: [{
        _id: 0,
        host: "192.168.2.103:30001"
    },
    {
        _id: 1,
        host: "192.168.2.103:30002"
    }, {
        _id: 2,
        host: "192.168.2.103:30003"
    }, {
        _id: 3,
        host: "192.168.2.103:30004"
    }, {
        _id: 4,
        host: "192.168.2.103:30005",
        arbiterOnly: true
    }
    ]
}, {
    force: true
});