component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';
	property name='patternsService'     	inject='patternsService';
	/**
	* Constructor
	*/
	function init(){
		// init super class
		super.init( entityName="pattern_variantions" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.pattern_variantions" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}

	function delPatternVari(numeric patternID, string varicode){
		var idvari = QueryExecute("select id_pattern_var from pattern_variantions WHERE pv_code = '#varicode#' ").id_pattern_var;
		QueryExecute("
						DELETE FROM pattern_var_des
   						WHERE id_pattern_var = #idvari#
					");
		QueryExecute("
						DELETE FROM pattern_variantions
   						WHERE id_pattern = #patternID# and pv_code = '#varicode#'
					");
		return "";
	}

	function getFullImage(numeric patternID, string varicode){
		var result = QueryExecute("
						SELECT * FROM pattern_variantions
   						WHERE id_pattern = #patternID# and pv_code = '#varicode#'
					");
		return result;
	}

	function getPatternVari(patternid, pvcode){
   		var result = QueryExecute("
   			select pvd.pv_description, pv.pv_code, pv.pattern_part, pv.pv_sketch, pv.pv_comment, pvd.id_language, pv.id_pattern_var
   			from pattern_variantions pv
   				join patterns
   					on patterns.id_pattern = pv.id_pattern
   				join pattern_var_des pvd
   					on pvd.id_pattern_var = pv.id_pattern_var
   			where patterns.id_pattern = #patternid# and pv_code = '#pvcode#'
   			");
   		return result;
   	}

   	function getPatternVariForAddProduct(patternid){
   		var currentIDUser = userService.get(SESSION.loggedInUserID).getlanguage().getid_language();
		var result = queryToArray(QueryExecute("
			   			select pvd.pv_description, pv.pv_code, pvd.id_pv_des, pv.id_pattern_var
			   			from pattern_variantions pv
			   				join patterns
			   					on patterns.id_pattern = pv.id_pattern
			   				join pattern_var_des pvd
			   					on pvd.id_pattern_var = pv.id_pattern_var
			   			where patterns.id_pattern = #patternid# and pvd.id_language = #currentIDUser#
			   			"));
		for (var i=1;i LTE ArrayLen(result);i++) {
			if(result[i].pv_description == ""){				
				var pv_description = QueryExecute("
										select pvd.pv_description
							   			from pattern_variantions pv
							   				join patterns
							   					on patterns.id_pattern = pv.id_pattern
							   				join pattern_var_des pvd
							   					on pvd.id_pattern_var = pv.id_pattern_var
							   			where patterns.id_pattern = #patternid# and pvd.id_language = 1
									  ").pv_description;
				result[i].pv_description = pv_description;
			}
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