component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';

	/**
	* Constructor
	*/
	function init(){

		// init super class
		super.init( entityName="currency_convert" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.currency_convert" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}

	// CC is a abbriation of Currency convert

	public function getLatest_Cc(any idcurrency) {
		var cc =  QueryExecute("select id_curr_conv,cc_value,cc_date,currency.id_currency,currency.curr_code 
								from currency_convert 
								inner join currency on currency_convert.id_currency = currency.id_currency 
								where cc_date <= CURDATE() and currency_convert.id_currency = #idcurrency# 
								order by cc_date desc limit 1");
		return cc;
	}

	public function getCC_byDate(any id_currency, any compare_date) {
		var cc =  QueryExecute("select id_curr_conv,cc_value,cc_date,currency.id_currency,currency.curr_code 
								from currency_convert 
									inner join currency 
										on currency_convert.id_currency = currency.id_currency 
								where cc_date <= Date('#compare_date#') and currency_convert.id_currency = #id_currency# 
								order by cc_date desc limit 1");
		return cc;
	}




}