component extends="cborm.models.VirtualEntityService" singleton{
	/**
	* Constructor
	*/
	function init(){

		// init super class
		super.init( entityName="price_list_zone" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.price_list_zone" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}

	function delFK_plzd(idplz){
		QueryExecute("
						DELETE FROM price_list_zone_details
   						WHERE id_plz = #idplz#
					");
		return "";
	}

}