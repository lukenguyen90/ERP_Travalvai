component output="false" {
	property name='price_list_factoryService' 	inject="entityService:price_list_factory";
	property name='zoneService'					inject="entityService:zone";
	property name='zonepriceService' 		    inject="entityService:zone_price";
	property name='userService' 				inject='userService';

	public function init(){
		return this;
	}

	function getPLF(event,prc,rc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var plfs       = [];
			var plfList = entityload("price_list_factory",{zone=zoneService.get(rc.idzone)});

			for(item in plfList) {
			   var plf           = {};
			   plf.id            = item.getid_plf();
			   plf.code          = item.getplf_code();
			   ArrayAppend(plfs,plf);
			}
			event.renderData(type="json",data={'success'=true,'plfs'=plfs});
		}else
		{
			event.renderData(type="json",data={'success'=false,'plfs'=[]});
		}
	}

	public any function getInfor(event,rc,prc) {
		var result={};

		if(structKeyExists(rc,"zone"))
		{
			var result_zone_price = zonepriceService.get(id=rc.zone,returnNew = true);

			result.id          = result_zone_price.getzone();
			result.zone        = isNull(result_zone_price.getZone())?0:result_zone_price.getZone().getid_Zone();
			result.fdate	   = result_zone_price.getzpl_date_i();
			result.todate      = result_zone_price.getzpl_date_f();
			result.plf         = isNull(result_zone_price.getprice_list_factory())?0:result_zone_price.getprice_list_factory().getif_plf();
		}

		event.renderData(type="json",data=result);
	}



	public function addNew(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.zone_price == 0){
				var user_created = userService.getLoggedInUser();
				var created = now();

				var newzpl = zonepriceService.new({zpl_date_i:rc.fdate, zpl_date_f:rc.todate, price_list_factory:rc.plf, zone:rc.zone,updated:created,created:created,user_created:user_created,user_updated:user_created});
				var result = zonepriceService.save(newzpl);
				if(result){
					event.renderData(type="json",data={"success":true,"message":"Adding zone price list is successfully", 'zonepId' : newzpl.getzone()});
				}else {
					event.renderData(type="json",data={"success":false,"message":"Adding zone price list is failed"});
				}
			}else{
				var zonep = zonepriceService.get(rc.zone_price);

				var user_updated = userService.getLoggedInUser();
				var updated = now();

				zonep.setUser_Updated(user_updated);
				zonep.setUpdated(updated);
				zonep.setzone(rc.zone==""?JavaCast("null", ""):zoneService.get(rc.zone));
				zonep.setzpl_date_f(rc.todate);
				zonep.setzpl_date_i(rc.fdate);
				zonep.setprice_list_factory(rc.plf==""?JavaCast("null", ""):price_list_factoryService.get(rc.plf));
				zonep.setupdated(#LSDateTimeFormat(Now(),'yyyy-mm-dd HH:nn:ss')#);
				zonep.setuser_updated(userService.get(SESSION.loggedInUserID));
				var result = zonepriceService.save(zonep);

				if(result){
					event.renderData(type="json",data={"success":true,"message":"Updating zone price list is successful"});
				}else{
					event.renderData(type="json",data={"success":false,"message":"Updating zone price list is failed"});
				}
			}
		}
	}


	function delete(event, rc, prc) {
		if(event.GETHTTPMETHOD() == "POST"){
			var getzpl = zonepriceService.get(id=rc.zplid);
			zonepriceService.delete(getzpl,true);
			event.renderData(type="json",data={"success": true,"message":"Delete zone price list successfully"})
		}
	}


}