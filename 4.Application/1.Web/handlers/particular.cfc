/**
*
* @file  /E/projects/source/handlers/particular.cfc
* @author  Vo Hanh Tan
* @description 14/04/2016
*
*/

component output="false" displayname=""  {
	property name='particularService' inject='entityService:Particular';
	// property name='zoneService' inject='entityService:Zone';
	// property name='agentService' inject='entityService:Agent';
	property name='customerService' inject='entityService:Customer';
	property name='languageService' inject='entityService:Languages';
	property name='contactService' inject='entityService:Contact';
	property name='personService'     inject='entityService:person';
	property name='userService' inject='userService';

	public function init(){
		return this;
	}

	function getparticular(event,prc,rc)
	{
		var particulars = [];
		var particularList = EntityLoad('particular');
		for(item in particularList) {
		   var particular = {};
		   particular.id=item.getid_particular();
		   particular.name = item.getpt_name();
		   particular.dni = item.getpt_dni();
		   particular.password = item.getpt_password();
		   particular.mail = item.getpt_mail();
		   particular.zone = isNull(isNull(isNull(item.getCustomer())?"": item.getCustomer().getAgent())?"": item.getCustomer().getAgent().getZone())?"":item.getCustomer().getAgent().getZone().getz_code();
		   particular.zoneID = isNull(isNull(isNull(item.getCustomer())?"": item.getCustomer().getAgent())?"": item.getCustomer().getAgent().getZone())?"":item.getCustomer().getAgent().getZone().getid_Zone();
		   particular.agent = isNull(isNull(item.getCustomer())?"": item.getCustomer().getAgent())?"": item.getCustomer().getAgent().getag_code();
		   particular.agentID = isNull(isNull(item.getCustomer())?"": item.getCustomer().getAgent())?"": item.getCustomer().getAgent().getid_Agent();
		   particular.customer = isNull(item.getCustomer())?"":item.getCustomer().getcs_name();
		   particular.customerID = isNull(item.getCustomer())?"":item.getCustomer().getid_Customer();

		   particular.language = isNull(item.getLanguage())?"":item.getLanguage().getlg_name();
		   particular.languageID = isNull(item.getLanguage())?"":item.getLanguage().getid_language();

		   particular.contact = isNull(item.getContact())?"":item.getContact().getcn_name();
		   particular.contactID = isNull(item.getContact())?"":item.getContact().getid_contact();

		   ArrayAppend(particulars,particular);
		}

		event.renderData(type="json",data=particulars);
	}

	public any function addNew(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_Particular== 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();

				var newParticular = particularService.new({
					  pt_name:rc.name
					, pt_dni:rc.dni
					, pt_password:rc.pass
					, pt_mail:rc.mail
					, customer:rc.customer
					, language:rc.language
					, updated:created
					, created:created
					, user_created:user_created
					, user_updated:user_created
				});

				var contact = contactService.get(rc.contact);
				contact.setDraft(0);
				newParticular.setContact(contact);
				contactService.save(contact);
				var result = particularService.save(newParticular);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new particular successfully' , 'groupId' : newParticular.getid_particular(),'part_Name': newParticular.getpt_mail()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add particular failed !' });
			}else{
				var particular = particularService.get(rc.id_Particular);
				var user_updated = userService.getLoggedInUser();
				var updated = now();

				particular.setUser_Updated(user_updated);
				particular.setUpdated(updated);
				particular.setpt_name(rc.name);
				particular.setpt_dni(rc.dni);
				particular.setpt_password(rc.pass);
				particular.setpt_mail(rc.mail);
				particular.setcustomer(customerService.get(rc.customer));
				particular.setlanguage(languageService.get(rc.language));
				particular.setcontact(contactService.get(rc.contact));
				var result = particularService.save(particular);

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update particular status successfully' ,'part_Name': particular.getpt_mail()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update particular status failed !' });
			}
		}
	}

	function delete(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			// var getParticular = particularService.get(rc.particularID);
			// particularService.delete(getParticular,true);
			// event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete particular success' });

			var getParticular = particularService.get(rc.particularID);
			particularService.delete(getParticular,true);
			if(!isNull(getParticular.getContact())){
				var getIDContact = getParticular.getContact().getid_contact();
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
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete particular successfully' });
		}
	}

	function checkExistCode(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var result = QueryExecute("select count(*) as count from #rc.table# WHERE #rc.nameCol#=:code",{code=rc.code});
			if(result.count == 0)
				event.renderData(type="json",data={ 'success' : false });
			else
				event.renderData(type="json",data={ 'success' : true });
		}
	}
}