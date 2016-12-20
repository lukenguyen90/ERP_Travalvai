component extends="cborm.models.VirtualEntityService" singleton{
  property name='userService'       inject='userService';
	/**
	* Constructor
	*/
  	function init(){

  		// init super class
  		super.init( entityName="prod_cust" );

  		// Use Query Caching
  	    setUseQueryCaching( false );
  	    // Query Cache Region
  	    setQueryCacheRegion( "ormservice.prod_cust" );
  	    // EventHandling
  	    setEventHandling( true );

  	    return this;
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

    public function CostCodeCondition(){
      var result = "CUS%";
      return result;
    }

    public function getCostCodeForPrdCus(numeric plzid){
        var usertype = userService.getUserLevel();
        if(usertype neq 4){
          var aCosting = [];
          var aPlzd    = [];
          var q_plfd = QueryExecute("
            select id_cost, id_cost_version
            from price_list_factory_detail
            where id_plf_det in
              (select id_plf_det
              from price_list_zone_details
              where id_plz = #plzid#)
          ");
          if(q_plfd.recordCount){
            for(item2 in q_plfd){
              var t = structNew();
              t.id_cost = item2.id_cost;
              t.id_cost_version = item2.id_cost_version;
              arrayAppend(aPlzd, t);
              if( arrayFind(aCosting,t.id_cost) == 0){
                arrayAppend(aCosting,t.id_cost);
              }
            }
          }
          var lCostID = arrayLen(aCosting)? ArrayToList(aCosting, ",") : 0;
          result = QueryExecute("
            select *
            from costing
            where id_cost in (#lCostID#) and cost_code like '#CostCodeCondition()#'
          ");
        }
        return result;
    }

    function getProdCus(productid){
      var usertype = userService.getUserLevel();
      var result = [];
      if(usertype neq 4){
         result = QueryExecute("
            select costing.cost_code, prod_cust.id_plz_det, prod_cust.id_prd_cust, prod_cust.prd_cust_qtty, cvd.cvd_description cv_version, cvd.id_cost_version, prod_cust.id_product, prod_cust.prd_cust_description
            from prod_cust
              join costing 
                on costing.id_cost = prod_cust.cost_code
              join costing_version_description cvd
                on cvd.id_cost_version = prod_cust.cv_version
            where id_product = #productid# and id_plz_det is not null
          ");
          if(!result.recordCount){
            result = QueryExecute("
            select costing.cost_code, prod_cust.id_plz_det, prod_cust.id_prd_cust, prod_cust.prd_cust_qtty, cvs.cv_version, cvs.id_cost_version, prod_cust.id_product, prod_cust.prd_cust_description
            from prod_cust
              join costing 
                on costing.id_cost = prod_cust.cost_code
              join costing_versions cvs
                on cvs.id_cost_version = prod_cust.cv_version
            where id_product = #productid# and id_plz_det is not null
          ");
          }
      }
      return queryToArray(result);
    }

    function getProdCusID(productid, prdcusid){
      var usertype = userService.getUserLevel();
      var result = [];
      if(usertype neq 4){
        result = QueryExecute("
          select cost_code costsCSTid, id_prd_cust idprdcust, prd_cust_qtty quantity_cus, cv_version cvCSTid, prd_cust_description description_cus, plzd.id_plz
          from prod_cust
            join price_list_zone_details plzd
              on plzd.id_plz_det = prod_cust.id_plz_det
          where id_product = #productid# and id_prd_cust = #prdcusid#
        ");        
      }   
      return queryToArray(result);
    }

    function checkProdCus(costid, costversionid, productid){
      var result = QueryExecute("
          select cost_code
          from prod_cust
          where cost_code = #costid# and cv_version = #costversionid# and id_product = #productid#
        ");
      return queryToArray(result);
    }

   	function getCostVersionByCSTCode(idcost){
   		var result  = QueryExecute("
   				select cv.cv_version cvversion, cv.id_cost_version idcostversion, cv.id_cost idcost, costing.cost_code
				from costing_versions cv
				JOIN costing
					ON cv.id_cost = costing.id_cost
				where cv.id_cost in (#idcost#)
   			");
   		return queryToArray(result);
   	}
}