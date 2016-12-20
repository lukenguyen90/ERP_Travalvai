/**
*
* @file  /E/projects/source/handlers/zone.cfc
* @author
* @description
*
*/

component output="false" displayname=""  {
	 property  name='zoneService'       inject='entityService:Zone';
	 property  name='factoryService'    inject='entityService:Factory';
	 property  name='currencyService'   inject="entityService:Currency";
	 property  name='languagesService'  inject='entityService:Languages';
	 property  name='contactService'    inject='entityService:Contact';
	 property  name='personService'     inject='entityService:person';
	 property  name='userService'      	inject='userService';

	public function init(){
		return this;
	}

	public any function getInfor(event,rc,prc) {
		var result = {};
		if(structKeyExists(rc, "id_Zone"))
		{
			var resultQuery = zoneService.get(id=rc.id_Zone,returnNew=true);
			result.id_Zone = resultQuery.getid_Zone();
			result.z_code = resultQuery.getz_code();
			result.z_description = resultQuery.getz_description();
			result.factory  = isNull(resultQuery.getFactory())?0:resultQuery.getFactory().getid_Factory();
			result.currency = isNull(resultQuery.getCurrency())?0:resultQuery.getCurrency().getid_currency();
			result.language = isNull(resultQuery.getLanguage())?0:resultQuery.getLanguage().getid_language();
			result.contact  = isNull(resultQuery.getContact())?0:resultQuery.getContact().getid_contact();
		}
		event.renderData(type="json",data=result);
	}

	public any function addNew(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_Zone== 0)
			{
				var user_created = userService.getLoggedInUser();
				var user_updated = user_created;
				var created = now();
				var updated = created;
				if(rc.contact != ""){
					var ctact = contactService.get(rc.contact);
					ctact.setDraft(0);
					contactService.save(ctact);
				}
				var newZone = zoneService.new({z_code:rc.code,z_description:rc.description,currency:rc.currency,language:rc.language,contact:rc.contact,created:created,updated:updated, user_created:user_created,user_updated:user_updated});

				var userLoggedInType=userService.getUserLevel();

				if(userLoggedInType eq 1){
					factoryLoggedIn = userService.getFactoryValueOfUser();
					newZone.setfactory(factoryService.get(factoryLoggedIn));
				}

				var result = zoneService.save(newZone);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new zone successfully' , 'zoneId' : newZone.getid_Zone(), 'code_Zone': newZone.getZ_code()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new zone failed !' });
			}else{
				var zone = zoneService.get(rc.id_Zone);
				zone.setZ_code(rc.code);
				zone.setZ_description(rc.description);
				zone.setFactory(factoryService.get(rc.factory));
				zone.setCurrency(currencyService.get(rc.currency));
				zone.setLanguage(languagesService.get(rc.language));
				zone.setcontact(contactService.get(rc.contact));
				zone.setupdated(#LSDateTimeFormat(Now(),'yyyy-mm-dd HH:nn:ss')#);
				zone.setuser_updated(userService.get(SESSION.loggedInUserID));

				if(rc.contact != ""){
					var ctact = contactService.get(rc.contact);
					ctact.setDraft(0);
					contactService.save(ctact);
				}

				var result = zoneService.save(zone);

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update zone successfully', 'code_Zone': zone.getZ_code()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update zone failed !' });
			}
		}
	}

	function delete(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			// var getZone = zoneService.get(rc.zId);
			// zoneService.delete(getZone,true);
			// event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete zone successfully' });

			var getZone = zoneService.get(rc.zId);
			zoneService.delete(getZone,true);
			if(!isNull(getZone.getContact())){
				var getIDContact = getZone.getContact().getid_contact();
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
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete zone successfully' });
		}
	}




}