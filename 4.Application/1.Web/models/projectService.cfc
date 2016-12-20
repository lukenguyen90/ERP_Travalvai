component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';
	/**
	* Constructor
	*/
	function init(){

		// init super class
		super.init( entityName="project" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.project" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}

	public function getProject(numeric zoneID, numeric agentID, numeric cusID){
		var aProject = [];
		var check = QueryExecute("
			select *
			from project
			where project.id_customer in
				(	select id_customer
					from customer
					where id_agent in (#agentID#) and id_zone = #zoneID# and id_customer = #cusID#
					group by id_customer
				)
			");
		if(check.recordCount){
			aProject = queryToArray(check);
		}		
		var lstPj = [];
		if(!isnull(aProject)) {
			for(item in aProject) {
				var str = {};
				var des = item.pj_description;
				var pj_description = len(des) gt 25 ? left(des,25)&'...' : des;
				str["id_Project"] = item.id_Project;
				str["pj_description"] = pj_description;
				arrayAppend(lstPj, str);
			}
		}
		return lstPj;
	}

	public function getProjectDetail(numeric projectId){
		var aProject = [];
		var queryProject = QueryExecute("
			select *
			from project
			where project.id_Project = #projectId#
			");
		if(queryProject.recordCount){
			aProject = queryToArray(queryProject);			
			return aProject[1];
		}		
		
		return null;
	
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