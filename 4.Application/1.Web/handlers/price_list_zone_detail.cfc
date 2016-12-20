component output="false" displayname=""  {
	property   name="PLZ_detailService"    			inject="price_list_zone_detailsService";
	property   name="PLZService"           			inject="entityService:price_list_zone";
	property   name="PLFService"          	 		inject="entityService:price_list_factory";
	property   name='currencyConvertService' 	    inject='currency_convertService';
	property   name="userService"          			inject="userService";
	property   name='numberService'               	inject='numberHelper';

	public function init(){
		return this;
	}

	function getplz(event,prc,rc){
		if(event.GETHTTPMETHOD() == "POST")
		{
			var c_plz = entityload("price_list_zone",{id_plz = rc.id_plz},true);
			var cc 		= currencyConvertService.getCC_byDate(c_plz.getCurrency().getId_currency(),dateformat(c_plz.getPlz_date(),"yyyy-mm-dd"));
			var plf 	= c_plz.getprice_list_factory();
			var plfcc   = currencyConvertService.getCC_byDate(plf.getCurrency().getId_currency(),dateformat(plf.getPlf_date(),"yyyy-mm-dd"));

			plz={
				"id"        	  : c_plz.getId_plz(),
				"plz_code"        : c_plz.getPlz_code(),
				"plz_curr_code"   : isNull(c_plz.getCurrency())?"":c_plz.getCurrency().getCurr_code(),
				"plz_curr"     	  : isNull(c_plz.getCurrency())?"":c_plz.getCurrency().getId_currency(),
				// "plz_correction"  : c_plz.getPlz_correction(),
				"plz_description" : c_plz.getPlz_description(),
				"plz_commission"  : c_plz.getPlz_commission(),
				"plz_season"      : c_plz.getPlz_season(),
				"plz_freight"     : c_plz.getPlz_freight(),
				"id_plf"  		  : isNull(c_plz.getPrice_list_factory())?"":c_plz.getPrice_list_factory().getId_plf(),
				"plf_code"        : isNull(c_plz.getPrice_list_factory())?"":c_plz.getPrice_list_factory().getPlf_code(),
				"plf_curr_code"   : isNull(c_plz.getPrice_list_factory())?"":isNull(c_plz.getPrice_list_factory().getCurrency())?"":c_plz.getPrice_list_factory().getCurrency().getCurr_code(),
				"plf_cc_ex_rate"  : plfcc.recordcount != 1 ?0:plfcc.cc_value,
				"plz_ex_rate"     : c_plz.getPlz_ex_rate(),
				"plz_taxes"       : c_plz.getPlz_taxes(),
				"plz_date"        : dateformat(c_plz.getPlz_date(), "dd/mm/yyyy"),
				"cc_value"        : cc.recordcount != 1 ?0:cc.cc_value,
				"plz_margin"      : c_plz.getPlz_margin(),
				"plz_update"      : dateformat(isnull(c_plz.getPlz_update()) ? now() : c_plz.getPlz_update(),"dd/mm/yyyy"),
				"language"        : isNull(c_plz.getLanguage())?"":c_plz.getLanguage().getId_language(),
				"lg_name"         : isNull(c_plz.getLanguage())?"":c_plz.getLanguage().getLg_name()
			};
			event.renderData(type="json",data=plz);
		}
	}


	function getPlfty(event,rc,prc) {
		var plftys = PLFService.list(asQuery=false);

		var listplf = {};
		for(item in plftys){
			var plfty = {};
			plfty.id       = item.getId_plf();
			plfty.code     = item.getPlf_code();
			plfty.currency = isNull(item.getCurrency())?"":item.getCurrency().getCurr_code();
			listplf[plfty.id] = plfty;
		}

		event.renderData(type="json",data=listplf);
	}

	function getPLZ_details(event,rc,prc)
	{
		// var currUserSetting =  entityLoad("usersetting", {user: userService.getLoggedInUser()}, true);
		if(event.GETHTTPMETHOD() == "GET"){
			var usertype	   = userService.getUserLevel();
			var zone 	       = userService.getLoggedInUser().getZone();

			var c_plz          = entityload("price_list_zone",{id_plz = rc.id_plz},true);
			var plz_details    = [];
			var language 	   = c_plz.getLanguage();

			var plz_detailList = entityload("price_list_zone_details",{price_list_zone=c_plz});

			for(item in plz_detailList) {
			   	var plz_detail         			= {};
		   		plz_detail.id 				= item.getId_plz_det();
				plz_detail.id_plf_det       = isNull(item.getPrice_list_factory_detail())?null:item.getPrice_list_factory_detail().getId_plf_det();
				plz_detail.plfd_fty_sell_3  = isNull(item.getPrice_list_factory_detail())?"":item.getPrice_list_factory_detail().getPlfd_fty_sell_3();

				var costing 				= isNull(item.getPrice_list_factory_detail())?"":item.getPrice_list_factory_detail().getCosting();
				var costing_v 				= isNull(item.getPrice_list_factory_detail())?"":item.getPrice_list_factory_detail().getCosting_version();
				plz_detail.cost_code        = isNull(costing)    ?"":costing.getCost_code();
				plz_detail.cv_version       = isNull(costing_v)  ?"":costing_v.getCv_version();
				plz_detail.id_cost          = costing.getId_cost();
				plz_detail.id_cost_version  = costing_v.getId_cost_version();
				var cd 						= entityload("costing_description",{costing=costing,language=language},true);
				var cvd 					= entityload("costing_version_description",{costing_version=costing_v,language=language},true);
				plz_detail.cd_description   = isNull(cd)?"":cd.getCd_description();
				plz_detail.cvd_description  = isNull(cvd)?"":cvd.getCvd_description();

				var plf 					= isNull(item.getPrice_list_zone())    ?null:item.getPrice_list_zone().getPrice_list_factory()
				var plfCurr 				= isNull(plf)    ?javaCast("null",""):plf.getCurrency();

			   	if(usertype != 3){
					plz_detail.plzd_weight  = item.getPlzd_weight();
					plz_detail.plzd_freight     = item.getPlzd_freight();
					plz_detail.plzd_fty_sell_4  = item.getPlzd_Fty_Sell_4();
					plz_detail.plzd_taxes       = item.getPlzd_taxes();
					plz_detail.plzd_margin      = item.getPlzd_Margin();
					plz_detail.plzd_zone_sell_5 = item.getPlzd_zone_sell_5();
					plz_detail.plzd_pvpr_7      = item.getPlzd_PVPR_7();
			   	}

				var plzCurr 				= isNull(item.getPrice_list_zone())    ?null:item.getPrice_list_zone().getCurrency()
				plz_detail.plf_curr_code    = isNull(plfCurr)    ?"":plfCurr.getCurr_code();
				plz_detail.plz_curr_code    = isNull(plzCurr)    ?"":plzCurr.getCurr_code();


				plz_detail.plzd_zone_sell_6 = item.getPlzd_zone_sell_6();

				plz_detail.plzd_margin_1    = item.getPlzd_Margin_1();

				plz_detail.plzd_pvpr_8      = item.getPlzd_pvpr_8();
				plz_detail.plzd_margin_2    = item.getPlzd_Margin_2();

			   	ArrayAppend(plz_details,plz_detail);
			}

			event.renderData(type="json",data=plz_details);
		}
	}

	function resetManual(event, rc, prc){
		if(event.GETHTTPMETHOD() == "POST"){
			var plz = entityLoad("price_list_zone", {id_plz: rc.idplz}, true);
			var plzds = deserializeJSON(rc.dataREset);
			try {
				if(rc.isRecomended ==1){
					for(item in plzds){
						var plzd = PLZ_detailService.get(item.ID);
						var plzd_pvpr_8 = plzd.getPlzd_PVPR_7();
						plzd.setplzd_pvpr_8(plzd_pvpr_8);
						var plzd_margin_2 = val(numberService.roundDecimalPlaces((plzd_pvpr_8 - plzd.getPlzd_zone_sell_6())*100/plzd_pvpr_8,2));
						plzd.setPlzd_margin_2(plzd_margin_2);
						PLZ_detailService.save(plzd);
					}
				}
				else{
					for(item in plzds){
						var plzd = PLZ_detailService.get(item.ID);
						var plzd_zone_sell_6 = plzd.getPlzd_zone_sell_5()
						var plzd_fty_sell_4  = plzd.getPlzd_Fty_Sell_4();
						var plzd_freight     = plzd.getPlzd_freight();
						var plzd_taxes       = plzd.getPlzd_taxes();
						var plzd_margin_1    = val(numberService.roundDecimalPlaces((plzd_zone_sell_6 - plzd_fty_sell_4 - plzd_freight - plzd_taxes)*100/(plzd_fty_sell_4 + plzd_freight + plzd_taxes),2));
						var plzd_pvpr_7      = val(numberService.roundDecimalPlaces(plzd_zone_sell_6*100/(100 - plz.getplz_commission()),2));
						var plzd_pvpr_8      = plzd.getPlzd_pvpr_8();
						var plzd_margin_2    = val(numberService.roundDecimalPlaces((plzd_pvpr_8 - plzd_zone_sell_6)*100/plzd_pvpr_8,2));

						plzd.setPlzd_zone_sell_6(plzd_zone_sell_6);
						plzd.setPlzd_Margin_1(plzd_margin_1);
						plzd.setPlzd_pvpr_7(plzd_pvpr_7);
						plzd.setPlzd_pvpr_8(plzd_pvpr_8);
						plzd.setPlzd_margin_2(plzd_margin_2);

						PLZ_detailService.save(plzd);
					}
				}
				event.renderData(type="json",data={'success':true,'message':"Reset successfully!"});
			}
			catch(any e) {
				event.renderData(type="json",data={'success':false,'message':"Reset failed!"});
			}

		}
	}

	function updatePLZ(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST"){
			if(rc.id_plz neq 0){
				try {
					var plz = entityLoad("price_list_zone", {id_plz: rc.id_plz}, true);
					var currency = currencyConvertService.get(id=rc.plz_curr);
					var language = entityload("languages",{id_language=rc.language},true);
					var plf = plz.getPrice_list_factory();
					// var agent = entityload("agent",{id_Agent=rc.plz_agent},true);
					var userupdate = userService.getLoggedInUser();

					plz.setPlz_code(rc.plz_code);
					// plz.setAgent(agent);
					plz.setPlz_description(rc.plz_description);
					plz.setPlz_season(rc.plz_season);
					plz.setPlz_ex_rate(rc.plz_ex_rate);
					plz.setPlz_update(now());
					// plz.setPlz_correction(rc.plz_correction);
					plz.setPlz_commission(rc.plz_commission);
					plz.setPlz_freight(rc.plz_freight);
					plz.setPlz_taxes(rc.plz_taxes);
					plz.setPlz_margin(rc.plz_margin);

					if(not isNull(language)){
						plz.setLanguage(language);
					}
					if(not isNull(plf)){
						plz.setPrice_list_factory(plf);
					}
					if(not isNull(currency)){
						plz.setCurrency(currency);
					}
					plz.setUser_updated(userupdate);

					PLZService.save(plz);

					var plzds = entityload("price_list_zone_details",{price_list_zone=plz});
					for(item in plzds){
						PLZ_detailService.updatePriceListZoneDetail(item);
					}
					event.renderData(type="json",data={'success':true,'message':"Update Price List Zone successfully"});
				}
				catch(any e) {
					event.renderData(type="json",data={'success':false,'message':"Update Price List Zone failed!"});
				}
			}
			else{
				event.renderData(type="json",data={'success':false,'message':"Update Price List Zone failed!"});
			}
		}
	}

	function addEdit(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST"){
			if(rc.id_plz_det == 0){
				event.renderData(type="json",data={'success':false,'message':"Can not get data!"});
			}else{
				var plz_det = entityLoad("price_list_zone_details", {id_plz_det: rc.id_plz_det}, true);
				var plz = plz_det.getPrice_list_zone();
				var plzd_zone_sell_6 =val(numberService.roundDecimalPlaces(rc.plzd_zone_sell_6,2));
				var plzd_pvpr_8     = val(numberService.roundDecimalPlaces(rc.plzd_pvpr_8,2));


				var plzd_fty_sell_4 = plz_det.getPlzd_Fty_Sell_4();
				var plzd_freight    = plz_det.getPlzd_freight();
				var plzd_taxes      = plz_det.getPlzd_taxes();
				var plzd_margin_1   = val(numberService.roundDecimalPlaces((rc.plzd_zone_sell_6 - plzd_fty_sell_4 - plzd_freight - plzd_taxes)*100/(plzd_fty_sell_4 + plzd_freight + plzd_taxes),2));
				var plzd_pvpr_7     = val(numberService.roundDecimalPlaces(rc.plzd_zone_sell_6*100/(100 - plz.getplz_commission()),2));
				var plzd_margin_2   = val(numberService.roundDecimalPlaces((plzd_pvpr_8 - rc.plzd_zone_sell_6)*100/plzd_pvpr_8,2));

				plz_det.setPlzd_zone_sell_6(plzd_zone_sell_6);
				plz_det.setplzd_Margin_1(plzd_margin_1);
				plz_det.setPlzd_pvpr_7(plzd_pvpr_7);
				plz_det.setplzd_pvpr_8(plzd_pvpr_8);
				plz_det.setplzd_margin_2(plzd_margin_2);

				entitysave(plz_det);
				ormflush();
				event.renderData(type="json",data={'success':true,'message':"Update price list zone detail successfully!"});
			}
		}
	}
}