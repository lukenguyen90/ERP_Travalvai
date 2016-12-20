component output="false" displayname=""  {

	property name='price_list_zoneService' inject='entityService:Price_list_zone';
	property name='agentService' inject='entityService:Agent';
	property name='pagentService' inject='entityService:agent_price';
	property name='userService' inject='userService';

	public function init(){
		return this;
	}

	public any function getInfor(event,rc,prc) {
		var result = {};
		if(structKeyExists(rc, "id_pagent"))
		{
			var resultPagen    = pagentService.get(id=rc.id_pagent,returnNew=true);

			result.id     = resultPagen.getid_agent_pl();
			result.agent  = isNull(resultPagen.getAgent())?0:resultPagen.getAgent().getag_code();
			result.fdate  = resultPagen.getapl_date_i();
			result.todate = resultPagen.getapl_date_f();
			result.plz    = isNull(resultPagen.getprice_list_zone())?0:resultPagen.getprice_list_zone().getid_plz();
		}
		event.renderData(type="json",data=result);
	}

	public any function getagentdetail(event,rc,prc) {
		var agent = agentService.get(rc.idagent);
		agentdetail.code = isNull(agent.getag_code())?"":agent.getag_code();
		agentdetail.des = isNull(agent.getag_description())?"":agent.getag_description();
		event.renderData(type="json",data={ 'success' : true , 'code_agent' : agentdetail.code, 'des_agent' : agentdetail.des});
	}

	function addNew(event,prc,rc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_pagent== 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();


				var newPagent = pagentService.new({apl_date_i:rc.fdate,apl_date_f:rc.todate,agent:rc.agent,Price_list_zone:rc.plz,updated:created,created:created,user_created:user_created,user_updated:user_created});

				var result = pagentService.save(newPagent);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new agent price list successfully' , 'pagentId' : newPagent.getid_agent_pl()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new agent price list failed !' });
			}else{
				var pagent = pagentService.get(rc.id_pagent);
				var user_updated = userService.getLoggedInUser();
				var updated = now();

				pagent.setUser_Updated(user_updated);
				pagent.setUpdated(updated);
				pagent.setagent(rc.agent==""?JavaCast("null", ""):agentService.get(rc.agent));
				pagent.setprice_list_zone(rc.plz==""?JavaCast("null", ""):price_list_zoneService.get(rc.plz));
				pagent.setapl_date_f(rc.todate);
				pagent.setapl_date_i(rc.fdate);

				var result = pagentService.save(pagent);

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update agent price list successfully' });
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update agent price list failed !' });
			}
		}
	}

	function delete(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var getPagent = pagentService.get(rc.paId);
			pagentService.delete(getPagent,true);
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete agent price list successfully' });
		}
	}
}