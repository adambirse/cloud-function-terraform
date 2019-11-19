const mysql = require('promise-mysql');

let pool;

const createPool = async () => {

    const socketPath = `/cloudsql/${process.env.CLOUD_SQL_CONNECTION_NAME}`;
    console.log(socketPath);
    console.log(process.env.DB_HOST);
    console.log(process.env.DB_PASS);
    console.log(process.env.DB_USER);
    console.log(process.env.DB_NAME);

    pool = await mysql.createPool({
        user: process.env.DB_USER,
        password: process.env.DB_PASS,
        database: process.env.DB_NAME,
        // host: process.env.DB_HOST, //use for serverless vpn connections (TODO)
        // If connecting via unix domain socket, specify the path
        socketPath: socketPath,
        connectionLimit: 5,
        connectTimeout: 10000, // 10 seconds
        acquireTimeout: 10000, // 10 seconds
        waitForConnections: true, // Default: true
        queueLimit: 0, // Default: 0
    });
};

const ensureSchema = async () => {

    query(`CREATE TABLE IF NOT EXISTS person
      ( id int NOT NULL AUTO_INCREMENT, name VARCHAR(255) NOT NULL, email VARCHAR(255) NOT NULL, PRIMARY KEY (id) );`);
};

const query = async (stmt) => {
    return await pool.query(stmt);
};

module.exports = {createPool, ensureSchema, query};
