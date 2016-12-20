/**
*
* @file  /E/projects/source/handlers/zone.cfc
* @author
* @description
*
*/

component output="false" displayname=""  {
	property name='languagesService' inject='entityService:Languages';
	property name='userService' inject='userService';

	public function init(){
		return this;
	}

	public any function getInfor(event,rc,prc) {
		var result = {};
		if(structKeyExists(rc, "id_Zone"))
		{
			var resultQuery = languagesService.get(id=rc.id_Zone,returnNew=true);
			result.id_Zone = resultQuery.getid_Zone();
			result.z_code = resultQuery.getz_code();
			result.z_description = resultQuery.getz_description();
			result.currency = isNull(resultQuery.getCurrency())?0:resultQuery.getCurrency().getid_currency();
			result.language = isNull(resultQuery.getLanguage())?0:resultQuery.getLanguage().getid_language();
		}
		event.renderData(type="json",data=result);
	}

	public any function addNew(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id == 0)
			{
				// var user_created = userService.getLoggedInUser();
				// var created = now();

				// var newLang = languagesService.new({lg_code:rc.code,lg_name:rc.description,updated:created,created:created,user_created:user_created,user_updated:user_created});
				// var result = languagesService.save(newLang);
				// if(result)
				// 	event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new language success' , 'langId' : newLang.getid_language(),'lang_Code': newLang.getlg_code()});
				// else
				 	event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new language failed !' });
			}
			else
			{
				var lang = languagesService.get(rc.id);
				var user_updated = userService.getLoggedInUser();
				var updated = now();

				lang.setUser_Updated(user_updated);
				lang.setUpdated(updated);
				lang.setlg_code(rc.code);
				lang.setlg_name(rc.description);
				var result = languagesService.save(lang);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update language successfully','lang_Code': lang.getlg_code()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update language failed !' });
			}
		}
	}


	// function delete(event,rc,prc)
	// {
	// 	if(event.GETHTTPMETHOD() == "POST")
	// 	{
	// 		var getLang = languagesService.get(rc.id);
	// 		languagesService.delete(getLang,true);
	// 		event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete language success' });
	// 	}
	// }
}