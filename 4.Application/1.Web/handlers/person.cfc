/**
*
* @file  /E/projects/source/handlers/person.cfc
* @author  Vo Hanh Tan
* @description 14/04/2016
*
*/

component output="false" displayname=""  {
	property name='personService' inject='entityService:Person';
	property name='contactService' inject='entityService:Contact';
	property name='userService' inject='userService';

	public function init(){
		return this;
	}

	function getperson(event,prc,rc)
	{
		if(structKeyExists(URL, "idcontact")){
			var personList = EntityLoad('person', {contact=EntityLoadByPK("contact",URL.idcontact)});
			var persons = [];
			for(item in personList) {
			   	var person = {};
			   	person.id = item.getid_person();
			   	person.name = item.getcts_p_name();
			   	person.pos = item.getcts_p_position();
			   	person.phone = item.getcts_p_phone();
			   	person.email = item.getcts_p_email();
			   	person.note = item.getcts_p_notes();
			   	// person.bday = #LSDATEFORMAT(item.getcts_p_bday(),'dd/mm/yyyy')#;
			   	person.bdayformat = #LSDATEFORMAT(item.getcts_p_bday(),'mm/dd/yyyy')#;
			   	person.bday = item.getcts_p_bday();
				person.contact = isNull(item.getcontact())?"":item.getcontact().getcn_name();
			   	person.contactId = isNull(item.getcontact())?"":item.getcontact().getid_contact();

			   	ArrayAppend(persons,person);
			}

			event.renderData(type="json",data=persons);
		}else{
			var persons = [];
			// var personList = EntityLoad('person');
			// for(item in personList) {
			//    	var person = {};
			//    	person.id = item.getid_person();
			//    	person.name = item.getcts_p_name();
			//    	person.pos = item.getcts_p_position();
			//    	person.phone = item.getcts_p_phone();
			//    	person.email = item.getcts_p_email();
			//    	person.note = item.getcts_p_notes();
			//    	// person.bday = #LSDATEFORMAT(item.getcts_p_bday(),'dd/mm/yyyy')#;
			//    	person.bdayformat = #LSDATEFORMAT(item.getcts_p_bday(),'mm/dd/yyyy')#;
			//    	person.bday = item.getcts_p_bday();
			// 	person.contact = isNull(item.getcontact())?"":item.getcontact().getcn_name();
			//    	person.contactId = isNull(item.getcontact())?"":item.getcontact().getid_contact();

			//    	ArrayAppend(persons,person);
			// }

			event.renderData(type="json",data=persons);
		}
	}

	public any function addNewPerson(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_Person== 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();

				var newPerson = personService.new({
													  cts_p_name:rc.name
													, cts_p_position:rc.position
													, cts_p_phone:rc.phone
													, cts_p_email:rc.email
													, cts_p_notes:rc.note
													, cts_p_bday:rc.bday
													, contact:rc.contactID
													, updated:created
													, created:created
													, user_created:user_created
													,user_updated:user_created
												});
				var result = personService.save(newPerson);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new person successfully' , 'personId' : newPerson.getid_person(), 'name_Person' :  newPerson.getcts_p_name()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new person failed !' });
			}else{
				var person = personService.get(rc.id_person);
				var user_updated = userService.getLoggedInUser();
				var updated = now();

				person.setUser_Updated(user_updated);
				person.setUpdated(updated);
				person.setcts_p_name(rc.name);
				person.setcts_p_position(rc.position);
				person.setcts_p_phone(rc.phone);
				person.setcts_p_email(rc.email);
				person.setcts_p_notes(rc.note);
				person.setcts_p_bday(rc.bday);
				// if(isNull(contactService.get(rc.contactID))){
				// 	person.setContact(contactService.get(rc.contactID));
				// }
				var result = personService.save(person);

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update person successfully', 'name_Person' :  person.getcts_p_name()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update person failed !' });
			}
		}
	}

	function deletePerson(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var getPerson = personService.get(rc.id_Person);
			personService.delete(getPerson,true);
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete person successfully' });
		}
	}

	function checkExistName(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var result = QueryExecute("select count(*) as count from #rc.table# WHERE #rc.nameCol#=:name",{name=rc.name});
			if(result.count == 0)
				event.renderData(type="json",data={ 'success' : false });
			else
				event.renderData(type="json",data={ 'success' : true });
		}
	}
}