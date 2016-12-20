'use strict'
const Sequelize = require('sequelize');

var dataAccess = new Sequelize('travalvai', 'root', '123456', {
    host: 'localhost',
    dialect: 'mysql',

    pool: {
        max: 5,
        min: 0,
        idle: 10000
    }

});

dataAccess.createRepository = createRepository;
dataAccess.dataType = Sequelize;

/**
 * Map table ORM
 * 
 * @param {any} tableName
 * @returns
 */
function createRepository(tableName, columns) {
    var options = {
        timestamps: false,
        paranoid: true,
        underscored: true,
        freezeTableName: true,
        tableName: tableName
    };
    var columnDefine = {};

    if (typeof(columns) !== 'undefined')
        columnDefine = columns;

    return dataAccess.define(tableName, columnDefine, options);
}

module.exports = dataAccess;