/**
*
* @file  /E/projects/source/handlers/contact.cfc
* @author  Vo Hanh Tan
* @description 14/04/2016
*
*/

component output="false" displayname=""  {
	property name='materialService' 	inject='entityService:materials';
	property name='GmatService' 		inject='entityService:group_materials';
	property name='userService' 		inject='userService';

	public function init(){
		return this;
	}

function getmaterials(event,prc,rc)
	{
		var materials = [];
		if(structKeyExists(rc, "id"))
		{
			if(rc.id != 0){
				var contactList = EntityLoad('materials',{Id_mat:rc.id});
			}else{
				var contactList = EntityLoad('materials');
			}
		}else{
			var contactList = EntityLoad('materials');
		}
		for(item in contactList) {
		   var m = {
				"Id_mat"          : item.getId_mat(),
				"mat_code"        : item.getMat_code(),
				"mat_description" : item.getMat_description(),
				"id_unit"         : item.getId_unit(),
				"mat_price"       : item.getMat_price(),
				"mat_date"        : dateformat(item.getMat_date(),"dd/MM/yyyy"),
				"factory"         : item.getFactory().getId_Factory(),
				"group_material"  : item.getGroup_materials().getId_group_mat()
		   };

		   ArrayAppend(materials,m);
		}

		event.renderData(type="json",data=materials);
	}

	public any function addEdit(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_Contact== 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();

				var newMaterial = materialService.new({
					  mat_code: rc.mat_code
					, mat_description: rc.mat_description
					, id_unit: rc.id_unit
					, mat_price: rc.mat_price
					, mat_date: rc.mat_date
					, created: rc.created
					, updated: rc.updated
					, factory: rc.factory
					, user_created: rc.user_created
					, user_updated: rc.user_updated
					});

				var groupMat = GmatService.get(id=rc.group_material);
				newMaterial.setGroup_materials(newMaterial);

				var f = GmatService

				var result = materialService.save(newMaterial);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new contact successfully' , 'groupId' : newMaterial.getId_mat()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new Contact failed !' });
			}else{
				var material = materialService.get(rc.id_mat);

				var user_updated = userService.getLoggedInUser();
				var updated = now();

				var result = materialService.save(Contact);

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update contact successfully' , 'groupId' : Contact.getid_contact() });
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update contact failed !' });
			}
		}
	}

	function deleteMat(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			""
		}
	}
}