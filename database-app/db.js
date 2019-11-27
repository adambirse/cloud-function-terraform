const mysql = require('promise-mysql');

let pool;

function getConfig() {

    const socketPath = `/cloudsql/${process.env.CLOUD_SQL_CONNECTION_NAME}`;
    console.log(socketPath);
    console.log(process.env.DB_HOST);
    console.log(process.env.DB_PASS);
    console.log(process.env.DB_USER);
    console.log(process.env.DB_NAME);

    if (process.env.NODE_ENV === "production") {
        return {
            user: process.env.DB_USER || 'test',
            password: process.env.DB_PASS || 'test',
            database: process.env.DB_NAME || 'cloud-functions',
            // host: process.env.DB_HOST,
            socketPath: socketPath,
            connectionLimit: 5,
            connectTimeout: 10000, // 10 seconds
            acquireTimeout: 10000, // 10 seconds
            waitForConnections: true, // Default: true
            queueLimit: 0, // Default: 0
        };
    } else {
        return {
            user: process.env.DB_USER || 'root',
            password: process.env.DB_PASS || 'password',
            database: process.env.DB_NAME || 'cloud-functions',
            host: process.env.DB_HOST || 'localhost',
            port: process.env.DB_PORT || 3310,
            connectionLimit: 5,
            connectTimeout: 10000, // 10 seconds
            acquireTimeout: 10000, // 10 seconds
            waitForConnections: true, // Default: true
            queueLimit: 0, // Default: 0
        };
    }
}

const createPool = async () => {


    pool = await mysql.createPool(getConfig());
};

const ensureSchema = async () => {

    query(`CREATE TABLE IF NOT EXISTS person
      ( id int NOT NULL AUTO_INCREMENT, name VARCHAR(255) NOT NULL, email VARCHAR(255) NOT NULL, PRIMARY KEY (id) );`);
};

const query = async (stmt) => {
    return await pool.query(stmt);
};

module.exports = {createPool, ensureSchema, query};
