component output="false" {

	property name='shipmenttypeService' 	inject="entityService:shipment_type";
	property name='userService' inject='userService';

	public function init(){
		return this;
	}

	public any function getInfor(event,rc,prc) {
		result={};

		if(structKeyExists(rc,"id_shipment_type"))
		{
			var resultshipt = shipmenttypeService.get(id=rc.id_shipment_type,returnNew = true);

			result.id          = resultshipt.getid_shipment_type();
			result.code        = resultshipt.getict_code();
			result.description = resultshipt.getict_description();
		}
		event.renderData(type="json",data=result);
	}



	public function addNew(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_shipment_type == 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();

				var newshipt = shipmenttypeService.new({st_code:rc.code, st_description:rc.description,updated:created,created:created,user_created:user_created,user_updated:user_created});

				var result = shipmenttypeService.save(newshipt);
				if(result)
				{
					event.renderData(type="json",data={"success":true,"message":"Adding shipment type is successfully"});
				}

				else 
				{
					event.renderData(type="json",data={"success":false,"message":"Adding shipment type is failed"});
				}
			}
			else
			{
				var shipt = shipmenttypeService.get(rc.id_shipment_type);
				var user_updated = userService.getLoggedInUser();
				var updated = now();

				shipt.setUser_Updated(user_updated);
				shipt.setUpdated(updated);
				shipt.setst_code(rc.code);
				shipt.setst_description(rc.description);

				var result = shipmenttypeService.save(shipt);
				if(result)
				{
					event.renderData(type="json",data={"success":true,"message":"Updating shipment type is successful"});
				}
				else
				{
					event.renderData(type="json",data={"success":false,"message":"Updating shipment type is failed"});
				}
			}
		}
	}

	public any function delete(event, rc, prc) {
		if(event.GETHTTPMETHOD() == "POST"){
			var getshipt = shipmenttypeService.get(id=rc.id_shipment_type);
			shipmenttypeService.delete(getshipt,true);
			event.renderData(type="json",data={"success": true,"message":"Delete shipment type successfully"});
		}
	}
}