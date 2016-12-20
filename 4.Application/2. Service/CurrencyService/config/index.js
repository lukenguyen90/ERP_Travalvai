const config = {}

config.baseCurrency = "USD";
config.api = {
    exchangeRate: {
        url: 'http://apilayer.net/api/live?access_key=7585068f29f404d04ef41bd750bc44fe&currencies=%s&format=1'
    }
}

module.exports = config