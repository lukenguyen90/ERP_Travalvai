'use strict'
const config = require('../../config');
const dataAccess = require("../DataAccess");
const util = require('util');
const request = require('request');

const rateRepository = dataAccess.createRepository('currency_convert', mapColumn());

function updateRate(date, currencyId, rateValue) {
    var exRate = {
        id_currency: currencyId,
        cc_date: date,
        cc_value: rateValue,
        id_user_created: 1,
        id_user_updated: 1
    };




    rateRepository.findOne({
        where: { id_currency: exRate.id_currency, cc_date: exRate.cc_date }
    }).then(function(result) {
        if (result === null) {
            rateRepository.create(exRate).then(function(result) {
                console.log(result);
            });
        }
    })
};

function getRates(currencies) {
    /*setInterval(function() {
        console.log('second passed');
    }, 1000);*/
    console.log(currencies);
    return new Promise(function(resolve, reject) {
        var api = config.api.exchangeRate.url;
        api = util.format(api, currencies)
        request(api, function(error, response, body) {
            if (!error && response.statusCode == 200) {
                var currencyList = JSON.parse(body);
                //console.log(currencyList.quotes) //
                resolve(currencyList);
            } else {
                //TODO:send email
                resolve(null);
            }
        })
    });

}

function mapColumn() {
    var columnsDef = {
        id_curr_conv: {
            type: dataAccess.dataType.INTEGER,
            primaryKey: true

        },
        id_currency: dataAccess.dataType.INTEGER,
        cc_date: dataAccess.dataType.DATEONLY,
        cc_value: dataAccess.dataType.DOUBLE,
        id_user_created: dataAccess.dataType.INTEGER,
        id_user_updated: dataAccess.dataType.INTEGER
    };

    return columnsDef;
}

module.exports = {
    updateRate: updateRate,
    getRates: getRates
};