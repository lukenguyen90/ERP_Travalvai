/**
*
* @file  /E/projects/source/handlers/customer.cfc
* @author
* @description
*
*/

component output="false" displayname=""  {
	property  name='type_of_customersService'  inject='entityService:Type_of_customers';
	property  name='customerService'           inject='entityService:customer';
	property  name='zoneService'               inject='entityService:Zone';
	property  name='languagesService'          inject="entityService:Languages";
	property  name='type_of_customersService'  inject='entityService:Type_of_customers';
	property  name='agentService'              inject='entityService:Agent';
	property  name='contactService'            inject='entityService:Contact';
	property  name='personService'             inject='entityService:person';
	property name='userService' inject='userService';

	public function init(){
		return this;
	}

	function addNewTcustomer(event,prc,rc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id== 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();

				var newtypeCus = type_of_customersService.new({tc_code:rc.code,tc_description:rc.description,updated:created,created:created,user_created:user_created,user_updated:user_created});
				var result = type_of_customersService.save(newtypeCus);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new customer type successfully','idtc' : newtypeCus.getid_type_Customer(),'typeCustCode': newtypeCus.gettc_code() });
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new customer type failed !' });
			}else{
				var pStt = type_of_customersService.get(rc.id);
				var user_updated = userService.getLoggedInUser();
				var updated = now();

				pStt.setUser_Updated(user_updated);
				pStt.setUpdated(updated);
				pStt.settc_code(rc.code);
				pStt.settc_description(rc.description);
				var result = type_of_customersService.save(pStt);

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update customer type successfully','typeCustCode': pStt.gettc_code() });
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update customer type failed !' });
			}
		}
	}

	function addNewCus(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var userLoggedInType=userService.getUserLevel();
			if(rc.id_Cu== 0)
			{
				var user_created = userService.getLoggedInUser();
				var user_updated = user_created;
				var created = now();
				var updated = created;
				var newCus = customerService.new({
					cs_name:rc.name
					, language:rc.language
					, type_of_customer:rc.type
					, contact:rc.contact
					, updated:updated
					, created:created
				});

				var contact = contactService.get(rc.contact);
				contact.setDraft(0);
				newCus.setContact(contact);
				contactService.save(contact);

				newCus.setUser_created(user_created);
				newCus.setUser_updated(user_updated);

				if(userLoggedInType eq 3){
					newCus.setZone(user_created.getZone());
					agentLoggedIn =  userService.getAgentValueOfUser();
					newCus.setagent(agentService.get(agentLoggedIn));
				}else if(userLoggedInType eq 2){
					newCus.setZone(user_created.getZone());
					newCus.setagent(agentService.get(rc.agent));
				}else if(userLoggedInType eq 1){
					newCus.setZone(zoneService.get(rc.zone));
					newCus.setagent(agentService.get(rc.agent));
				}

				var result = customerService.save(newCus);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new customer successfully','idc' : newCus.getid_Customer()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new customer failed !' });
			}else{
				var pStt = customerService.get(rc.id_Cu);

				var user_updated = userService.getLoggedInUser();
				var updated = now();

				pStt.setUser_updated(user_updated);
				pStt.setUpdated(updated);
				pStt.setcs_name(rc.name);
				if(userLoggedInType == 3){
					pStt.setZone(user_updated.getZone());
					agentLoggedIn =  userService.getAgentValueOfUser();
					pStt.setagent(agentService.get(agentLoggedIn));
				}else if(userLoggedInType eq 2){
					pStt.setZone(user_updated.getZone());
					pStt.setagent(agentService.get(rc.agent));
				}else if(userLoggedInType eq 1){
					pStt.setZone(zoneService.get(rc.zone));
					pStt.setagent(agentService.get(rc.agent));
				}

				pStt.setlanguage(rc.language==0?JavaCast("null", ""):languagesService.get(rc.language));
				pStt.settype_of_customer(rc.type==0?JavaCast("null", ""):type_of_customersService.get(rc.type));
				pStt.setcontact(contactService.get(rc.contact));
				var result = customerService.save(pStt);

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update customer successfully' });
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update customer failed !' });
			}
		}
	}

	public any function getzoneforid(event,rc,prc) {
		var agent = agentService.get(rc.idcus);
 		project.name_zone = isNull(agent.getZone())?"":agent.getZone().getz_code();
   		project.id_zone = isNull(agent.getZone())?"":agent.getZone().getid_Zone();
		event.renderData(type="json",data={ 'success' : true , 'name_zone' : project.name_zone, 'id_zone' :  project.id_zone});
	}

	function deleteTcustomer(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var gettc = type_of_customersService.get(rc.id);
			type_of_customersService.delete(gettc,true);
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete customer type successfully' });
		}
	}

	function getInfor(event,rc,prc)
	{
		var result = {};
		if(structKeyExists(rc, "id_Cu"))
		{
			var resultQuery = customerService.get(id=rc.id_Zone,returnNew=true);
			result.code     = resultQuery.getid_Customer();
			result.name     = resultQuery.getcs_name();
			result.zone     = isNull(resultQuery.getZone())?"":resultQuery.getZone().getid_Zone();
			result.agent    = isNull(resultQuery.getAgent())?"":resultQuery.getAgent().getid_Agent();
			result.language = isNull(resultQuery.getlanguage())?"":resultQuery.getlanguage().getid_language();
			result.toc      = isNull(resultQuery.gettype_of_customer())?"":resultQuery.gettype_of_customer().getid_type_Customer();
		}
		event.renderData(type="json",data=result);
	}

	function delete(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			// var getc = customerService.get(rc.id);
			// customerService.delete(getc,true);
			// event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete customer success' });

			var getc = customerService.get(rc.id);
			customerService.delete(getc,true);
			if(!isNull(getc.getContact())){
				var getIDContact = getc.getContact().getid_contact();
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
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete customer successfully' });
		}
	}

}