component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';
	/**
	* Constructor
	*/
	function init(){
		// init super class
		super.init( entityName="shipment" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.shipment" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}

	function getShipmentTypeByCode(string type){
		var result = [];
		var stp = QueryExecute("
				SELECT *
				FROM shipment_type
				WHERE st_code like '#type#%'
			");
		if(stp.recordCount){
			result = queryToArray(stp);
		}
		return result;
	}

	function getSender(){
		var userLevel 	  = userService.getUserLevel();
		var loginID 	  = SESSION.LOGGEDINUSERID;
		var result 		  = [];
		if(userLevel == 1){
			var factory 	= entityLoadByPK("user", loginID).getfactory();
			var code 		= factory.getfty_code();
			var description = factory.getfty_code() & (factory.getfty_description() != "" ? " - ": "") & factory.getfty_description();
			var str 		= {"code":  code, "id" : factory.getid_factory(), "description" : description, "usertype": "factory"};
			arrayAppend(result, str);
		}else if(userLevel == 2){
			var zone 		= entityLoadByPK("user", loginID).getzone();
			var code 		= zone.getz_code()&(zone.getz_description() != "" ? " - ": "")&zone.getz_description();
			var description = zone.getz_code();
			var str 		= {"code":  code, "id": zone.getid_zone(), "description" : description, "usertype" : "zone"};
			arrayAppend(result, str);
		}else if(userLevel == 3){
			var agent 		= entityLoadByPK("user", loginID).getagent();
			var code 		= agent.getag_code();
			var description = agent.getag_code()&(agent.getag_description() != "" ? " - ": "")&agent.getag_description();
			var str 		= {"code":  code, "id": agent.getid_agent(), "description" : description, "usertype" : "agent"};
			arrayAppend(result, str);
		}
		return result;
	}

	private function getUnitShipment(numeric id_shipment){
		var result = QueryExecute("
				select sum(ordd_qtty) sum
				from shipment_details
				where id_shipment = #id_shipment#
			");
		return result;
	}

	function getShipmentList(data){
		var userLevel 	  = userService.getUserLevel();
		var filter		  = data.filter;
		var result		  = [];
		var data_shipment = QueryExecute("
				SELECT *
				FROM shipment
					INNER JOIN shipment_type st
						ON st.id_shipment_type = shipment.id_shipment_type
					INNER JOIN forwarder fw
						ON fw.id_forwarder = shipment.id_forwarder
				WHERE st.st_code like '#filter#'
				order by id_shipment DESC
			");

		// var data_shipment_dt = QueryExecute("
		// 		SELECT *
		// 		FROM shipment_details sd
		// 			INNER JOIN	shipment s
		// 				ON sd.id_shipment_det = s.id_shipment_det

		// 	");
		for(shipmentItem in data_shipment){
			var str = {};
			var status = getShipmentStatus(shipmentItem.sh_delivery_date, shipmentItem.sh_arrival_date);
			str["id_shipment"] 			= shipmentItem.id_shipment;
			str["st_code"]				= shipmentItem.st_code;
        	str["sh_send"]				= shipmentItem.sh_send;
        	str["sh_desti"]				= shipmentItem.sh_desti;
        	str["sh_status"]			= status;
        	// str["sh_status"]			= shipmentItem.sh_status;
        	str["fw_name"]				= shipmentItem.fw_name;
        	// str["fr_description"]		= shipmentItem.fr_description;
        	str["fr_description"]		= "freight";
        	str["sh_incoterm"]			= shipmentItem.sh_incoterm;
        	str["sh_tot_unit"]			= 35;//sau nay tinh
        	str["sh_tot_box"]			= 30;//sau nay tinh
        	str["sh_tot_weight"]		= 30;//sau nay tinh
        	str["sh_tot_vol"]			= 30;//sau nay tinh
        	str["sh_open_date"]			= dateFormat(shipmentItem.sh_open_date, "dd/mm/yyyy");
        	str["sh_estim_del_date"] 	= dateFormat(shipmentItem.sh_estim_del_date, "dd/mm/yyyy");
        	str["sh_delivery_date"]	 	= dateFormat(shipmentItem.sh_delivery_date, "dd/mm/yyyy");
        	str["sh_estim_arr_date"] 	= dateFormat(shipmentItem.sh_estim_arr_date, "dd/mm/yyyy");
        	str["sh_arrival_date"]	 	= dateFormat(shipmentItem.sh_arrival_date, "dd/mm/yyyy");
        	str["sh_frg_cost"]		 	= shipmentItem.sh_frg_cost;
        	str["sh_taxes"]				= shipmentItem.sh_taxes;
        	str["sh_imp_duty"]		 	= shipmentItem.sh_imp_duty;
			arrayAppend(result, str)
		}
		return result;
	}

	function getShipmentStatus(string delivery_date, string arrival_date){
		var sh_status = "";
		if(delivery_date == "" or isNull(delivery_date)){
			sh_status = "OPEN";
		}else{
			if(arrival_date == "" or isNull(arrival_date)){
				sh_status = "TRANSIT";
			}else{
				sh_status = "RECEIVED";
			}
		}
		return sh_status;
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

   	function getShipmentInfor(string id_contact){
   		return QueryExecute(" 
			SELECT *
			FROM shipment_information
			where id_contact = #id_contact#
			");
   	}

}