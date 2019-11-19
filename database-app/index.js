'use strict';

const express = require('express');
const bodyParser = require('body-parser');

const {createPool, ensureSchema, query} = require('./db');

const app = express();

app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

app.use((req, res, next) => {
    res.set('Content-Type', 'text/html');
    next();
});

createPool().then(() => {
    ensureSchema()
});

app.get('/', async (req, res) => {

    try {

        const data = await query('SELECT * FROM person');

        const people = {
            person: []
        };

        data.map(item => {
            people.person.push({
                name: item.name,
                email: item.email
            });
        });
        await res.json({
            people: people
        });

    } catch (e) {
        console.log(e);
        res.send(e);
    }
});

app.post('/', async (req, res) => {

    try {
        const person = req.body.person;
        const rows = await query(`INSERT INTO person (name, email) VALUES("${person.name}", "${person.email}");`);
        res.send(`Successfully saved ${person.name}`);
    } catch (e) {
        console.log(e);
        res.send(e);
    }
});

const PORT = process.env.PORT || 8080;
const server = app.listen(PORT, () => {
    console.log(`App listening on port ${PORT}`);
});

module.exports = {app};



