module.exports = {
    debug: false,
    enableCluster: true, // enable cluster mode
    bindingHost: '0.0.0.0',
    logdir: "/var/log/cnpmjs",
    mysqlServers: [
      {
        host: 'mysql',
        port: 3306,
        user: 'genee',
        password: '83719730',
      }
    ],
    mysqlDatabase: 'cnpmjs',
    redis: {
      host: 'redis',
      port: 6379,
    },
    nfs: null, //use your own CND here
    enablePrivate: true, // enable private mode, only admin can publish, other use just can sync package from source npm
    admins: {
      admin: 'ep@geneegroup.com',
    },
    syncModel: 'exist'
  };
