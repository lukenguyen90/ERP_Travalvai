component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';
	/**
	* Constructor
	*/
	function init(){
		// init super class
		super.init( entityName="payment" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.payment" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}

	function getPayment(){
		var usertype = userService.getUserLevel();		
		
		var result = queryToArray(QueryExecute("
			SELECT *
			FROM payment
			"));
		
		return result;
	}
	private function queryToArray(required query inQuery) {
        result = arrayNew(1);
        for(row in inQuery) {
            item = {};
            for(col in queryColumnArray(inQuery)) {
                item[col] = row[col];
            } 
            arrayAppend(result, item);
        }
        return result;
   	}

}