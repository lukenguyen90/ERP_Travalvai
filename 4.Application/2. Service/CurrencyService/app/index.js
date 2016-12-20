'use'
const cookieSession = require('cookie-session')  
const express = require('express');
const helmet = require('helmet')
const app = express();

app.use(helmet())

app.use(cookieSession({
    name: 'session',
    keys: [
        process.env.COOKIE_KEY1,
        process.env.COOKIE_KEY2
    ]
}))

app.use(function(req, res, next) {
    var n = req.session.views || 0
    req.session.views = n++
        res.end(n + ' views')
})

app.currency = require('./currency');

module.exports = app;