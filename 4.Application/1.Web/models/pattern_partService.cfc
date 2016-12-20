component extends="cborm.models.VirtualEntityService" singleton{
	property name='patternsService'     	inject='patternsService';
	/**
	* Constructor
	*/
	function init(){

		// init super class
		super.init( entityName="pattern_part" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.pattern_part" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}

	function getPatternPartByPatternID(numeric patternID){
		var result = QueryExecute("
			SELECT pp.id_pattern_part ppid, pp.pp_description ppdescription, pp.pp_code ppcode, p.id_pattern pid
			FROM pattern_part pp
				JOiN patterns p
					ON pp.id_pattern = p.id_pattern
			WHERE pp.id_pattern = #patternID#
			");
		return queryToArray(result);
	}

	function delPatternPart(numeric patternID, string partCode){
		var result = QueryExecute("
						DELETE FROM pattern_part
   						WHERE id_pattern = #patternID# and pp_code = '#partCode#'
					");
		return "";
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