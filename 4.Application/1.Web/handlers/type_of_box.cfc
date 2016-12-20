component output="false" {

	property name='type_of_boxService' 	inject="entityService:type_of_box";
	property name='userService' inject='userService';

	public function init(){
		return this;
	}

	public any function getInfor(event,rc,prc) {
		result={};

		if(structKeyExists(rc,"id_type_box"))
		{
			var resulttype_of_box = type_of_boxService.get(id=rc.id_type_box,returnNew = true);

			result.id          = resulttype_of_box.getid_type_box();
			result.description = resulttype_of_box.gettb_description();
			result.depth 	   = resulttype_of_box.gettb_depth();
			result.length 	   = resulttype_of_box.gettb_length();
			result.width 	   = resulttype_of_box.gettb_width();
		}
		event.renderData(type="json",data=result);
	}



	public function addNew(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_type_box == 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();
				var description = rc.description &' ' & '(' & rc.depth & '*' & rc.length &'*' & rc.width & ')';
				var newtb = type_of_boxService.new({tb_description:description, tb_depth:rc.depth, tb_length:rc.length, tb_width:rc.width, updated:created,created:created,user_created:user_created,user_updated:user_created});

				var result = type_of_boxService.save(newtb);
				if(result)
				{
					event.renderData(type="json",data={"success":true,"message":"Adding type of box is successfully"});
				}

				else 
				{
					event.renderData(type="json",data={"success":false,"message":"Adding type of box is failed"});
				}
			}
			else
			{
				var tb = type_of_boxService.get(rc.id_type_box);
				var user_updated = userService.getLoggedInUser();
				var updated = now();
				var description = rc.description &' ' & '(' & rc.depth & '*' & rc.length &'*' & rc.width & ')';
				tb.setUser_Updated(user_updated);
				tb.setUpdated(updated);
				tb.settb_description(description);
				tb.settb_depth(rc.depth);
				tb.settb_length(rc.length);
				tb.settb_width(rc.width);

				var result = type_of_boxService.save(tb);
				if(result)
				{
					event.renderData(type="json",data={"success":true,"message":"Updating type of box is successful"});
				}
				else
				{
					event.renderData(type="json",data={"success":false,"message":"Updating type of box is failed"});
				}
			}
		}
	}

	public any function delete(event, rc, prc) {
		if(event.GETHTTPMETHOD() == "POST"){
			var gettb = type_of_boxService.get(id=rc.id_type_box);
			type_of_boxService.delete(gettb,true);
			event.renderData(type="json",data={"success": true,"message":"Delete type of box successfully"});
		}
	}
}