/**
*
* @file  /E/projects/source/handlers/forwarder.cfc
* @author  Vo Hanh Tan
* @description 14/04/2016
*
*/

component output="false" displayname=""  {
	property name='forwarderService' inject='entityService:Forwarder';
	property name='contactService' inject='entityService:Contact';
	property name='personService'     inject='entityService:person';
	property name='userService' inject='userService';

	public function init(){
		return this;
	}

	function getforwarder(event,prc,rc)
	{
		var user_type = userService.getUserLevel();
		var forwarders = [];
		var forwarderList = EntityLoad('forwarder');
		if(user_type == 2){
			for(item in forwarderList){
				if(item.getzone_name() != ""  || item.getagent_name() != ""){
					var forwarder = {};
		   			forwarder.id 		= item.getid_forwarder();
		   			forwarder.name 		= item.getfw_name();
		   			forwarder.contact 	= isNull(item.getContact())?"":item.getContact().getcn_name();
		   			forwarder.contactID = isNull(item.getContact())?"":item.getContact().getid_contact();
		   			forwarder.zone 		= item.getzone_name();
		   			forwarder.agent 	= item.getagent_name();
		   			ArrayAppend(forwarders,forwarder);
				}
			}
		}

		if(user_type == 3){
			for(item in forwarderList){
				if(item.getagent_name() != ""){
					var forwarder = {};
		   			forwarder.id 		= item.getid_forwarder();
		   			forwarder.name 		= item.getfw_name();
		   			forwarder.contact 	= isNull(item.getContact())?"":item.getContact().getcn_name();
		   			forwarder.contactID = isNull(item.getContact())?"":item.getContact().getid_contact();
		   			forwarder.zone 		= item.getzone_name();
		   			forwarder.agent 	= item.getagent_name();
		   			ArrayAppend(forwarders,forwarder);
				}
			}
		}

		if(user_type == 1){
			for(item in forwarderList){
				var forwarder = {};
	   			forwarder.id 		= item.getid_forwarder();
	   			forwarder.name 		= item.getfw_name();
	   			forwarder.contact 	= isNull(item.getContact())?"":item.getContact().getcn_name();
	   			forwarder.contactID = isNull(item.getContact())?"":item.getContact().getid_contact();
	   			forwarder.zone 		= item.getzone_name();
	   			forwarder.agent 	= item.getagent_name();
	   			ArrayAppend(forwarders,forwarder);
			}
		}

		// for(item in forwarderList) {
		//    var forwarder = {};
		//    forwarder.id 		= item.getid_forwarder();
		//    forwarder.name 		= item.getfw_name();
		//    forwarder.contact 	= isNull(item.getContact())?"":item.getContact().getcn_name();
		//    forwarder.contactID 	= isNull(item.getContact())?"":item.getContact().getid_contact();
		//    if(user_type == 2){
		// 		if(item.getzone_name == "" & item.getagent_name == ""){

		// 		}

		// 		forwarder.zone 	= "";
		// 	}
		// 	else if(user_type == 2 || user_type == 1){
		// 		forwarder.zone  = item.getzone_name();
		// 	}
		//    forwarder.agent 		= item.getagent_name();

		//    ArrayAppend(forwarders,forwarder);
		// }

		event.renderData(type="json",data=forwarders);
	}

	public any function addNew(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_Forwarder== 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();
				var user_type = userService.getUserLevel();
				if(user_type == 2){
					var zone_name  = userService.getZoneNameOfUser();
					var agent_name = "";
				}
				else if(user_type == 3){
					var zone_name = "";
					var agent_name = userService.getAgentNameOfUser()
				}
				else if(user_type == 1){
					var zone_name = "";
					var agent_name = "";
				}

				var newForwarder = forwarderService.new({
					fw_name:rc.name,
					zone_name:zone_name,
					agent_name:agent_name, 
					updated:created,
					created:created,
					user_created:user_created,
					user_updated:user_created
				});

				var contact = contactService.get(rc.contact);
				contact.setDraft(0);
				newForwarder.setContact(contact);

				var result = forwarderService.save(newForwarder);
				contactService.save(contact);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new forwarder successfully' , 'groupId' : newForwarder.getid_forwarder(),'forw_Name':newForwarder.getfw_name()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add forwarder failed !' });
			}else{
				var forwarder = forwarderService.get(rc.id_Forwarder);
				var user_updated = userService.getLoggedInUser();
				var updated = now();
				var user_type = userService.getUserLevel();
				if(user_type == 2){
					var zone_name  = userService.getZoneNameOfUser();
					var agent_name = "";
				}
				else if(user_type == 3){
					var zone_name = "";
					var agent_name = userService.getAgentNameOfUser()
				}
				else if(user_type == 1){
					var zone_name = "";
					var agent_name = "";
				}

				forwarder.setUser_Updated(user_updated);
				forwarder.setUpdated(updated);
				forwarder.setfw_name(rc.name);
				forwarder.setzone_name(zone_name);
				forwarder.setagent_name(agent_name);
				var contact = contactService.get(rc.contact);
				contact.setDraft(0);
				forwarder.setContact(contact);
				contactService.save(contact);
				var result = forwarderService.save(forwarder);


				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update forwarder status successfully','forw_Name':forwarder.getfw_name()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update forwarder status failed !' });
			}
		}
	}

	function delete(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			// var getForwarder = forwarderService.get(rc.forwarderID);
			// forwarderService.delete(getForwarder,true);
			// event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete Forwarder success' });


			var getForwarder = forwarderService.get(rc.forwarderID);
			forwarderService.delete(getForwarder,true);
			if(!isNull(getForwarder.getContact())){
				var getIDContact = getForwarder.getContact().getid_contact();
				var listpersons = EntityLoad("person", {contact = EntityLoadByPK("contact",getIDContact)});
				if(!isNull(listpersons)){
					for(person in listpersons){
						var per = personService.get(person.getid_person());
						personService.delete(per,true);
					}
				}
				var getContact = contactService.get(getIDContact);
				contactService.delete(getContact,true);
			}
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete Forwarder successfully' });
		}
	}
}