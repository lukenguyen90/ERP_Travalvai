component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';
	property name='rightService' 			inject="rightService";
	property name='zoneService' 			inject='zoneService';
	/**
	* Constructor
	*/
	function init(){

		// init super class
		super.init( entityName="agent" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.agent" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}

	function getAgentByIdzone(idZone)
	{
		var agentRight = rightService.getAgentRight();
		var data = userService.getAgentData();
		var agents = [];
		var agentList ={};
		var userData = userService.getLoggedInUser();
		if(structKeyExists(arguments, "idZone")){
			var agentList = EntityLoad('agent',{zone:EntityLoadByPK("zone",idZone)});
		}
		else if(userData.getIs_root() == 1){
			var agentList = EntityLoad('agent');
		}
		else{
			if(agentRight.rightType == 1){
				agentList = data;
			}
			else{
				agentList ={};
			}
		}
		for(item in agentList) {
		   var agent = {};
		   agent.id          = item.getid_Agent();
		   agent.code        = item.getag_code();
		   agent.des         = item.getag_description();
		   agent.commission  = item.getag_commission();
		   agent.zone        = isNull(item.getZone())?"":item.getZone().getz_description();
		   agent.zoneid      = isNull(item.getZone())?"":item.getZone().getid_Zone();
		   agent.language    = isNull(item.getlanguage())?"":item.getlanguage().getlg_name();
		   agent.languageid  = isNull(item.getlanguage())?"":item.getlanguage().getid_language();
		   agent.contact     = isNull(item.getContact())?"":item.getContact().getcn_name();
		   agent.contactid   = isNull(item.getContact())?"":item.getContact().getid_contact();
		   ArrayAppend(agents,agent);
		}

		return agents;
	}


}