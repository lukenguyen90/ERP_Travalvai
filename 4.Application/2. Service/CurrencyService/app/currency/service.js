'use strict'
const core = require('../core');
const config = require('../../config');
const currency = require('./currency');
const rate = require('./rate');


function updateExchangeRate() {
    currency.getCurrencies().then(function(currencies) {
        var totalCurriency = currencies.length;
        if (totalCurriency > 0) {
            var strCurrencies = "";
            for (var i = 0; i < totalCurriency; i++) {
                strCurrencies += currencies[i].dataValues.curr_code + ",";
            }

            //get exchange rates
            rate.getRates(strCurrencies).then(function(rates) {

                var today = core.utils.dateTime.dateFormat(new Date(), 'yyyy-mm-dd');
                if (rates != null) {
                    for (var i = 0; i < totalCurriency; i++) {
                        var currency = currencies[i];
                        var quoteKey = config.baseCurrency + currency.dataValues.curr_code;
                        var quoteValue = rates.quotes[quoteKey];
                        if (quoteValue !== 'undefined') {
                            rate.updateRate(today, currency.dataValues.id_currency, quoteValue)
                        }
                    }

                }
            });
        }
    });
}

function autoUpdateExchangeRate() {
    try {
        var interval = 21600000;
        setInterval(function() {
            updateExchangeRate();
            console.log('update rate');
        }, interval);

    } catch (e) {
        console.log(e);
        //send email
    }

}

module.exports = {
    autoUpdateExchangeRate: autoUpdateExchangeRate
};