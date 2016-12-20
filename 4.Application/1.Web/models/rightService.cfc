/**
* A ColdBox Enabled virtual entity service
*/
component extends="" {
	property name='userService' 				inject="userService";
	property name='access_pageService' 			inject="entityService:access_page";
	property name='access_levelService' 		inject="entityService:access_level";
	/**
	* Constructor
	*/
	function init(){

	    return this;
	}

	// Get Right of Zone

	public array function getRightbyRole() {
		var right = [];
		var access_level = userService.getAccess_levelUser();
		if(!isNull(access_level))
		{
			right = deserializeJSON(access_level.getAl_right());

		}
		return right;
	}

	// Get Acess of Role
	public struct function getAccessbyRole(required string idAccessPage) {
		var pageRights = getRightbyRole();

		for(pageRight in pageRights ){
			if(pageRight.name eq arguments.idAccessPage){
				return pageRight.right;
			}
		}

		return null;
	}

	public void function updateRightofAccess_level() {
		var access_levels = access_levelService.list(asQuery=false);
		pageAppend= {
			"name" = "",
			"right" = {
				  "open"   = false
				, "edit"   = false
				, "delete" = false
			}
		};

		for(access_level in access_levels){
			var pageRights = deserializeJSON(access_level.getAl_right());
			var listAccess_Pages = access_pageService.list(asQuery=false);
			pageListRight = "";
			for(pageRight in pageRights)
			{
				var name = trim(pageRight.name);
				pageListRight = listAppend(pageListRight,name,",");
			}

			for(page in listAccess_Pages){
				var idPage = trim(page.getIdPage());
				if(listContainsNoCase(pageListRight,idPage,",") eq 0){
					pageAppend.name = idPage
					arrayAppend(pageRights,pageAppend);
				}
			}

			var al_right = SerializeJson(pageRights);
			access_level.setAl_right(al_right);
			access_levelService.save(access_level);
		}

	}


	function getFactoryRight(){
//		getRightbyRole();

		result = {
			rightType = 0,
			objectLevel = ""
		};
		var factoryValue = userService.getfactoryValueOfUser();
		var level = userService.getUserLevel();
		if( (factoryValue != "") AND (level == 1) ){
			result.rightType = 1;
			result.objectLevel = level;
		}
		else if((factoryValue != "") AND (level != 1)){
			result.rightType = 0;
		}
		return result;

	}


	function getZoneRight(){
		result = {
			rightType = 0,
			objectLevel = ""
		};
		var level = userService.getUserLevel();
		var zoneValue = userService.getZoneValueOfUser();
		var factoryRight = getFactoryRight();
		if( zoneValue != "" AND level == 2){
			result.rightType = 1;
			result.objectLevel = level;
		}
		else if(zoneValue != "" AND level != 2){
			result.rightType = 0;
		}
		return result;
	}


	function getAgentRight(){
		result = {
			rightType = 0,
			objectLevel = ""
		};
		var level = userService.getUserLevel();
		var agentValue = userService.getAgentValueOfUser();
		var zoneRight = getZoneRight();
		if( agentValue != "" AND level == 3){
			result.rightType = 1;
			result.objectLevel = level;
		}
		else if( agentValue != "" AND level != 3){
			result.rightType = 0;		
		}
		return result;
	}


	function getCustomerRight(){
		result = {
			rightType = 0,
			objectLevel = ""
		};
		var level = userService.getUserLevel();
		var customerValue = userService.getCustomerValueOfUser();
		var agentRight = getAgentRight();
		if( customerValue != "" AND level == 4){
			result.rightType = 1;
			result.objectLevel = level;
		}
		else if(customerValue != "" AND level != 4){
			result.rightType = 0;
		}
		return result;
		}

	function getAccessLevel(){
		var access_levels = EntityLoad("access_level");
		var objects = [];
		for(al in access_levels) {
			var newItem = {
				"id" = al.getid_access_level(),
				"name" = al.getal_name(),
				"right"= DeserializeJson(al.getal_right() )
			}
			arrayAppend( objects, newItem );
		}
		return SerializeJson(objects);

	}

	/* function saveAccessLevel(){
		var jsonRight = 
	}
 */
}
