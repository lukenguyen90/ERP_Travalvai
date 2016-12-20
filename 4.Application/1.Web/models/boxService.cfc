/**
* A ColdBox Enabled virtual entity service
*/
component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' inject='userService';
	/**
	* Constructor
	*/
	function init(){
	    // init super class
		super.init( entityName="box" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.box" );
	    // EventHandling
	    setEventHandling( true );
	    return this;
	}
	
	function getBoxList(numeric startItem, numeric lengthItem,string columns, string order, numeric draw, string search){
		var userLevel 	= userService.getUserLevel();
		var searchString = "";
		columns = deserializeJSON('['&columns&']');
		order 	= deserializeJSON(order);
		search  = deserializeJSON(search);
		var result 		= [];
		if(userLevel == 1){
			//search
			if(search.value != ""){
				searchString &= " AND (box.id_box LIKE '%#search.value#%' OR box.bx_code LIKE '%#search.value#%' OR tb.tb_description LIKE '%#search.value#%' OR box.bx_weight LIKE '%#search.value#%')  ";
			}
			for(item in columns){
		        if(item.searchable)
		        {
		            if(item.search.value != "")
		            {
		                searchString &= " AND "&item.data&" LIKE '%" & item.search.value & "%'";
		            }
		        }
		    }
		    //end search
		    //order
		    if(order.column == 0){
		        orderby = " ORDER BY box.id_box " &order.dir;
		    }
		    if(order.column == 1){
		        orderby = " ORDER BY box.bx_code " &order.dir;
		    }
		    if(order.column == 2){
		        orderby = " ORDER BY tb.tb_description " &order.dir;
		    }
		    if(order.column == 3){
		        orderby = " ORDER BY box.bx_weight " &order.dir;
		    }
		    //end order
			var qBoxData = QueryExecute("
					SELECT SQL_CALC_FOUND_ROWS box.id_box, box.id_type_box, tb.tb_description, box.bx_code, tb.tb_depth, tb.tb_length, tb.tb_width, box.bx_weight
					FROM box
						INNER JOIN type_of_box tb
							ON box.id_type_box = tb.id_type_box
					WHERE 1 = 1"
					&searchString&
					orderby&
		        	" LIMIT "&lengthItem&" OFFSET "&startItem
			);
			var totalResult = queryExecute("SELECT FOUND_ROWS() as count");
			for(item in qBoxData){
				var str = {};
				str["id_box"] 			= item.id_box;
				str["id_type_box"] 		= item.id_type_box;
				str["tb_description"] 	= item.tb_description;
				str["bx_code"] 			= item.bx_code;
				str["bx_weight"] 		= item.bx_weight;

				arrayAppend(result, str);
			}
			var thinhResult = {
				"draw": draw,
				"recordsTotal": totalResult.count,
				"recordsFiltered": totalResult.count,
				"data": result
			}
		}
		
		return thinhResult;
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
