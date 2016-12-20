component output="false" displayname=""  {
	property  name  = "factoryService"   					inject="entityService:factory";
	property  name  = "currencyService"  					inject="entityService:currency";
	property  name  = 'currencyConvertService' 	    		inject='currency_convertService';
	property  name  = "zoneService"      					inject="entityService:zone";
	property  name  = "PLFService"       					inject="entityService:price_list_factory";
	property  name  = "priceListFactoryDetailService"       inject="entityService:price_list_factory_detail";
	property  name  = "userService"      					inject="userService";
	property  name  = "price_list_zone_detailsService"      inject="price_list_zone_detailsService";
	property  name  = 'numberService' 						inject='numberHelper';

	public function init(){
		return this;
	}

	function getPLF(event,prc,rc)
	{
		var usertype = userService.getUserLevel();

		if((usertype eq 1) or (usertype eq 2))
		{
			factory 	   = userService.getLoggedInUser().getFactory();
			var plfs       = [];
			var listseason = [];
			if(structKeyExists(rc, "id_price_list_factory")){
				var plfList  = EntityLoad('Price_list_factory',{factory = factory, id_plf = rc.id_price_list_factory}, "id_plf desc");
			}else{
				var plfList  = EntityLoad('Price_list_factory',{factory = factory}, "id_plf desc");
			}


			for(item in plfList) {
			   var fty_cc = currencyConvertService.getCC_byDate(factory.getCurrency().getId_currency(),dateformat(item.getplf_date(),"yyyy-mm-dd"));
			   var fty_ex_rate = fty_cc.cc_value;

			   var plf           = {};
			   // var itemseason    = {};
			   plf.id            = item.getid_plf();
			   plf.code          = item.getplf_code();
			   plf.des           = item.getplf_description();
			   plf.season        = item.getplf_season();
			   plf.correction    = item.getplf_correction();
			   plf.ex_Rate       = numberService.roundDecimalPlaces(item.getplf_Ex_Rate(),2);
			   plf.plfdate       = dateformat(item.getplf_date(), "dd/mm/yyyy");

			   var plf_curr 	 = currencyConvertService.getCC_byDate(item.getCurrency().getId_currency(),dateformat(item.getplf_date(),"yyyy-mm-dd"));

			   plf.creation_date = plf_curr.recordcount != 1 ?"":numberService.roundDecimalPlaces(plf_curr.cc_value,2);
			   plf.plfupdate     = dateformat(item.getplf_update(), "dd/mm/yyyy");
			   plf.zoneid        = isNull(item.getZone())?"":item.getZone().getid_Zone();
			   plf.zcode         = isNull(item.getZone())?"":item.getZone().getz_code();
			   plf.z_des         = isNull(item.getZone())?"":item.getZone().getz_description();
			   plf.language      = isNull(item.getLanguage())?"":item.getLanguage().getlg_name();
			   plf.ftyid         = isNull(item.getFactory())?"":item.getFactory().getid_Factory();
			   plf.ftycurrencyid = isNull(item.getFactory())?javaCast("null",""):(isNull(item.getFactory().getCurrency())?javaCast("null",""):item.getFactory().getCurrency().getid_currency());
			   plf.ftycurrency   = isNull(item.getFactory())?javaCast("null",""):(isNull(item.getFactory().getCurrency())?javaCast("null",""):item.getFactory().getCurrency().getcurr_code());
			   plf.currID        = isNull(item.getCurrency())?"":item.getCurrency().getid_currency();
			   plf.CurrPL        = isNull(item.getCurrency())?"":item.getCurrency().getcurr_code();

			   // itemseason.id     = plf.season;
			   // itemseason.season = plf.season;
			   // if(ArrayContains(listseason,itemseason) == 0){
			   // 		ArrayAppend(listseason,itemseason);
			   // }
			   ArrayAppend(plfs,plf);
			}
			// event.renderData(type="json",data={listPLF:plfs, listseason:listseason});
			event.renderData(type="json",data=plfs);
		}
		else {
			event.renderData(type="json",data=[]);
		}
	}

	public any function  getPlfById(event, prc, rc) {
		// try {
			var plf  = EntityLoad('Price_list_factory',{id_plf = rc.id_plf}, true);
			var id_currency = plf.getCurrency().getId_currency();
			var currencyConvert = currencyConvertService.getCC_byDate(id_currency,dateformat(plf.getPlf_date(),"yyyy-mm-dd"));
			var newplf = {
				  "plf_code"        = plf.getPlf_code()
				, "plf_description" = plf.getPlf_description()
				, "plf_correction"  = plf.getPlf_correction()
				, "plf_season"      = plf.getPlf_season()
				, "plf_date"        = plf.getPlf_date()
				, "plf_Ex_Rate"     = plf.getPlf_Ex_Rate()
				, "cc_value"     	= currencyConvert.cc_value
				, "curr_code"		= currencyConvert.curr_code
				, "id_currency"     = isNull(plf.getCurrency())?"":plf.getCurrency().getId_currency()
				, "id_Zone"         = isNull(plf.getZone())?"":plf.getZone().getId_Zone()
			};
			event.renderData(type="json",data={'plf':newplf, 'success':true, 'message': ''});
		// }
		// catch(any ex) {
		// 	event.renderData(type="json",data={ 'success':false, 'message': 'Some thing went wrong. Can not get data !'});
		// }
	}

	private any function getCurrencyConvert(any currencyId) {
		var curr_c = queryExecute("select * from currency_convert where id_currency = #currencyId# order by cc_date desc limit 1", {maxResults=1});
		var currency_convert = {
			"id_curr_conv" = curr_c.id_curr_conv,
			"cc_date"      = curr_c.cc_date,
			"cc_value"     = numberService.roundDecimalPlaces(curr_c.cc_value,6)
		};
		return currency_convert;
	}

	public any function getCurr_convert(event, rc, prc) {
		event.renderData(type="json",data=getCurrencyConvert(rc.currency));
	}

	function getExRateUSDToFtyCurrency(event,prc,rc){
		factory = userService.getLoggedInUser().getFactory();
		currencyId = factory.getCurrency().getid_currency();
		event.renderData(type="json",data=getCurrencyConvert(currencyId));
	}

	public any function getCurr_convert(event, rc, prc) {
		var curr_c = queryExecute("select * from currency_convert where id_currency = #rc.currency# order by cc_date desc limit 1", {maxResults=1});
		var currency_convert = {
			"id_curr_conv" = curr_c.id_curr_conv,
			"cc_date"      = curr_c.cc_date,
			"cc_value"     = numberService.roundDecimalPlaces(curr_c.cc_value,2)
		};
		event.renderData(type="json",data= currency_convert);
	}

	public any function getSeason(event,prc,rc)
	{
		var factoryID = userService.getFactoryID();
		var costing_season =  queryExecute("select distinct cost_season from costing where id_factory = #factoryID# order by cost_season");
		var listseason = [];

		for(item in costing_season){
			arrayAppend(listseason,item.cost_season);
		}
		event.renderData(type="json",data=listseason);
	}
	public any function getSeasonForCopy(event,prc,rc)
	{
		var costing_season = [];
		var usertype = userService.getUserLevel();
		var zoneID    = userService.getZoneID();
		var factoryID = userService.getFactoryID();
		if(usertype == 0){
			costing_season =  queryExecute("select distinct plf_season from price_list_factory order by plf_season");
		}else if(usertype == 1){
			costing_season =  queryExecute("select distinct plf_season from price_list_factory where id_factory = #factoryID# order by plf_season");
		}else if(usertype == 2){
			costing_season =  queryExecute("select distinct plf_season from price_list_factory where id_factory = #factoryID# and id_zone = #zoneID# order by plf_season");
		}
		
		var listseason = [];

		for(item in costing_season){
			arrayAppend(listseason,item.plf_season);
		}
		event.renderData(type="json",data=listseason);
	}

	public any function getFactoryCurrency(event,rc,prc) {
		var curr_fty = {};
		var curr_fty.idfactory = userService.getLoggedInUser().getFactory().getid_Factory();
		var currency = userService.getLoggedInUser().getFactory().getCurrency();
		var curr_fty.currency = currency.getCurr_code();
		return event.renderData(type="json",data=curr_fty);
	}

	function insertPLF(event,prc,rc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var user_created = userService.getLoggedInUser();
			if(rc.id_plf == 0){
				var created = now();

				var newplf = PLFService.new({
											  plf_code        : rc.code
											, plf_description : rc.description
											, plf_season      : rc.season
											, plf_correction  : structKeyExists(rc,"correction")?val(rc.correction):0
											, plf_Ex_Rate     : rc.ex_rate
											, plf_date        : created
											, factory         : rc.idfactory
											, zone            : rc.idzone
											, currency        : rc.idcurrency
											, updated         : created
											, created         : created
											, user_created    : user_created
											, user_updated    : user_created
											, language        : user_created.getlanguage().getid_language()
										});

				var result = PLFService.save(newplf);
				if(rc.isCreateByCopy){
					if(structKeyExists(rc,"sourceseason") and rc.sourceseason != ""){
						var factory = userService.getLoggedInUser().getFactory();
						var costingList = entityLoad("Costing",{cost_season: rc.sourceseason});
						for(cost in costingList){
							var cvList = entityLoad("Costing_versions",{costing:cost});
							for(cv in cvList){
								var plfd = priceListFactoryDetailService.new({});
								plfd.setcosting_version(cv);
								plfd.setcosting(cost);
								plfd.setprice_list_factory(newplf);
								plfd.setplfd_fty_cost_0(cv.getcv_fty_cost_0());

								var plf_cc = newplf.getplf_Ex_Rate();
								var plfd_fty_sell_1 = numberService.roundDecimalPlaces(cv.getcv_fty_cost_0() + cv.getcv_fty_cost_0()*newplf.getplf_correction()/100,2);
								var plfd_fty_sell_2 = numberService.roundDecimalPlaces(plfd_fty_sell_1 / plf_cc,2);
								var plfd_fty_sell_3 = plfd_fty_sell_2;

								plfd.setplfd_fty_sell_1(plfd_fty_sell_1);
								plfd.setplfd_fty_sell_2(plfd_fty_sell_2);
								plfd.setplfd_fty_sell_3(plfd_fty_sell_3);
								plfd.setfactory(factory);
								plfd.setcurrency(newplf.getCurrency());
								priceListFactoryDetailService.save(plfd);
							}
						}
					}
				}
				event.renderData(type="json",data={ 'success' : result?true:false , 'message' : result?'Add new price list factory successfully' : 'Add new price list factory failed !','plfid' : newplf.getid_plf()});

			}
			else {
				// transaction {
				// 	try {
						var plf = entityLoad("price_list_factory",{id_plf: rc.id_plf}, true);
						var user_updated = userService.getLoggedInUser();
						var updated = now();

						plf.setUser_Updated(user_updated);
						plf.setZone(rc.idzone==""?JavaCast("null", ""):zoneService.get(rc.idzone));
						var curr_plf = rc.idcurrency==""?JavaCast("null", ""):currencyService.get(rc.idcurrency);
						var ex_rate = val(rc.ex_rate);
						var isExRateChange = ex_rate!= plf.getPlf_Ex_Rate();
						plf.setCurrency(curr_plf);
						plf.setplf_code(rc.code);
						plf.setplf_description(rc.description);
						plf.setplf_season(rc.season);
						plf.setplf_correction(val(rc.correction));
						plf.setplf_Ex_Rate(ex_rate);
						// plf.setplf_date(rc.plfdate);
						plf.setplf_update(updated);
						plf.setuser_updated(user_created);
						var ftycurr = isNull(plf.getFactory())?javaCast("null",""):plf.getFactory().getCurrency();

						PLFService.save(plf);

						var fty_cc = currencyConvertService.getCC_byDate(ftycurr.getId_currency(),dateFormat(plf.getplf_date(),"yyyy-mm-dd"));
						var fty_curr_rate = fty_cc.cc_value;

						var plfd = entityLoad("price_list_factory_detail", {price_list_factory: plf});
						for (var item_plfd in plfd) {
							var plfd_fty_sell_1 = numberService.roundDecimalPlaces(item_plfd.getplfd_fty_cost_0() + item_plfd.getplfd_fty_cost_0()*plf.getplf_correction()/100,2);
							var plfd_fty_sell_2 = numberService.roundDecimalPlaces(plfd_fty_sell_1 / ex_rate,2);

							item_plfd.setPlfd_fty_sell_1(item_plfd.getplfd_fty_cost_0() + item_plfd.getplfd_fty_cost_0()*val(rc.correction)/100);
							item_plfd.setPlfd_fty_sell_2(item_plfd.getplfd_fty_sell_1() / ex_rate);

							item_plfd.setCurrency(curr_plf);
							priceListFactoryDetailService.save(item_plfd);
							if(isExRateChange){
								var plzds = entityload("price_list_zone_details",{price_list_factory_detail: item_plfd});
								for(plzd in plzds){
									price_list_zone_detailsService.updatePriceListZoneDetail(plzd);
								}
							}
						}
						// transactioncommit();
						event.renderData(type="json",data={ 'plfid': plf.getid_plf(),'success' : true , 'message' : 'Update price list factory success' });
				// 	}
				// 	catch(any ex) {
				// 		transactionrollback();
				// 		event.renderData(type="json",data={ 'success' : false , 'message' : 'Update price list factory failed !'});
				// 	}
				// }
			}
		}
	}

	function delete(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			transaction {
				try {
					var plf = PLFService.get(rc.id_plf);
					var plfdetails = entityLoad("price_list_factory_detail",{price_list_factory: plf});
					for(item in plfdetails) {
						entityDelete(item);
					}
					PLFService.delete(plf,true);
					transactioncommit();
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete price list factory successfully' });
				}
				catch(any ex) {
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Can not delete price list factory' });
				}
			}

		}
	}

	public any function getZoneBySeason(event,prc,rc) {
		try {
			var arrZone = [];
			var plf  = EntityLoad('Price_list_factory',{plf_season: rc.season, factory: userService.getLoggedInUser().getFactory()});
			for(item in plf) {
				var strZone = {
					"id_zone": item.getzone().getId_zone(),
					"z_code":item.getzone().getz_code()
				}
				if (!ArrayFindNoCase(arrZone,strZone)) {
					arrayAppend(arrZone, strZone);
				}
			}
			event.renderData(type="json",data={'arrzone':arrZone, 'success':true, 'message': ''});
		}
		catch(any ex) {
			event.renderData(type="json",data={'arrzone':arrZone, 'success':false, 'message': 'Some thing went wrong. Can not get data !'});
		}
	}

	public any function getPlistBySeasonZone(event,prc,rc){
		try {
			var arrPlist = [];
			if(rc.id_zone == "allzone") {
				var plf  = EntityLoad('Price_list_factory',{plf_season: rc.season, factory: userService.getLoggedInUser().getFactory()});
				for(item in plf) {
					var strPList = {
						"id_plf": item.getid_plf(),
						"plf_code":item.getplf_code()
					}
					arrayAppend(arrPlist, strPList);
				}
			}
			else {
				var plf = queryExecute("select id_plf, plf_code from price_list_factory where plf_season = :season and id_zone in (:idZone) and id_Factory = :idfactory", {season: rc.season,idZone:rc.id_zone, idfactory: userService.getLoggedInUser().getFactory().getid_Factory()});
				for(item in plf) {
					var strPList = {
						"id_plf": item.id_plf,
						"plf_code":item.plf_code
					}
					arrayAppend(arrPlist, strPList);
				}
			}
			event.renderData(type="json",data={'arrPlist':arrPlist, 'success':true, 'message': ''});
		}
		catch(any ex) {
			event.renderData(type="json",data={'arrPlist':arrPlist, 'success':false, 'message': 'Some thing went wrong. Can not get data !'});
		}
	}

	public any function getNewSeason(event,prc,rc)
	{
		var limit = 2050;
		var startyear = year(now()) - 1;
		var arrseason = [];
		for(var i = startyear; i <= limit; i++) {
			var strseason = {
				'season': i
			};
			arrayAppend(arrseason, strseason);
		}
		event.renderData(type="json",data={'arrnewseason':arrseason, 'success':true, 'message': ''});
	}

	public any function getallZone() {
		var arrzones = entityLoad("zone");
		var zonels =[];
		for(item in arrzones){
			var zone = {
				"id_Zone" = item.getId_Zone(),
				"z_code" = item.getZ_code()
			};
			arrayAppend(zonels,zone);
		}
		event.renderData(type="json",data={'arrzone':zonels, 'success':true, 'message': ''});
	}

	public any function getPriceListInfo(event,prc,rc) {
		var plf = entityLoad("price_list_factory", {id_plf: rc.id_plf}, true);
		var currency = '';
		var exRate   = '';
		var des      = '';
		if(!isNull(plf)) {
			currency = plf.getcurrency().getcurr_code();
			exRate   = numberService.roundDecimalPlaces(plf.getplf_Ex_Rate(),2);
			des  	 = plf.getplf_description();
		}
		event.renderData(type="json",data={'des': des,'currency':currency,'exrate': exRate, 'success':true});
	}

	private function insertCopy(any newseason,any price_factory, any plf_code, any new_description) {
		var itemzone = price_factory.getzone();
		var plf_date = Now();
		var newplf   = entityNew("price_list_factory");
		newplf.setplf_code(plf_code);
		newplf.setplf_description(new_description);
		newplf.setplf_season(newseason);
		newplf.setplf_correction(price_factory.getplf_correction());
		newplf.setplf_Ex_Rate(price_factory.getplf_Ex_Rate());
		newplf.setplf_date(plf_date);
		newplf.setplf_update(plf_date);
		newplf.setfactory (price_factory.getFactory());
		newplf.setzone(itemzone);
		newplf.setcurrency(price_factory.getCurrency());
		newplf.setuser_created(userService.getLoggedInUser());
		newplf.setlanguage(price_factory.getLanguage());
		var ftycurr = isNull(newplf.getFactory())?javaCast("null",""):newplf.getFactory().getCurrency();
		PLFService.save(newplf);
		//set price list factory detail
		var oldplfdet = entityLoad("price_list_factory_detail", {price_list_factory: price_factory});
		if(arrayLen(oldplfdet)){
			for(item in oldplfdet){
				var costing = item.getCosting();
				var c_version = item.getCosting_version();

				var newplfdet = entityNew("price_list_factory_detail");

				newplfdet.setCosting(costing);
				newplfdet.setCosting_version(c_version);
				
				var plfd_fty_cost_0 = c_version.getCv_fty_cost_0();
				var plf_cc 			= newplf.getplf_Ex_Rate();

				var plfd_fty_sell_1 = numberService.roundDecimalPlaces(plfd_fty_cost_0 + plfd_fty_cost_0*newplf.getplf_correction()/100, 2);
				var plfd_fty_sell_2 = numberService.roundDecimalPlaces(plfd_fty_sell_1 / plf_cc,2);
				var plfd_fty_sell_3 = plfd_fty_sell_2;

				newplfdet.setplfd_fty_cost_0(plfd_fty_cost_0);
				newplfdet.setplfd_fty_sell_1(plfd_fty_sell_1);
				newplfdet.setplfd_fty_sell_2(plfd_fty_sell_2);
				newplfdet.setplfd_fty_sell_3(plfd_fty_sell_3);
				newplfdet.setcreated(plf_date);

				newplfdet.setUser_created(userService.getLoggedInUser());
				newplfdet.setUser_updated(userService.getLoggedInUser());
				newplfdet.setPrice_list_factory(newplf);
				newplfdet.setFactory(item.getFactory());
				newplfdet.setCurrency(item.getCurrency());

				priceListFactoryDetailService.save(newplfdet);
			}
		}
		return newplf.getid_plf();
	}

	public any function CopyDataBlank(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{			
			try {
				var priceFactory       = entityLoad("price_list_factory", {id_plf: rc.sourceplf},true);
				var textplfdes = rc.text_desplf;							
				if(rc.sourcezone != ''){								
					var new_id_plf = insertCopy(rc.desseason, priceFactory, textplfdes, rc.new_description);	
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Copied price list factory successfully', 'new_id_plf' : new_id_plf});
				}					
			}catch(type variable) {					
				event.renderData(type="json",data={ 'success' : false , 'message' : 'Can not copy price list factory successfully'});
			}
		}
	}
	public function checkPlfExist(event, rc, prc){
		if(event.GETHTTPMETHOD() == "POST"){
			var plf = entityLoad("price_list_factory",{plf_code = rc.text_desplf, plf_season= rc.desseason});
			if(arrayLen(plf)){
				event.renderData(type="json",data={ 'isExist' : true, 'message': 'Price List is exist on system!' });
			}else{
				event.renderData(type="json",data={ 'isExist' : false, 'message': '' });
			}			
		}
	}
}