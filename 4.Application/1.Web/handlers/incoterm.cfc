component output="false" {

	property name='incotermService' 	inject="entityService:incoterm";
	property name='userService' inject='userService';

	public function init(){
		return this;
	}

	public any function getInfor(event,rc,prc) {
		result={};

		if(structKeyExists(rc,"id_incoterm"))
		{
			var resultict = incotermService.get(id=rc.id_incoterm,returnNew = true);

			result.id          = resultict.getid_incoterm();
			result.code        = resultict.getict_code();
			result.description = resultict.getict_description();
		}
		event.renderData(type="json",data=result);
	}



	public function addNew(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_incoterm == 0){
				var user_created = userService.getLoggedInUser();
				var created = now();

				var newico = incotermService.new({ict_code:rc.code, ict_description:rc.description,updated:created,created:created,user_created:user_created,user_updated:user_created});
				var result = incotermService.save(newico);
				if(result){
					event.renderData(type="json",data={"success":true,"message":"Adding incoterm is successfully"});
				}else {
					event.renderData(type="json",data={"success":false,"message":"Adding incoterm is failed"});
				}
			}else{
				var ico = incotermService.get(rc.id_incoterm);

				var user_updated = userService.getLoggedInUser();
				var updated = now();

				ico.setUser_Updated(user_updated);
				ico.setUpdated(updated);
				ico.setict_code(rc.code);
				ico.setict_description(rc.description);
				
				var result = incotermService.save(ico);
				if(result){
					event.renderData(type="json",data={"success":true,"message":"Updating incoterm is successful"});
				}else{
					event.renderData(type="json",data={"success":false,"message":"Updating incoterm is failed"});
				}
			}
		}
	}


	public any function delete(event, rc, prc) {

		if(event.GETHTTPMETHOD() == "POST"){
			var getico = incotermService.get(id=rc.id_incoterm);
			incotermService.delete(getico,true);
			event.renderData(type="json",data={"success": true,"message":"Delete incoterm successfully"})
		}
	}


}