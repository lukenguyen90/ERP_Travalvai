/**
*
* @file  /E/projects/source/handlers/angent.cfc
* @author
* @description
*
*/

component output="false" displayname=""  {
	property name='languagesService' inject="entityService:Languages";
	property name='zoneService' inject="entityService:Zone";
	property name='contactService' inject='entityService:Contact';
	property name='personService'     inject='entityService:person';
	property name='agentService' inject='entityService:Agent';
	property name='userService' inject='userService';

	public function init(){
		return this;
	}

	public any function getInfor(event,rc,prc) {
		var result = {};
		if(structKeyExists(rc, "id_Agent"))
		{
			var resultQuery    = agentService.get(id=rc.id_Agent,returnNew=true);
			result.id          = resultQuery.getid_Agent();
			result.code        = resultQuery.getag_code();
			result.description = resultQuery.getag_description();
			result.commission  = resultQuery.getag_commission();
			result.zone        = isNull(resultQuery.getZone())?0:resultQuery.getZone().getid_Zone();
			result.language    = isNull(resultQuery.getLanguage())?0:resultQuery.getLanguage().getid_language();
		}
		event.renderData(type="json",data=result);
	}

	function addNew(event,prc,rc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_Agent== 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();

				var newAgent = agentService.new({
						  ag_code:rc.code
						, ag_description:rc.description
						, ag_commission: val(rc.commission)
						, language:rc.language
						, updated:created
						, created:created
					});
				
				newAgent.setUser_created(user_created);
				newAgent.setUser_Updated(user_created);

				var contact = contactService.get(rc.contact);
				contact.setDraft(0);
				contactService.save(contact);
				newAgent.setContact(contact);

				var userLoggedInType=userService.getUserLevel();
				if(userLoggedInType eq 2){
					zoneLoggedIn =  userService.getZoneValueOfUser();
					newAgent.setzone(zoneService.get(zoneLoggedIn));
				}else{
					newAgent.setZone(zoneService.get(rc.zone));
				}
				// writeDump(newAgent);
				// abort;

				var result = agentService.save(newAgent);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new agent successfully' , 'agentId' : newAgent.getid_Agent(), 'code_Agent' : newAgent.getag_code()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new agent failed !' });
			}else{
				var Agent = agentService.get(rc.id_Agent);

				var user_updated = userService.getLoggedInUser();
				var updated = now();

				Agent.setUser_updated(user_updated);
				Agent.setUpdated(updated);
				Agent.setag_code(rc.code);
				Agent.setag_description(rc.description);
				Agent.setag_commission(rc.commission);
				Agent.setzone(rc.zone == ""?JavaCast("null", ""):zoneService.get(rc.zone));
				Agent.setLanguage(rc.language==""?JavaCast("null", ""):languagesService.get(rc.language));
				Agent.setContact(rc.contact==""?JavaCast("null", ""):contactService.get(rc.contact));
				var result = agentService.save(Agent);

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update agent successfully', 'code_Agent' : Agent.getag_code()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update agent failed !' });
			}
		}
	}
	function delete(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var getAgent = agentService.get(rc.aId);
			agentService.delete(getAgent,true);
			if(!isNull(getAgent.getContact())){
				var getIDContact = getAgent.getContact().getid_contact();
				var listpersons = EntityLoad("person", {contact = EntityLoadByPK("contact",getIDContact)});
				if(!isNull(listpersons)){
					for(person in listpersons){
						var per = personService.get(person.getid_person());
						personService.delete(per,true);
					}
				}
				var getContact = contactService.get(getIDContact);

				var abc = contactService.delete(getContact,true);
			}
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete agent successfully' });
		}
	}
}