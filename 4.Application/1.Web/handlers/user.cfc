/**
*
* @file  /E/projects/source/handlers/user.cfc
* @author
* @description
*
*/

component output="false" displayname=""  {
	property name='userService'     		inject='userService';
	property name='factoryService'     		inject='entityService:factory';
	property name='zoneService'     		inject='entityService:zone';
	property name='agentService'     		inject='entityService:agent';
	property name='customerService'     	inject='entityService:customer';
	property name='access_levelService'     inject='entityService:access_level';
	property name='contactService'     		inject='entityService:contact';
	property name='personService'     		inject='entityService:person';
	property name='languageService'    		inject='entityService:languages';

	public function init(){
		return this;
	}


	public any function getUser(event,rc,prc) {
		var users = [];
		var typeOfLogInUser = userService.getUserLevel();
		if(typeOfLogInUser == 0){
			var userList = EntityLoad('user');
		}
		else if(typeOfLogInUser == 1){
			var factory = userService.getLoggedInUser().getfactory();
			var userList = EntityLoad('user',{factory = factory});
		}
		else if(typeOfLogInUser == 2){
			var zone = userService.getLoggedInUser().getZone();
			var userList = EntityLoad('user',{zone = zone});
		}
		else if(typeOfLogInUser == 3)
		{
			var agent = userService.getLoggedInUser().getAgent();
			var userList = EntityLoad('user',{agent = agent});
		}
		else if(typeOfLogInUser == 4){
			var customer = userService.getLoggedInUser().getCustomer();
			var userList = EntityLoad('user',{customer = customer});
		}
		else{
			var userList = {};
		}
		var logID = userService.getLoggedInUser().getid_user();
		var count = 1;
		for(item in userList){
			var user            = {};
			user.id             = item.getid_user();
			user.count 			= count;
			user.name           = item.getuser_name();
			user.position       = item.getuser_position();
			user.password       = item.getuser_password();
			user.factory        = isNull(item.getfactory())?"":item.getfactory().getfty_code();
			user.factoryid      = isNull(item.getfactory())?"":item.getfactory().getid_Factory();
			user.zone   	    = isNull(item.getzone())?"":item.getzone().getz_code();
			user.zoneid   	    = isNull(item.getzone())?"":item.getzone().getid_Zone();
			user.agent          = isNull(item.getagent())?"":item.getagent().getag_code();
			user.agent_des        = isNull(item.getagent())?"":item.getagent().getag_description();
			user.customer       = isNull(item.getcustomer())?"":item.getcustomer().getcs_name();
			user.customerid     = isNull(item.getcustomer())?"":item.getcustomer().getid_Customer();
			user.access_level   = isNull(item.getaccess_level())?"":item.getaccess_level().getal_name();
			user.access_levelid = isNull(item.getaccess_level())?"":item.getaccess_level().getid_access_level();
			user.contact        = isNull(item.getContact())?"":item.getContact().getcn_name();
			user.contactid      = isNull(item.getContact())?"":item.getContact().getid_contact();
			user.idlanguage 	= isNull(item.getLanguage())?"":item.getLanguage().getId_language();
			user.lgName 		= isNull(item.getLanguage())?"":item.getLanguage().getLg_name();
			if(logID == item.getid_user()){
				user.logID = logID;
			}
			ArrayAppend(users,user);
			count = count + 1;
		}
		event.renderData(type="json",data=users);
	}

	public any function getusersetting(event,rc,prc) {
		// "select * from usersetting LEFT JOIN user on usersetting.id_USetting = user.id_user"
		var users = [];
		var typeOfLogInUser = userService.getUserLevel();
		if(typeOfLogInUser == 0){
			var userList = EntityLoad('user');
		}
		else if(typeOfLogInUser == 1){
			var factory = userService.getLoggedInUser().getfactory();
			var userList = EntityLoad('user',{factory = factory});
		}
		else if(typeOfLogInUser == 2){
			var zone = userService.getLoggedInUser().getZone();
			var userList = EntityLoad('user',{zone = zone});
		}
		else if(typeOfLogInUser == 3)
		{
			var agent = userService.getLoggedInUser().getAgent();
			var userList = EntityLoad('user',{agent = agent});
		}
		else if(typeOfLogInUser == 4){
			var customer = userService.getLoggedInUser().getCustomer();
			var userList = EntityLoad('user',{customer = customer});
		}
		else{
			var userList = {};
		}
		var arrayid_user = [];
		// listAppend("list", "value", [delimiters])
		for(item in userList){
			ArrayAppend(arrayid_user, item.getid_user());
		}
		var myList = ArrayToList(arrayid_user, ",");
		if(myList == ""){
			myList = "0";
		}

		var usersetting = ORMExecuteQuery("from usersetting where id_user_setting in (#myList#)");
		var count = 1;
		for(item in usersetting){
			var user            = {};
			user.id             = item.getid_USetting();
			user.userid        	= isNull(item.getuser())?"":item.getuser().getid_user();
			user.user 	        = isNull(item.getuser())?"":item.getuser().getuser_name();
			user.language       = isNull(item.getLanguage())?"":item.getLanguage().getlg_name();
			user.languageid     = isNull(item.getLanguage())?"":item.getLanguage().getid_language();
			ArrayAppend(users,user);
			count = count + 1;
		}
		event.renderData(type="json",data=users);
	}

	function addNew(event,prc,rc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id==0)
			{
				var newUser = userService.new({
												  user_name:rc.name
												, user_position:rc.position
												, user_password:rc.pass
											});
				if(rc.language != ""){
					var ulang = languageService.get(id=rc.language);
					newUser.setLanguage(ulang);
				}

				if(rc.access_level != ""){
					newUser.setaccess_level(access_levelService.get(rc.access_level));
				}

				if(rc.contact != ""){
					var ctact = contactService.get(rc.contact);
					ctact.setDraft(0);
					newUser.setcontact(ctact);
					contactService.save(ctact);

				}

				//Set Factory, Zone, Agent, Customer for new user. if the the rc.factory,rc.zone is empty, but the field can not be null
				var userLoggedInType=userService.getUserLevel();
				if(userLoggedInType eq 0){
					if(rc.factory != "")
					{
						newUser.setfactory(factoryService.get(rc.factory));
						if(rc.zone != ""){
						newUser.setzone(zoneService.get(rc.zone));
						if(rc.agent != ""){
							newUser.setagent(agentService.get(rc.agent));
							if(rc.customer != ""){
								newUser.setcustomer(customerService.get(rc.customer));
							}
						}
					}
					}
				}else if(userLoggedInType eq 1){
					factoryLoggedIn = userService.getFactoryValueOfUser();
					newUser.setfactory(factoryService.get(factoryLoggedIn));

					if(rc.zone != ""){
						newUser.setzone(zoneService.get(rc.zone));
						if(rc.agent != ""){
							newUser.setagent(agentService.get(rc.agent));
							if(rc.customer != ""){
								newUser.setcustomer(customerService.get(rc.customer));
							}
						}
					}
				}else if(userLoggedInType eq 2){
					factoryLoggedIn = userService.getFactoryValueOfUser();
					newUser.setfactory(factoryService.get(factoryLoggedIn));

					zoneLoggedIn =  userService.getZoneValueOfUser();
					newUser.setzone(zoneService.get(zoneLoggedIn));

					if(rc.agent != ""){
						newUser.setagent(agentService.get(rc.agent));
						if(rc.customer != ""){
							newUser.setcustomer(customerService.get(rc.customer));
						}
					}
				}else if(userLoggedInType eq 3){
					factoryLoggedIn = userService.getFactoryValueOfUser();
					newUser.setfactory(factoryService.get(factoryLoggedIn));

					zoneLoggedIn =  userService.getZoneValueOfUser();
					newUser.setzone(zoneService.get(zoneLoggedIn));

					agentLoggedIn =  userService.getAgentValueOfUser();
					newUser.setagent(agentService.get(agentLoggedIn));

					if(rc.customer != ""){
						newUser.setcustomer(customerService.get(rc.customer));
					}
				}
				var result = userService.save(newUser);

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new User successfully' , 'Id' : newUser.getid_user(), 'username':newUser.getuser_name()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new User failed !' });
			}
			else
			{
				var user = userService.get(rc.id);
				user.setuser_name(rc.name);
				user.setuser_position(rc.position);
				user.setuser_password(rc.pass);
				// user.setfactory( rc.factory != ""?factoryService.get(rc.factory):javacast("null",""));

				if(rc.language != ""){
					var ulang = languageService.get(id=rc.language);
					user.setLanguage(ulang);
				}

				if(rc.factory != ""){
					user.setfactory(factoryService.get(rc.factory));
					if(rc.zone != ""){
						user.setzone(zoneService.get(rc.zone));
						if(rc.agent != ""){
							user.setagent(agentService.get(rc.agent));
							if(rc.customer != ""){
								user.setcustomer(customerService.get(rc.customer));
							}
						}
					}
				}
				if(rc.access_level != ""){
					user.setaccess_level(access_levelService.get(rc.access_level));
				}

				if(rc.contact != ""){
					var ctact = contactService.get(rc.contact);
					ctact.setDraft(0);
					user.setcontact(contactService.get(rc.contact));
					contactService.save(ctact);
				}
				var result = userService.save(user);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update user successfully', 'username':user.getuser_name()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update user failed !' });
			}
		}
	}


	function delete(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var logID 	= userService.getLoggedInUser().getid_user();
			if(logID != rc.id){
				var getUser = userService.get(rc.id);
				var contact = getUser.getContact();
				getUser.setfactory(entityLoad('user', {id_user: 0},true));
				getUser.setlanguage(entityLoad('user', {id_user: 0},true));
				getUser.setzone(entityLoad('user', {id_user: 0},true));
				getUser.setagent(entityLoad('user', {id_user: 0},true));
				getUser.setcustomer(entityLoad('user', {id_user: 0},true));
				getUser.setaccess_level(entityLoad('user', {id_user: 0},true));
				getUser.setcontact(entityLoad('user', {id_user: 0},true));
				userService.save(getUser);
				var deleteUser = userService.deleteByID(rc.id);
				if(!isNull(contact)){
					var getIDContact = contact.getid_contact();

					var listpersons = EntityLoad("person", {contact = EntityLoadByPK("contact",getIDContact)});
					if(!isNull(listpersons)){
						for(person in listpersons){
							var per = personService.get(person.getid_person());
							personService.delete(per,true);
						}
					}
					var deleteContact = contactService.delete(contact,true);
				}
				event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete user successfully!' });
			}else{
				event.renderData(type="json",data={ 'success' : false , 'message' : 'Can not delete this user!' });
			}
		}
	}

}