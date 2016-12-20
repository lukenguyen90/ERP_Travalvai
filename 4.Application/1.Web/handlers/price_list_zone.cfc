component output="false" displayname=""  {
	  property  name='price_list_zoneService'     	inject='price_list_zoneService';
	  property  name='price_list_factoryService' 	inject='entityService:price_list_factory';
	  property  name='factoryService'           	inject='entityService:factory';
	  property  name='currencyConvertService' 	    inject='currency_convertService';
	  property  name='currencyService'           	inject='entityService:currency';
	  property 	name='userService'               	inject='userService';
	  property 	name='numberService'               	inject='numberHelper';

	public function init(){
		return this;
	}

	function getPLF(event,prc,rc)
	{
		var usertype = userService.getUserLevel();
		var plfs     = [];
		if(usertype eq 1 or usertype eq 2)
		{
			factory 	 = userService.getLoggedInUser().getFactory();
			var listseason = [];
			if(structKeyExists(rc, "id_price_list_factory")){
				var plfList  = EntityLoad('Price_list_factory',{factory = factory, id_plf = rc.id_price_list_factory});
			}else{
				var plfList  = EntityLoad('Price_list_factory',{factory = factory});
			}
			for(item in plfList) {
			   var plf         = {};
			   var itemseason  = {};
			   plf.id          = item.getid_plf();
			   plf.code        = item.getplf_code();
			   plf.ftycurrency = isNull(item.getFactory())?"":item.getFactory().getCurrency().getcurr_code();
			   plf.currID      = isNull(item.getCurrency())?"":item.getCurrency().getid_currency();

			   ArrayAppend(plfs,plf);
			}
		}
		event.renderData(type="json",data=plfs);
	}

	function deletePLZ(event, rc, prc){
		try{
			var userLevel = userService.getUserLevel();
			if(event.GETHTTPMETHOD() == "POST" and (userLevel == 1 or userLevel == 2)){
				if(structKeyExists(rc, "id_plz")){
					price_list_zoneService.delFK_plzd(rc.id_plz);
					var result = price_list_zoneService.deleteByID(rc.id_plz);
					if(result){
						event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete price list zone successfully' });

					}else{
						event.renderData(type="json",data={ 'success' : false , 'message' : 'Delete price list zone failed' });
					}
				}else{
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Delete price list zone failed' });
				}
			}else{
				event.renderData(type="json",data={ 'success' : false , 'message' : 'Access denied' });
			}
		}
		catch(any ex) {
			event.renderData(type="json",data={ 'success' : false , 'message' : 'Delete price list zone failed!'&ex.message});
		}
	}


	function getPrice_list_zones(event,rc,prc)
	{
		var price_list_zones = [];
		var factory = userService.getLoggedInUser().getFactory();
		var plfList  = EntityLoad('Price_list_factory',{factory = factory});

		var price_list_zoneList = [];
		for(plf in plfList){
			var plzs = EntityLoad('price_list_zone',{price_list_factory = plf});
			ArrayAppend(price_list_zoneList,plzs,true);
		}

		for(item in price_list_zoneList) {
		   var price_list_zone        			= {};
		   price_list_zone.id         			= item.getid_plz();
		   price_list_zone.code       			= item.getplz_code();
		   price_list_zone.description      	= item.getplz_description();
		   price_list_zone.season       		= item.getplz_season();
		   price_list_zone.ex_Rate       		= item.getplz_ex_Rate();
		   // price_list_zone.correction       	= item.getplz_correction();
		   price_list_zone.commission       	= item.getplz_commission();
		   price_list_zone.freight       		= item.getplz_freight();
		   price_list_zone.taxes       			= item.getplz_taxes();
		   price_list_zone.margin       		= item.getplz_margin();
		   price_list_zone.date       			= isNull(item.getplz_date())?"":LSDateTimeFormat(item.getplz_date(),'yyyy-mm-dd');
		   price_list_zone.update       		= isNull(item.getplz_update())?"":LSDateTimeFormat(item.getplz_update(),'yyyy-mm-dd');
		   price_list_zone.id_plf				= isNull(item.getprice_list_factory())?"":item.getprice_list_factory().getId_plf();
		   price_list_zone.plf_code				= isNull(item.getprice_list_factory())?"":item.getprice_list_factory().getplf_code();
		   price_list_zone.plf_curr 			= isNull(isNull(item.getprice_list_factory())?"":item.getprice_list_factory().getcurrency())?"":item.getprice_list_factory().getcurrency().getcurr_code();

		   // price_list_zone.id_Agent				= isNull(item.getAgent())?"":item.getAgent().getId_Agent();
		   // price_list_zone.Ag_Code				= isNull(item.getAgent())?"":item.getAgent().getAg_code();
		   price_list_zone.plcurrency           = isNull(item.getcurrency())?"":item.getcurrency().getcurr_code();
		   price_list_zone.language        		= isNull(item.getlanguage())?"":item.getlanguage().getlg_name();
		   ArrayAppend(price_list_zones,price_list_zone);
		}

		event.renderData(type="json",data=price_list_zones);
	}

	public any function getCurr_convert(event, rc, prc) {
		var curr_c = queryExecute("select * from currency_convert where id_currency = #rc.currency# order by cc_date desc limit 1");
		var currency_convert = {
			"id_curr_conv" = curr_c.id_curr_conv,
			"cc_date"      = curr_c.cc_date,
			"cc_value"     = curr_c.cc_value
		};
		event.renderData(type="json",data={'currency_convert': currency_convert});
	}

	public any function CopyData(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			transaction {
				try {
					var user_created = userService.getLoggedInUser();
					var created 	 = now();

					var plzSource = price_list_zoneService.get(id=rc.plzSource);
					var ex_rate   = plzSource.getplz_ex_Rate();
					var plf       = plzSource.getPrice_list_factory();
					var checkplz  = entityLoad("price_list_zone", {plz_season: plzSource.getplz_season(), plz_code: rc.code, price_list_factory: plf}, true);
					if(isnull(checkplz)) {
						var newplz = entityNew("price_list_zone");

						newplz.setplz_code(isNull(rc.code)?"":Ucase(rc.code));
						newplz.setplz_description(isNull(rc.description)?"":rc.description);
						newplz.setplz_season(plzSource.getplz_season());
						
						newplz.setplz_commission(plzSource.getplz_commission());
						newplz.setplz_ex_Rate(ex_rate);
						newplz.setplz_freight(plzSource.getPlz_freight());
						newplz.setplz_taxes(plzSource.getplz_taxes());
						newplz.setplz_margin(plzSource.getPlz_margin());
						newplz.setprice_list_factory (plf);
						newplz.setcurrency(plzSource.getCurrency());
						newplz.setplz_date(created);
						newplz.setplz_update(created);
						newplz.setuser_created(user_created);
						newplz.setuser_updated(user_created);
						newplz.setlanguage(plzSource.getlanguage());

						entitysave(newplz);

						var plf_det = entityLoad("price_list_factory_detail", {price_list_factory: plf});
						for(item_plfd in plf_det) {
							var costing = item_plfd.getcosting();
							var costing_version = item_plfd.getcosting_version();
							var new_plzdetail = entityNew("price_list_zone_details");

							new_plzdetail.setplzd_Weight(costing_version.getcv_weight())

							var plzd_freight = val(numberService.roundDecimalPlaces(costing_version.getcv_weight() * newplz.getPlz_freight()/1000,2));
							var plfd_fty_sell_3  = isNull(item_plfd)?0:item_plfd.getPlfd_fty_sell_3();

							var plzd_fty_sell_4 = val(numberService.roundDecimalPlaces(plfd_fty_sell_3 / ex_rate,2));
							var plzd_taxes = val(numberService.roundDecimalPlaces((plzd_fty_sell_4 + plzd_freight)*newplz.getplz_taxes()/100,2));
							var plzd_margin = val(numberService.roundDecimalPlaces((plzd_fty_sell_4 + plzd_freight + plzd_taxes)*newplz.getplz_margin()/100,2));
							var plzd_zone_sell_5 = val(numberService.roundDecimalPlaces(plzd_fty_sell_4 + plzd_freight + plzd_taxes + plzd_margin,2));
							var plzd_zone_sell_6 = plzd_zone_sell_5;
							var plzd_margin_1 = val(numberService.roundDecimalPlaces((plzd_zone_sell_6 - plzd_fty_sell_4 - plzd_freight - plzd_taxes)*100/(plzd_fty_sell_4 + plzd_freight + plzd_taxes),2));
							var plzd_pvpr_7 = val(numberService.roundDecimalPlaces(plzd_zone_sell_6*100/(100 - newplz.getplz_commission()),2));
							var plzd_pvpr_8 = plzd_pvpr_7;
							var plzd_margin_2 = val(numberService.roundDecimalPlaces((plzd_pvpr_8 - plzd_zone_sell_6)*100/plzd_pvpr_8,2));

							new_plzdetail.setplzd_Fty_Sell_4(plzd_fty_sell_4);
							new_plzdetail.setplzd_Freight(plzd_freight);
							new_plzdetail.setplzd_Taxes(plzd_taxes);
							new_plzdetail.setplzd_Margin(plzd_margin);
							new_plzdetail.setplzd_Zone_Sell_5(plzd_zone_sell_5);
							new_plzdetail.setplzd_Zone_Sell_6(plzd_zone_sell_6);
							new_plzdetail.setplzd_Margin_1(plzd_margin_1);
							new_plzdetail.setplzd_PVPR_7(plzd_pvpr_7);
							new_plzdetail.setplzd_PVPR_8(plzd_pvpr_8);
							new_plzdetail.setplzd_Margin_2(plzd_margin_2);
							new_plzdetail.setcreated(LSDateTimeFormat(Now(),'dd/MM/yyyy'));
							new_plzdetail.setupdated(LSDateTimeFormat(Now(),'dd/MM/yyyy'));

							new_plzdetail.setuser_created(user_created);
							new_plzdetail.setuser_updated(user_created);
							new_plzdetail.setprice_list_zone(newplz);
							new_plzdetail.setprice_list_factory_detail(item_plfd);
							entitySave(new_plzdetail);
						}
						event.renderData(type="json",data={ 'success' : true , 'message' : 'Copy data successfully', 'plzid' : newplz.getid_plz()});
					}else{
						event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new price list zone failed ! Code and season have already exist !' });
					}
				}
				catch(any ex) {
					transactionrollback();
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Can not copy data !'});
				}
			}
		}
	}

	function addNew(event,prc,rc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			try {
				var user_created = userService.getLoggedInUser();
				var created 	 = now();

				var currency = currencyService.get(id=rc.currency);
				var plf      = price_list_factoryService.get(id=rc.plf);
				var checkplz = entityLoad("price_list_zone", {plz_season: rc.season, plz_code: rc.code, price_list_factory: plf}, true);
				var language = entityLoad("languages", {id_language: rc.language}, true);
				// var agent 	 = entityLoad("agent", {id_Agent: rc.agent}, true);
				if(isnull(checkplz)) {
					var newplz = entityNew("price_list_zone");
					var plz_ex_rate = numberService.roundDecimalPlaces(rc.ex_rate,2);

					newplz.setplz_code(isNull(rc.code)?"":Ucase(rc.code));
					newplz.setplz_description(isNull(rc.description)?"":rc.description);
					newplz.setplz_season(isNull(rc.season)?"":rc.season);
					// newplz.setplz_correction(isNull(rc.correction)?"":rc.correction);
					newplz.setplz_commission(isNull(rc.commission)?"":rc.commission);
					newplz.setplz_ex_Rate(isNull(plz_ex_rate)?"":plz_ex_rate);
					newplz.setplz_freight(isNull(rc.freight)?"":rc.freight);
					newplz.setplz_taxes(isNull(rc.taxes)?"":rc.taxes);
					newplz.setplz_margin(isNull(rc.margin)?"":rc.margin);
					newplz.setprice_list_factory (plf);
					newplz.setcurrency(isNull(currency)? javaCast("null",""):currency);
					newplz.setplz_date(created);
					newplz.setplz_update(created);
					newplz.setuser_created(user_created);
					newplz.setuser_updated(user_created);
					newplz.setlanguage(isNull(language)? javaCast("null",""):language);
					// newplz.setAgent(isNull(agent)? javaCast("null",null):agent);

					entitysave(newplz);

					var plf_det = entityLoad("price_list_factory_detail", {price_list_factory: plf});
					for(item_plfd in plf_det) {
						var costing = item_plfd.getcosting();
						var costing_version = item_plfd.getcosting_version();
						var new_plzdetail = entityNew("price_list_zone_details");

						var plzcc_value = isNull(rc.ex_rate)?"":rc.ex_rate;

						new_plzdetail.setplzd_Weight(costing_version.getcv_weight())

						var plzd_freight = val(numberService.roundDecimalPlaces(costing_version.getcv_weight() * newplz.getPlz_freight()/1000,2));
						var plfd_fty_sell_3  = isNull(item_plfd)?0:item_plfd.getPlfd_fty_sell_3();

						var plzd_fty_sell_4 = val(numberService.roundDecimalPlaces(plfd_fty_sell_3 / plzcc_value,2));
						var plzd_taxes = val(numberService.roundDecimalPlaces((plzd_fty_sell_4 + plzd_freight)*newplz.getplz_taxes()/100,2));
						var plzd_margin = val(numberService.roundDecimalPlaces((plzd_fty_sell_4 + plzd_freight + plzd_taxes)*newplz.getplz_margin()/100,2));
						var plzd_zone_sell_5 = val(numberService.roundDecimalPlaces(plzd_fty_sell_4 + plzd_freight + plzd_taxes + plzd_margin,2));
						var plzd_zone_sell_6 = val(numberService.roundDecimalPlaces(plzd_zone_sell_5,2));
						var plzd_margin_1 = val(numberService.roundDecimalPlaces((plzd_zone_sell_6 - plzd_fty_sell_4 - plzd_freight - plzd_taxes)*100/(plzd_fty_sell_4 + plzd_freight + plzd_taxes),2));
						var plzd_pvpr_7 = val(numberService.roundDecimalPlaces(plzd_zone_sell_6*100/(100 - newplz.getplz_commission()),2));
						var plzd_pvpr_8 = plzd_pvpr_7;
						var plzd_margin_2 = val(numberService.roundDecimalPlaces((plzd_pvpr_8 - plzd_zone_sell_6)*100/plzd_pvpr_8,2));

						new_plzdetail.setplzd_Fty_Sell_4(plzd_fty_sell_4);
						new_plzdetail.setplzd_Freight(plzd_freight);
						new_plzdetail.setplzd_Taxes(plzd_taxes);
						new_plzdetail.setplzd_Margin(plzd_margin);
						new_plzdetail.setplzd_Zone_Sell_5(plzd_zone_sell_5);
						new_plzdetail.setplzd_Zone_Sell_6(plzd_zone_sell_6);
						new_plzdetail.setplzd_Margin_1(plzd_margin_1);
						new_plzdetail.setplzd_PVPR_7(plzd_pvpr_7);
						new_plzdetail.setplzd_PVPR_8(plzd_pvpr_8);
						new_plzdetail.setplzd_Margin_2(plzd_margin_2);
						new_plzdetail.setcreated(LSDateTimeFormat(Now(),'dd/MM/yyyy'));
						new_plzdetail.setupdated(LSDateTimeFormat(Now(),'dd/MM/yyyy'));

						new_plzdetail.setuser_created(user_created);
						new_plzdetail.setuser_updated(user_created);

						new_plzdetail.setprice_list_zone(newplz);
						new_plzdetail.setprice_list_factory_detail(item_plfd);
						entitySave(new_plzdetail);
					}
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new price list zone successfully' , 'plzid' : newplz.getid_plz()});
				}
				else {
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new price list zone failed ! Code and season have already exist !' });
				}
			}
			catch(any ex) {
				event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new price list zone failed !' });
			}
		}
	}


	public any function getSeason(event,prc,rc)
	{
		var usertype = userService.getUserLevel();
		if(usertype eq 1 or usertype eq 2){
			factory 	 = userService.getLoggedInUser().getFactory();
			var listseason = [];
			var plzList  = QueryExecute("select plz_season from price_list_zone plz inner join price_list_factory plf on plz.id_plf = plf.id_plf where plf.id_Factory = #factory.getid_Factory()#");
			for(item in plzList) {
			   var itemseason  = {};
			   itemseason.id   		=  item.plz_season;
			   itemseason.season   	=  item.plz_season;
			   if(ArrayContains(listseason,itemseason) == 0){
			   		ArrayAppend(listseason,itemseason);
			   }
			}
			event.renderData(type="json",data=listseason);
		}else{
			event.renderData(type="json",data={});
		}
	}


	public any function getPLZoneBySeason(event, prc, rc) {
		try {
			var arrPlist = {};
			var plz = entityLoad("price_list_zone", {plz_season: rc.season});
			for(item in plz) {
				var strPList = {
					"id_plz": item.getid_plz(),
					"plz_code":item.getplz_code(),
					"plz_description" : item.getplz_description()
				}
				arrPlist[item.getid_plz()] = strPList;
			}

			event.renderData(type="json",data={'arrPlist':arrPlist, 'success':true, 'message': ''});
		}
		catch(any ex) {
			event.renderData(type="json",data={'arrPlist':arrPlist, 'success':false, 'message': 'Some thing went wrong. Can not get data !'});
		}
	}

	public any function getPLFactoryBySeason(event, prc, rc) {
		try {
			var arrPlist = [];
			var plfs = entityLoad("price_list_factory", {plf_season: rc.season});
			for(item in plfs) {
				var strPList = {
					"id_plf": item.getId_plf(),
					"plf_code":item.getplf_code()
				}
				arrayAppend(arrPlist, strPList);
			}

			event.renderData(type="json",data={'arrPlist':arrPlist, 'success':true, 'message': ''});
		}
		catch(any ex) {
			event.renderData(type="json",data={'arrPlist':arrPlist, 'success':false, 'message': 'Some thing went wrong. Can not get data !'});
		}
	}

	public any function getftycurrency(event, rc, prc) {
		try {
			var plf = entityLoad("price_list_factory", {id_plf: rc.plf_id}, true);
			var curr_c = queryExecute("select * from currency_convert where id_currency = #plf.getCurrency().getid_currency()# order by cc_date desc limit 1");
			event.renderData(type="json",data={'success':true, 'currency': plf.getCurrency().getcurr_code(),'plf_ex_rate':curr_c.cc_value, 'curID': plf.getCurrency().getid_currency()});
		}
		catch(any ex) {
			event.renderData(type="json",data={'success':false, 'message': 'Some thing went wrong. Can not get currency !'});
		}
	}
}