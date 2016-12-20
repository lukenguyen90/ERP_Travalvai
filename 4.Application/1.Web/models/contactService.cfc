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
		super.init( entityName="contact" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.contact" );
	    // EventHandling
	    setEventHandling( true );
	    return this;
	}

	// delete all draft

	function deleteDraft() {
		return QueryExecute('DELETE FROM contact WHERE  draft=1;');
	}

	function getIdContactFromZone(){
		var userLevel = userService.getUserLevel();
		var zoneID = userService.getZoneID();
		var agentID = userService.getAgentID();
		var cusID = userService.getCustomerID();
		switch(userLevel){
			case 1:
				var listIDContact = "";
				var contactIDOfFac = QueryExecute("
					SELECT id_contact
					FROM contact
				");
				for(item in contactIDOfFac){
					listIDContact &= ","& item.id_contact;
				}
				listIDContact = listIDContact.split(",", 2);
				
				return listIDContact[2];
		   	break;
		   	case 2:
		   		var listIDContact = "";
				var contactIDOfZone = QueryExecute("
					SELECT id_contact
					FROM zone
					WHERE id_zone = #zoneID#
				").id_contact;
				listIDContact &= contactIDOfZone;
				var contactIDOfAgent = QueryExecute("
					SELECT id_contact
					FROM agent
					WHERE id_zone = #zoneID# and id_agent in (#agentID#)
					");
				if(contactIDOfAgent.recordcount > 0){
					for(item in contactIDOfAgent){
						listIDContact &= "," &item.id_contact;
					}					
				}			
				var contactIDOfCus = QueryExecute("
					SELECT id_contact
					FROM customer
					where id_zone = #zoneID# and id_agent in (#agentID#)
					");
				if(contactIDOfCus.recordcount > 0 ){					
					for(itemCus in contactIDOfCus){
						listIDContact &= "," &itemCus.id_contact;
					}
				}
				listIDContact = Replace(listIDContact, ",," , ",", "All");
				return listIDContact;				   		
		   		break;

		   	case 3:		   		
		   		var listIDContact = "";
		   		var contactIDOfAgent = QueryExecute("
					SELECT id_contact
					FROM agent
					WHERE id_zone = #zoneID# and id_agent in (#agentID#)
					");
		   		for(item in contactIDOfAgent){
					listIDContact &= "," &item.id_contact;
				}

				var contactIDOfCus = QueryExecute("
					SELECT id_contact
					FROM customer
					where id_zone = #zoneID# and id_agent in (#agentID#)
					");
				for(itemCus in contactIDOfCus){
					listIDContact &= "," &itemCus.id_contact;
				}
				listIDContact = listIDContact.split(",", 2);
				
				return listIDContact[2];
		   		
		   	break;

		   	case 4:
		   		var listIDContact = "";
		   		var contactIDOfCus = QueryExecute("
					SELECT id_contact
					FROM customer
					where id_customer = #cusID# and id_zone = #zoneID# and id_agent in (#agentID#)
					");
				for(itemCus in contactIDOfCus){
					listIDContact &= "," &itemCus.id_contact;
				}
				listIDContact = listIDContact.split(",", 2);
				
				return listIDContact[2];
		   		
		   	break;
		   	default:
		   		listIDContact = "";

		   	break;

		}
	}

	function getContact(string list_id_contact){
		return QueryExecute(" 
			SELECT *
			FROM contact
			where id_contact in (#list_id_contact#) and draft = 0
			");
	}


}
