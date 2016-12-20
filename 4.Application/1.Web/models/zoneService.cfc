component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';
	property name='rightService' 			inject="rightService";
	/**
	* Constructor
	*/
	function init(){

		// init super class
		super.init( entityName="zone" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.zone" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}

	function getZoneByFactory(idFactory){
		var zoneRight = rightService.getZoneRight();
		var data = userService.getZoneData();
		var zones = [];
		var zoneList ={};
		var userData = userService.getLoggedInUser();
		if(structKeyExists(arguments, "idFactory")){
			var zoneList = EntityLoad('zone', {factory:EntityLoadByPK("factory", idFactory)});
		}
		else if(userData.getIs_root() == 1){
			var zoneList = EntityLoad('zone');
		}
		else{
			if(zoneRight.rightType == 1){
				zoneList = data;
			}
			else{
				zoneList ={};
			}
		}
		for(item in zoneList) {
		   var zone = {};
		   zone.id         = item.getid_Zone();
		   zone.code       = item.getz_code();
		   zone.des        = item.getz_description();
		   zone.factory    = isNull(item.getfactory())?"":item.getfactory().getfty_description();
		   zone.factoryId  = isNull(item.getfactory())?"":item.getfactory().getid_Factory();
		   zone.currency   = isNull(item.getcurrency())?"":item.getcurrency().getcurr_description();
		   zone.currencyId = isNull(item.getcurrency())?"":item.getcurrency().getid_currency();
		   zone.language   = isNull(item.getlanguage())?"":item.getlanguage().getlg_name();
		   zone.languageId = isNull(item.getlanguage())?"":item.getlanguage().getid_language();
		   zone.contact    = isNull(item.getContact())?"":item.getContact().getcn_name();
		   zone.contactId  = isNull(item.getContact())?"":item.getContact().getid_contact();
		   ArrayAppend(zones,zone);
		}
		return zones;		
	}


}