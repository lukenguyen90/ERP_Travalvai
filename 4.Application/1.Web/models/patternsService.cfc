component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';
	property name='groupOfProductService' 	inject="entityService:group_of_products";
	/**
	* Constructor
	*/
	function init(){

		// init super class
		super.init( entityName="patterns" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.patterns" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}
	function getPatternDesByLangCurrent(numeric patternid){
		var currentIDUser = userService.get(SESSION.loggedInUserID).getlanguage().getid_language();
		var result = QueryExecute("
				SELECT pd.pd_description
				FROM pattern_description pd
					LEFT JOIN user
						ON user.id_language = pd.id_language
					LEFT JOIN patterns
						ON patterns.id_pattern = pd.id_pattern
				WHERE pd.id_language = #currentIDUser# and pd.id_pattern = #patternid#
				");
		if(!result.recordCount){
			result = QueryExecute("
				SELECT pd.pd_description
				FROM pattern_description pd
					LEFT JOIN user
						ON user.id_language = pd.id_language
					LEFT JOIN patterns
						ON patterns.id_pattern = pd.id_pattern
				WHERE pd.id_language = 1 and pd.id_pattern = #patternid#
				");
		}
		return result.pd_description;
	}
	function getAllPatternDesByLangCurrent(){
		var currentIDUser = userService.get(SESSION.loggedInUserID).getlanguage().getid_language();
		var result = queryToArray(QueryExecute("
				SELECT patterns.id_pattern, patterns.pt_code, pd.pd_description, pd.id_pattern_des
				FROM pattern_description pd
					LEFT JOIN patterns
						ON patterns.id_pattern = pd.id_pattern
				WHERE pd.id_language = #currentIDUser#
				"));
		for (var i=1;i LTE ArrayLen(result);i++) {
			if(result[i].pd_description == ""){				
				var pd_description = QueryExecute("
										SELECT pd.pd_description
										FROM pattern_description pd
											LEFT JOIN patterns
												ON patterns.id_pattern = pd.id_pattern
										WHERE pd.id_language = 1 and patterns.id_pattern = #item.id_pattern#
									  ").pd_description;
				result[i].pd_description = pd_description;
			}
		}		
		return result;
	}
	function getPattern(numeric id){
		var result = QueryExecute("SELECT * FROM patterns WHERE id_pattern = #id#");
		return  result;
	}
	function getGroupProduct(numeric patternid){
		var currentIDUser = userService.get(SESSION.loggedInUserID).getlanguage().getid_language();
		var result = QueryExecute("
			SELECT gp.id_group_products, gp_code, gpl.description
			FROM group_of_products gp
				LEFT JOIN group_product_language gpl
					ON gpl.id_group = gp.id_group_products and gpl.id_language = #currentIDUser#
				LEFT JOIN patterns pt
					ON pt.id_group_products = gp.id_group_products
			WHERE pt.id_pattern = #patternid#
			");
		return result;
	}
	function getFullGP(){
		var IdLangDefault = userService.get(SESSION.loggedInUserID).getlanguage().getid_language();
		var result = QueryExecute("SELECT gd.id_group_products, gd.gp_code, gd.created, gd.updated, gd.id_Factory, gdl.description
								  FROM group_of_products gd
								   inner join group_product_language gdl
								   	on gd.id_group_products = gdl.id_group
								   WHERE gdl.id_language = 1");
		return result;
	}
	function getFullNotes(patternid){
		var result = QueryExecute("
				SELECT pn.id_pattern_note id, pn.pn_note notes, DATE_FORMAT(pn.pn_date,'%d-%m-%Y %H:%i:%s') createDate, pn.id_user_created iduser, pn.id_pattern idpattern, user.user_name user
				FROM pattern_notes pn
					LEFT JOIN patterns
						ON pn.id_pattern = patterns.id_pattern
					LEFT JOIN user
						ON pn.id_user_created = user.id_user
				WHERE patterns.id_pattern = #patternid#
				ORDER BY pn.pn_date DESC
			");
		return queryToArray(result);
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
   	function deleteFKPattern(patternid){
   		QueryExecute("
   				DELETE FROM pattern_description
   				WHERE id_pattern = #patternid#
   			");
		QueryExecute("
			DELETE FROM pattern_var_des
			WHERE id_pattern_var in (SELECT id_pattern_var
					   				FROM pattern_variantions
					   				WHERE id_pattern = #patternid#)
		");
   		QueryExecute("
			DELETE FROM pattern_notes
			WHERE id_pattern = #patternid#
		");
		QueryExecute("
			DELETE FROM pattern_part
			WHERE id_pattern = #patternid#
		");
		QueryExecute("
			DELETE FROM pattern_variantions
			WHERE id_pattern = #patternid#
		");
		return "";
   	}

   	function getPatternVari(patternid){
   		var IdLangDefault = userService.get(SESSION.loggedInUserID).getlanguage().getid_language();
   		var result = QueryExecute("
   			select *
   			from pattern_variantions pv
   				join patterns
   					on patterns.id_pattern = pv.id_pattern
   				join pattern_var_des pvd
   					on pvd.id_pattern_var = pv.id_pattern_var
   			where patterns.id_pattern = #patternid# and pvd.id_language = #IdLangDefault#
   			");
   		return result;
   	}
}