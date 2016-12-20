component output="false" {

	property name='currencyService' 	inject="entityService:currency";
	property name='languagesService' 	inject="entityService:Languages";
	property name='contactService' 		inject="entityService:Contact";
	property name='factoryService' 		inject="entityService:factory";
	property name='personService'     inject='entityService:person';
	property name='userService' inject='userService';

	public function init(){
		return this;
	}

	public any function getInfor(event,rc,prc) {
		var result={};

		if(structKeyExists(rc,"id_Factory"))
		{
			var resultfactory = factoryService.get(id=rc.id_Factory,returnNew = true);

			result.id          = resultfactory.getid_Factory();
			result.code        = resultfactory.getfty_code();
			result.description = resultfactory.getfty_description();
			result.Currency    = isNull(resultfactory.getcurrency())?0:resultfactory.getcurrency().getcurr_code();
			result.Languages   = isNull(resultfactory.getlanguages())?0:resultfactory.getlanguages().getlg_name();
			result.Contact     = isNull(resultfactory.getcontact())?0:resultfactory.getcontact().getcn_name();
		}
		event.renderData(type="json",data=result);
	}


	public function addNew(event,rc,prc){

		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_Factory == 0){
				var user_created = userService.getLoggedInUser();
				var created = now();

				var newFac = factoryService.new({
					  fty_code:rc.code
					, fty_description:rc.description
					, currency:rc.currency
					, languages:rc.language
					, updated:created
					, created:created
					, user_created:user_created
					, user_updated:user_created
				});

				var contact = contactService.get(rc.contact);
				contact.setDraft(0);
				contactService.save(contact);
				newFac.setContact(contact);

				var result = factoryService.save(newFac);
				if(result){
					event.renderData(type="json",data={"success"=true,"message"="Adding new factory is successfully", 'id_Factory' : newFac.getid_Factory(), 'code_Factory' : newFac.getfty_code() });
				}else {
					event.renderData(type="json",data={"success"=false,"message"="Adding new factory is failed"});
				}
			}else{
				var factory = factoryService.get(id=rc.id_Factory);
				var user_updated = userService.getLoggedInUser();
				var updated = now();

				factory.setUser_Updated(user_updated);
				factory.setUpdated(updated);
				factory.setfty_code(rc.code);
				factory.setfty_description(rc.description);
				factory.setcurrency(currencyService.get(rc.currency));
				factory.setlanguages(languagesService.get(rc.language));
				factory.setcontact(contactService.get(rc.contact));
				factory.setupdated(#LSDateTimeFormat(Now(),'yyyy-mm-dd HH:nn:ss')#);
				factory.setuser_updated(userService.get(SESSION.loggedInUserID));

				var result = factoryService.save(factory);
				if(result)
					event.renderData(type="json",data={ 'success' =true , 'message' ='Update factory successfully', 'code_Factory' : factory.getfty_code() });
				else
					event.renderData(type="json",data={ 'success' =false , 'message' ='Update factory failed !' });
			}
		}
	}



	function delete(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			// var getFactory = factoryService.get(rc.id);
			// factoryService.delete(getFactory,true);
			// event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete factory success' });

			var getFactory = factoryService.get(rc.id);
			factoryService.delete(getFactory,true);
			if(!isNull(getFactory.getContact())){
				var getIDContact = getFactory.getContact().getid_contact();
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
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete factory successfully' });
		}
	}
}