'use strict'
const dataAccess = require("../DataAccess");
const currencyRepository = dataAccess.createRepository("currency");
//Private function
//Define datatable

//Public function
function getCurrencies() {
    return currencyRepository.all({
        attributes: ['id_currency', 'curr_code']
    });
};


module.exports = {
    getCurrencies: getCurrencies
};