/**
*
* @file  /E/projects/source/handlers/angent.cfc
* @author
* @description
*
*/

component output="false" displayname=""  {
	property name='accessService' inject='entityService:access_level';
	property name='access_pageService' 			inject="entityService:access_page";
	property name='userService'     inject='userService';
	public function init(){
		return this;
	}

	public any function getaccess_level(event,rc,prc) {
		var access_levels = [];
		var access_levelList = EntityLoad('access_level');
		var count = 0;
		for(item in access_levelList){
			var access_level         = {};
			access_level.id          = item.getid_access_level();
			access_level.right 		 = item.getal_right();
			access_level.name        = item.getal_name();
			count++;
			access_level.count       = count;
			ArrayAppend(access_levels,access_level);
		}
		event.renderData(type="json",data=access_levels);
	}

	function addNewRole(event,prc,rc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id == 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();

				var newRole = accessService.new({al_name:rc.name,updated:created,created:created,user_created:user_created,user_updated:user_created});
				var result = accessService.save(newRole);
				if(result){
					updateDataAccess_level(newRole.getid_access_level());
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new role successfully' , 'lang_Code': newRole.getal_name()});
				}
				else{
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new role failed !' });
				}
			}
			else
			{
				var role = accessService.get(rc.id);
				var user_updated = userService.getLoggedInUser();
				var updated = now();

				role.setUser_Updated(user_updated);
				role.setUpdated(updated);
				role.setal_name(rc.name);
				var result = accessService.save(role);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update role successfully','lang_Code': role.getal_name()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update role failed !' });
			}
		}
	}
	function updateDataAccess_level(id){
		var listAccess_Pages = access_pageService.list(asQuery=false);
		var pageRights = [];

		for(page in listAccess_Pages){
			pageAppend= {
				"name" = "",
				"right" = {
					  "open"   = false
					, "edit"   = false
					, "delete" = false
				}
			};
			var idPage = trim(page.getIdPage());
			pageAppend.name = idPage
			arrayAppend(pageRights,pageAppend);
		}
		var al_right = SerializeJson(pageRights);
		var role = accessService.get(id);
		role.setal_right(al_right);
		accessService.save(role);
	}

	function update(event,prc,rc)
	{
		var arraydata = [];
		arraydata = DeserializeJson(rc.data);
		for(al in arraydata){
			for(sup_al in al.right){
				StructDelete(sup_al, "$$hashKey");
			}
			var access = accessService.get(al.id);
			access.setal_right(SerializeJSON(al.right));
			var result = accessService.save(access);
		}
		event.renderData(type="json",data={'success' : true , 'message' : 'Success'});
	}

	function delete(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var getLang = accessService.get(rc.id);
			accessService.delete(getLang,true);
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete role successfully' });
		}
	}
}