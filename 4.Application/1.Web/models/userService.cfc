/**
* A ColdBox Enabled virtual entity service
*/
component extends="cborm.models.VirtualEntityService" singleton{

	/**
	* Constructor
	*/
	function init(){

		// init super class
		super.init( entityName="user" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.user" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}


	function getFactoryValueOfUser(){
//		writeDump(getUser());
		var factory = getLoggedInUser().getFactory();
		if( isNull(factory) )
			return "";
		return factory.getid_Factory();
	}


	function getZoneValueOfUser(){
		var zone = getLoggedInUser().getZone();
		if( isNull(zone) ) return "";
		return zone.getid_Zone();
	}

	function getZoneNameOfUser(){
		var zone = getLoggedInUser().getZone();
		if(isNull(zone)) return "";
		return zone.getz_code();
	} 

	function getAgentValueOfUser(){
		var agent = getLoggedInUser().getAgent();
		if( isNull(agent) )
			return "";
		return agent.getid_Agent();
	}

	function getAgentNameOfUser(){
		var agent = getLoggedInUser().getAgent();
		if(isNull(agent)) return "";
		return agent.getag_code() & " - " & agent.getag_description();
	} 


	function getCustomerValueOfUser(){
		var customer = getLoggedInUser().getCustomer();
		if( isNull(customer) )
			return "";
		return customer.getid_Customer();
	}

	function getAccess_levelUser(){
		if(!IsNull(getLoggedInUser().getAccess_level())){
			return getLoggedInUser().getAccess_level();
		}else{
			return null;
		}
	}

	function getLoggedInUser(){
		return entityLoadByPK("user",SESSION.loggedInUserID);
	}

	function getUserLanguageSetting(){
		return getLoggedInUser().getlanguage().getid_language();
	}


	function getUserLogin(username,password) {
		return entityLoad("user",{user_name = arguments.username, user_password = arguments.password},true);
	}

	function isAdmin(){
		var loggedUSer = entityLoadByPK("user",SESSION.loggedInUserID);
		return loggedUSer.getIs_root()?true:false;
	}

	// function getUserType(){
	// 	var userRole = "";
	// 	if(isNull(getLoggedInUser().getFactory()) AND isNull(getLoggedInUser().getZone()) AND isNull(getLoggedInUser().getAgent()) AND isNull(getLoggedInUser().getCustomer())){
	// 		return userRole = "admin";
	// 	}
	// 	else if(not isNull(getLoggedInUser().getFactory()) AND isNull(getLoggedInUser().getZone()) AND isNull(getLoggedInUser().getAgent()) AND isNull(getLoggedInUser().getCustomer())){
	// 		SESSION.Title = getLoggedInUser().getFactory().getfty_code() & " - " &"Factory Admin";
	// 		return userRole = "factory";
	// 	}
	// 	else if (not isNull(getLoggedInUser().getFactory()) AND (not isNull(getLoggedInUser().getZone())) AND isNull(getLoggedInUser().getAgent()) AND isNull(getLoggedInUser().getCustomer())){
	// 		SESSION.Title = getLoggedInUser().getFactory().getfty_code() & "/" & getLoggedInUser().getZone().getz_code() & " - " & "Zone Admin";
	// 		return userRole = "zone";
	// 	}
	// 	else if (not isNull(getLoggedInUser().getFactory()) AND (not isNull(getLoggedInUser().getZone())) AND (not isNull(getLoggedInUser().getAgent())) AND isNull(getLoggedInUser().getCustomer())){
	// 		SESSION.Title = getLoggedInUser().getFactory().getfty_code() & "/" & getLoggedInUser().getZone().getz_code() & "/" & getLoggedInUser().getAgent().getag_code() & " - " & "Agent Admin";
	// 		return userRole = "agent";
	// 	}
	// 	else if (not isNull(getLoggedInUser().getFactory()) AND (not isNull(getLoggedInUser().getZone())) AND (not isNull(getLoggedInUser().getAgent())) AND (not isNull(getLoggedInUser().getCustomer()))){
	// 		SESSION.Title = getLoggedInUser().getFactory().getfty_code() & "/" & getLoggedInUser().getZone().getz_code() & "/" & getLoggedInUser().getAgent().getag_code() & "/" & getLoggedInUser().getCustomer().getcs_code() & " - " & "Customer Admin";
	// 		return userRole = "customer";
	// 	}
	// 	return userRole = "";
	// }

	function getUserLevel(){
		//testService.sayHello();
		var userRole = "";
		var loggedInUser = getLoggedInUser();
		if(isNull(loggedInUser.getFactory()) AND isNull(loggedInUser.getZone()) AND isNull(loggedInUser.getAgent()) AND isNull(loggedInUser.getCustomer())){
			SESSION.level = 0;
			return userRole = 0;
		}
		else if(not isNull(loggedInUser.getFactory()) AND isNull(loggedInUser.getZone()) AND isNull(loggedInUser.getAgent()) AND isNull(loggedInUser.getCustomer())){
			SESSION.Title = loggedInUser.getFactory().getfty_code() & " - " &"Factory Admin";
			SESSION.level = 1;
			return userRole = 1;
		}
		else if (not isNull(loggedInUser.getFactory()) AND (not isNull(loggedInUser.getZone())) AND isNull(loggedInUser.getAgent()) AND isNull(loggedInUser.getCustomer())){
			SESSION.Title = loggedInUser.getFactory().getfty_code() & "/" & loggedInUser.getZone().getz_code() & " - " & "Zone Admin";
			SESSION.level = 2;
			return userRole = 2;
		}
		else if (not isNull(loggedInUser.getFactory()) AND (not isNull(loggedInUser.getZone())) AND (not isNull(loggedInUser.getAgent())) AND isNull(loggedInUser.getCustomer())){
			SESSION.Title = loggedInUser.getFactory().getfty_code() & "/" & loggedInUser.getZone().getz_code() & "/" & loggedInUser.getAgent().getag_code() & " - " & "Agent Admin";
			SESSION.level = 3;
			return userRole = 3;
		}
		else if (not isNull(loggedInUser.getFactory()) AND (not isNull(loggedInUser.getZone())) AND (not isNull(loggedInUser.getAgent())) AND (not isNull(loggedInUser.getCustomer()))){
			SESSION.Title = loggedInUser.getFactory().getfty_code() & "/" & loggedInUser.getZone().getz_code() & "/" & loggedInUser.getAgent().getag_code() & "/" & loggedInUser.getCustomer().getcs_name() & " - " & "Customer Admin";
			SESSION.level = 4;
			return userRole = 4;
		}
		return userRole = "";
	 	/* else
			return userRole ="unvalid";  */
	}

	function getUserData(){
		var userData = getLoggedInUser();
		SESSION.user_level = getUserLevel();
		switch(SESSION.user_level){
			case 1:{
				var factID = userData.getFactory().getid_Factory();
				var condition ="where factory.id_Factory = #factID#";
			}
			break;
			case 2:{
				var zoneID = userData.getZone().getid_Zone();
				var condition ="where zone.id_Zone = #zoneID#";
			}

			break;
			case 3:{
				var agentID = userData.getAgent().getid_Agent();
				var condition ="where agent.id_Agent = #agentID#";
			}
			break;
			case 4:{
				var custID = userData.getCustomer().getid_Customer();
				var condition ="where customer.id_Customer= #custID#";
			}
			break;

			default: var condition ="";
			break;
		}
		//set limit for group_concat
		queryExecute("SET SESSION group_concat_max_len = 100000000");
		//end set
		var query = queryExecute("
									select 	 group_concat(DISTINCT factory.id_Factory) as factories,
											 group_concat(DISTINCT zone.id_Zone) as zones,
											 group_concat(DISTINCT agent.id_Agent) as agents,
											 group_concat(DISTINCT customer.id_Customer) as customers
								  	from factory
										LEFT JOIN zone on factory.id_Factory = zone.id_Factory
										LEFT JOIN agent on agent.id_Zone = zone.id_Zone
										LEFT JOIN customer on customer.id_Agent = agent.id_Agent
									#condition#;
									");
		return query;
	}

	function getFactoryID(){
		return getUserData().factories;
	}

	function getFactoryData(){
		var data = getFactoryID();
		if(data == ""){
			data = "0";
		}
		var queryFact = ORMExecuteQuery("from factory where id_Factory in (#data#)");
		return queryFact;
	}

	function getZoneID(){
		var data = getUserData();
		var idZone = data.zones;
		return idZone;
	}

	function getZoneData(){
		var data = getZoneID();
		if(data == ""){
			data = "0";
		}
		var query = ORMExecuteQuery("from zone where id_Zone in (#data#)");
		return query;
	}

	function getAgentID(){
		var data = getUserData();
		var idAgent = data.agents;
		return idAgent;
	}

	function getAgentData(){
		var data = getAgentID();
		if(data == ""){
			data = "0";
		}
		var query = ORMExecuteQuery("from agent where id_Agent in (#data#)");
		return query;
	}

	function getCustomerID(){
		var data = getUserData();
		var idCust = data.customers;
		return idCust;
	}

	function getCustomerData(){
		var data = getCustomerID();
		var length = Len(data);
		if(data == ""){
			data = "0";
		}
		if(data[length] == ","){
			data = left(data, length-1);
		}
		var query = ORMExecuteQuery("from customer where id_Customer in (#data#)");
		return query;
	}
}


