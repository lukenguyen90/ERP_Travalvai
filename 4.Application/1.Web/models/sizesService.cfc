component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';
	/**
	* Constructor
	*/
	function init(){
		// init super class
		super.init( entityName="sizes" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.sizes" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}

	function getSizes(){
		var usertype = userService.getUserLevel();		
		if(usertype != 4){
			var result = queryToArray(QueryExecute("
				SELECT *
				FROM sizes
				"));
		}else{
			var result = [];
		}
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