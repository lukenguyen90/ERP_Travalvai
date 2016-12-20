component output="false" {

	property name='freightService' 	inject="entityService:freight";
	property name='userService' inject='userService';


	public function init(){
		return this;
	}

	public any function getInfor(event,rc,prc) {
		result={};

		if(structKeyExists(rc,"id_freight"))
		{
			var resultfreight = freightService.get(id=rc.id_freight,returnNew = true);

			result.id          = resultfreight.getid_freight();
			result.description = resultfreight.getfr_description();
		}
		event.renderData(type="json",data=result);
	}



	public function addNew(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_freight == 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();

				var newFreight = freightService.new({fr_description:rc.description,updated:created,created:created,user_created:user_created,user_updated:user_created});
				var result = freightService.save(newFreight);
				if(result){
					event.renderData(type="json",data={"success":true,"message":"Adding freight is successfully",'freightId' : newFreight.getid_freight()});
				}else {
					event.renderData(type="json",data={"success":false,"message":"Adding freight is failed"});
				}
			}else{
				var Freight = freightService.get(rc.id_freight);

				var user_updated = userService.getLoggedInUser();
				var updated = now();

				Freight.setUser_Updated(user_updated);
				Freight.setUpdated(updated);
				Freight.setfr_description(rc.description);

				var result = freightService.save(Freight);
				if(result){
					event.renderData(type="json",data={"success":true,"message":"Updating freight is successful"});
				}else{
					event.renderData(type="json",data={"success":false,"message":"Updating freight is failed"});
				}
			}
		}
	}


	public any function delete(event, rc, prc) {

		if(event.GETHTTPMETHOD() == "POST"){
			var getfreight = freightService.get(id=rc.id_freight);
			freightService.delete(getfreight,true);
			event.renderData(type="json",data={"success": true,"message":"Delete freight successfully"});
		}
	}


}