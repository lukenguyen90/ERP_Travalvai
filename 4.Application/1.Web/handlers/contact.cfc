/**
*
* @file  /E/projects/source/handlers/contact.cfc
* @author  Vo Hanh Tan
* @description 14/04/2016
*
*/

component output="false" displayname=""  {
	property name='contactService' inject='contactService';
	property name='userService' inject='userService';

	public function init(){
		return this;
	}

	function getcontacts(event,prc,rc)
	{
		var contacts = [];
		if(structKeyExists(rc, "id"))
		{
			if(rc.id != 0){
				var contactList = contactService.getContact(rc.id);
			}else{
				var getIdContactFromZone = contactService.getIdContactFromZone();
				var contactList = contactService.getContact(getIdContactFromZone);
			}
		}else{
			var getIdContactFromZone = contactService.getIdContactFromZone();
			var contactList = contactService.getContact(getIdContactFromZone);
		}

		count = 1;
		for(item in contactList) {
		   var contact = {};
		   contact.id 			= item.id_contact;
		   contact.count 		= count++;
		   contact.name 		= item.cn_name;
		   contact.address_1 	= item.cts_address_1;
		   contact.address_2 	= item.cts_address_2;
		   contact.address_3 	= item.cts_address_3;
		   contact.city 		= item.cts_city;
		   contact.province 	= item.cts_province;
		   contact.zip_code 	= item.cts_zip_code;
		   contact.country 		= item.cts_country;
		   contact.phone 		= item.cts_phone;
		   contact.email 		= item.cts_email;
		   contact.vat_code 	= item.cts_vat_code;
		   contact.notes 		= item.cts_notes;
		   contact.typeid 		= item.cts_type;
		   switch(item.cts_type){
		   	case 1:
		   		contact.type = "Factory";
		   	break;

		   	case 2:
		   		contact.type = "Zone";
		   	break;

		   	case 3:
		   		contact.type = "Agent";
		   	break;

		   	case 4:
		   		contact.type = "Customer";
		   	break;

		   	case 5:
		   		contact.type = "User";
		   	break;

		   	default:
		   		contact.type = "";

		   	break;
		   }
		   contact.sh_name = item.cts_sh_name;
		   contact.sh_address_1 = item.cts_sh_address_1;
		   contact.sh_address_2 = item.cts_sh_address_2;
		   contact.sh_address_3 = item.cts_sh_address_3;
		   contact.sh_city = item.cts_sh_city;
		   contact.sh_province = item.cts_sh_province;
		   contact.sh_zip_code = item.cts_sh_zip_code;
		   ArrayAppend(contacts,contact);
		}

		event.renderData(type="json",data=contacts);
	}

	public any function addNewContact(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_Contact== 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();
				var newContact = contactService.new({cn_name:rc.name, cts_address_1:rc.address_1, cts_address_2:rc.address_2, cts_address_3:rc.address_3,
													cts_city:rc.city, cts_province:rc.province, cts_zip_code:rc.zip_code, cts_country:rc.country,
													cts_phone:rc.phone, cts_email:rc.email, cts_vat_code:rc.vat_code, cts_notes:rc.notes,
													cts_type:rc.type, cts_sh_name:rc.sh_name, cts_sh_address_1:rc.sh_address_1, cts_sh_address_2:rc.sh_address_2, cts_sh_address_3:rc.sh_address_3,
													cts_sh_city:rc.sh_city, cts_sh_province:rc.sh_province, cts_sh_zip_code:rc.sh_zip_code,updated:created,created:created,user_created:user_created,user_updated:user_created});
				var result = contactService.save(newContact);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new contact successfully' , 'groupId' : newContact.getid_contact()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new Contact failed !' });
			}else{
				var Contact = contactService.get(rc.id_Contact);

				var user_updated = userService.getLoggedInUser();
				var updated = now();

				Contact.setUser_Updated(user_updated);
				Contact.setUpdated(updated);
				Contact.setcn_name(rc.name);
				Contact.setcts_address_1(rc.address_1);
				Contact.setcts_address_2(rc.address_2);
				Contact.setcts_address_3(rc.address_3);
				Contact.setcts_city(rc.city);
				Contact.setcts_province(rc.province);
				Contact.setcts_zip_code(rc.zip_code);
				Contact.setcts_country(rc.country);
				Contact.setcts_phone(rc.phone);
				Contact.setcts_email(rc.email);
				Contact.setcts_vat_code(rc.vat_code);
				Contact.setcts_notes(rc.notes);
				Contact.setcts_type(rc.type);
				Contact.setcts_sh_name(rc.sh_name);
				Contact.setcts_sh_address_1(rc.sh_address_1);
				Contact.setcts_sh_address_2(rc.sh_address_2);
				Contact.setcts_sh_address_3(rc.sh_address_3);
				Contact.setcts_sh_city(rc.sh_city);
				Contact.setcts_sh_province(rc.sh_province);
				Contact.setcts_sh_zip_code(rc.sh_zip_code);

				var result = contactService.save(Contact);

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update contact successfully' , 'groupId' : Contact.getid_contact() });
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update contact failed !' });
			}
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

	public any function contact(event, rc, prc){
		var check = QueryExecute (" select id_Contact from contact where draft = 1");
		if (check.recordcount > 0){
			for(item in check){
				//set id_contact = null on agent table
				QueryExecute("
					UPDATE agent SET id_contact = null
					where id_contact = #item.id_contact#
				");

				//set id_contact = null on shipment_information table
				QueryExecute("
					UPDATE shipment_information SET id_contact = null
					where id_contact = #item.id_contact#
				");
			}
			//delete contact on contact table
			QueryExecute("DELETE FROM contact WHERE draft = 1");
		}
	}
}