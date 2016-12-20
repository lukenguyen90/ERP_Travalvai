component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';
	property name='rightService' 			inject="rightService";
	/**
	* Constructor
	*/
	function init(){

		// init super class
		super.init( entityName="customer" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.customer" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}

	function getcustomerByIdAgent(idAgent){
		var customers = [];
		var data = userService.getCustomerData();
		var customerList ={};
		var userData = userService.getLoggedInUser();
		if(structKeyExists(arguments, "idAgent")){
			var customerList = EntityLoad('customer',{agent:EntityLoadByPK("agent",idAgent)});
		}else if(userData.getIs_root() == 1){
			var customerList = EntityLoad('customer');
		}
		else{
			customerList = data;
		}
		for(item in customerList)
		{
			var customer = {};
			var customer_name = item.getcs_name();
			customer.id = item.getid_Customer();
			customer.code = item.getcs_name();
			customer.name = len(customer_name) gt 25 ? left(customer_name,25)&'...' : customer_name;
			customer.agent = isNull(item.getAgent())?"":item.getAgent().getag_code();
			customer.agentid = isNull(item.getAgent())?"":item.getAgent().getid_Agent();
			var objZone = isNull(item.getAgent())?"": item.getAgent().getZone();
			var zonename = !IsObject(objZone) ? "" : objZone.getz_code();
			var zoneid = !IsObject(objZone) ? "" : objZone.getid_Zone();
			customer.zone = zonename;
			customer.zoneid = zoneid;
			customer.language = isNull(item.getlanguage())?"":item.getlanguage().getlg_name();
			customer.languageid = isNull(item.getlanguage())?"":item.getlanguage().getid_language();
			customer.toc = isNull(item.gettype_of_customer())?"":item.gettype_of_customer().gettc_code();
			customer.tocid = isNull(item.gettype_of_customer())?"":item.gettype_of_customer().getid_type_Customer();
		   	customer.contactID = isNull(item.getContact())?"":item.getContact().getid_contact();
			customer.contact = isNull(item.getContact())?"":item.getContact().getcn_name();
			 ArrayAppend(customers,customer);
		}
		return customers;
	}

	function getCustomerDetail(customerId){
		var customer = {};
		var data = userService.getCustomerData();
		var customerList ={};
		var userData = userService.getLoggedInUser();
		var customerList = EntityLoad('customer',{id_Customer: customerId});		
		for(item in customerList)
		{			
			var customer_name = item.getcs_name();
			customer.id = item.getid_Customer();
			customer.name = len(customer_name) gt 25 ? left(customer_name,25)&'...' : customer_name;
			customer.agent = isNull(item.getAgent())?"":item.getAgent().getag_code();
			customer.agentid = isNull(item.getAgent())?"":item.getAgent().getid_Agent();
			var objZone = isNull(item.getAgent())?"": item.getAgent().getZone();
			var zonename = !IsObject(objZone) ? "" : objZone.getz_code();
			var zoneid = !IsObject(objZone) ? "" : objZone.getid_Zone();
			customer.zone = zonename;
			customer.zoneid = zoneid;
			customer.language = isNull(item.getlanguage())?"":item.getlanguage().getlg_name();
			customer.languageid = isNull(item.getlanguage())?"":item.getlanguage().getid_language();
			customer.toc = isNull(item.gettype_of_customer())?"":item.gettype_of_customer().gettc_code();
			customer.tocid = isNull(item.gettype_of_customer())?"":item.gettype_of_customer().getid_type_Customer();
		   	customer.contactID = isNull(item.getContact())?"":item.getContact().getid_contact();
			customer.contact = isNull(item.getContact())?"":item.getContact().getcn_name();
			
		}
		return customer;
	}

	function getCustomerList(numeric startItem, numeric lengthItem,string columns, string order, numeric draw, string search){
		columns = deserializeJSON('['&columns&']');
		order 	= deserializeJSON(order);
		search  = deserializeJSON(search);
		var customers = [];
		var lstCus = userService.getCustomerID();
		var length = Len(lstCus);
		if(length){
			if(lstCus[length] == ","){
				lstCus = left(lstCus, length-1);				
			}
		}
		var strCus = " IN (#lstCus#)";
		var searchString = "";
		//search
		if(search.value != ""){
			searchString &= " AND
				(ctm.id_Customer LIKE '%#search.value#%' OR
				ctm.cs_name LIKE '%#search.value#%' OR
				zone.z_code LIKE '%#search.value#%' OR
				agent.ag_code LIKE '%#search.value#%' OR
				agent.ag_description LIKE '%#search.value#%' OR
				languages.lg_name LIKE '%#search.value#%' OR
				tc.tc_description LIKE '%#search.value#%' OR
				contact.cn_name LIKE '%#search.value#%')
				";
		}
		for(item in columns){
	        if(item.searchable)
	        {
	            if(item.search.value != "")
	            {
	            	if(item.data == "id")
	            		searchString &= " AND "&"ctm.id_Customer"&" LIKE '%" & item.search.value & "%'";
	            	if(item.data == "name")
	            		searchString &= " AND "&"ctm.cs_name"&" LIKE '%" & item.search.value & "%'";
	            	if(item.data == "zone")
	            		searchString &= " AND "&"zone.z_code"&" LIKE '%" & item.search.value & "%'";
	            	if(item.data == "agent")
	            		searchString &= " AND "&"agent.ag_code"&" LIKE '%" & item.search.value & "%'" & " OR "&"agent.ag_description"&" LIKE '%" & item.search.value & "%'";
	            	if(item.data == "language")
	            		searchString &= " AND "&"languages.lg_name"&" LIKE '%" & item.search.value & "%'";
	            	if(item.data == "tc_description")
	            		searchString &= " AND "&"tc.tc_description"&" LIKE '%" & item.search.value & "%'";
	            	if(item.data == "contact")
	            		searchString &= " AND "&"contact.cn_name"&" LIKE '%" & item.search.value & "%'";
	            }
	        }
	    }
	    //end search
	    //order
	    if(order.column == 0){
	        orderby = " ORDER BY ctm.id_Customer " &order.dir;
	    }
	    if(order.column == 1){
	        orderby = " ORDER BY ctm.cs_name " &order.dir;
	    }
	    if(order.column == 2){
	        orderby = " ORDER BY zone.z_code " &order.dir;
	    }
	    if(order.column == 3){
	        orderby = " ORDER BY agent.ag_code " &order.dir;
	    }
	    if(order.column == 4){
	        orderby = " ORDER BY languages.lg_name " &order.dir;
	    }
	    if(order.column == 5){
	        orderby = " ORDER BY tc.tc_description " &order.dir;
	    }
	    if(order.column == 6){
	        orderby = " ORDER BY contact.cn_name " &order.dir;
	    }
	    //end order
		var qCustomerList = QueryExecute("
				SELECT SQL_CALC_FOUND_ROWS ctm.cs_name, ctm.id_Customer, agent.ag_code, agent.id_Agent, agent.ag_description, zone.z_code, zone.id_zone,
						languages.lg_name, languages.id_language, tc.tc_description, tc.id_type_Customer, contact.id_contact, contact.cn_name
				FROM customer ctm
				INNER JOIN agent
					ON ctm.id_agent = agent.id_agent
				INNER JOIN zone
					ON ctm.id_zone = zone.id_zone
				INNER JOIN languages
					ON ctm.id_language = languages.id_language
				INNER JOIN type_of_customers tc
					ON ctm.id_type_customer = tc.id_type_customer
				INNER JOIN contact
					ON ctm.id_contact = contact.id_contact
				WHERE 1 = 1 AND ctm.id_customer"
				&strCus
				&searchString&
				orderby&
	        	" LIMIT "&lengthItem&" OFFSET "&startItem
				);
		var total = 0;
		if(qCustomerList.recordCount){
			for(item in qCustomerList){
				var customer = {};
				var customer_name = item.cs_name;
				var id_name = item.id_Customer & ' - ' & item.cs_name;
				customer.id = item.id_Customer;
				customer.name = customer_name;
				customer.id_name = len(id_name) gt 37 ? left(id_name,37)&'...' : id_name;
				customer.agent = item.ag_code;
				customer.agentid = item.id_Agent;
				customer.agent_des = item.ag_description != "" ? (" - " & item.ag_description ): "";
				var zonename = item.z_code;
				var zoneid = item.id_Zone;
				customer.zone = zonename;
				customer.zoneid = zoneid;
				customer.language = item.lg_name;
				customer.languageid = item.id_language;
				customer.tc_description = item.tc_description;
				customer.tocid = item.id_type_Customer;
			   	customer.contactID = item.id_contact;
				customer.contact = item.cn_name;
				ArrayAppend(customers,customer);
			}

			var totalResult = queryExecute("SELECT FOUND_ROWS() as count");
			total 	= totalResult.count;
		}
		var thinhResult = {
			"draw": draw,
			"recordsTotal": total,
			"recordsFiltered": total,
			"data": customers
		}
		return thinhResult;
	}


}