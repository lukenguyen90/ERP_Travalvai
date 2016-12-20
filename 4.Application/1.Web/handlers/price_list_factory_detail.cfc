component output="false" displayname=""  {
	property  name="PLF_detailService"    			inject="entityService:price_list_factory_detail";
	property  name="userService"      	   			inject="userService";
	property  name='currencyConvertService' 	    inject='currency_convertService';
	property  name="PLZ_detailService"    			inject="price_list_zone_detailsService";
	property  name="plfdService"    				inject="entityService:price_list_factory_detail";
	property name='numberService' 			inject='numberHelper';

	public function init(){
		return this;
	}

	function getPLF_detail(event,prc,rc)
	{
 	// 	var usertype = userService.getUserLevel();
		// if(usertype eq 1)
		// {
			plf = EntityLoad("price_list_factory", {id_plf: rc.id}, true);
			var plf_details     = [];
			var plf_detailList  = EntityLoad('price_list_factory_detail', {price_list_factory: plf});
			for(item in plf_detailList) {
			   	var plf_detail         			= {};
			   	plf_detail.id          			= item.getid_plf_det();
			   	plf_detail.cost_code   			= isNull(item.getCosting())?"":item.getCosting().getcost_code();
			   	plf_detail.cv_version  			= isNull(item.getCosting_version())?"":item.getCosting_version().getcv_version();
			   	var costDes 					= entityLoad("costing_description", {costing: item.getCosting(), language: entityLoad("languages",{id_language: plf.getLanguage().getId_language()}, true)}, true);
			   	plf_detail.cd_description 		= isNull(costDes)?"":costDes.getcd_description();
			   	var costVerDes 					= entityLoad("costing_version_description", {costing_version: item.getCosting_version(), language: entityLoad("languages",{id_language: plf.getLanguage().getId_language()}, true)}, true);

			   	plf_detail.cvd_description 		= isNull(costVerDes)?"":costVerDes.getCvd_description();

			   	plf_detail.fac_cost		 		= numberService.roundDecimalPlaces(item.getplfd_fty_cost_0(),2);
			   	var temp 						= isNull(item.getFactory())?"":item.getFactory();
			   	if(len(temp)){
			   		plf_detail.curr_code_fac	= isNull(temp.getCurrency())?"":temp.getCurrency().getcurr_code();
			   	}else{
			   		plf_detail.curr_code_fac	= "";
			   	}
			   	plf_detail.curr_code			= isNull(item.getCurrency())?"":item.getCurrency().getcurr_code();
			   	plf_detail.fty_curr				= numberService.roundDecimalPlaces(item.getplfd_fty_sell_1(),2);
			   	plf_detail.pl_curr				= numberService.roundDecimalPlaces(item.getplfd_fty_sell_2(),2);
			   	plf_detail.plfd_fty_sell_3  	= numberService.roundDecimalPlaces(item.getplfd_fty_sell_3(),2);
			   	ArrayAppend(plf_details,plf_detail);
			}
			event.renderData(type="json",data=plf_details);
		// }
	}


	function deletePLF(event, prc, rc){
		var userLevel = userService.getUserLevel();
		if(event.GETHTTPMETHOD() == "POST" and userLevel == 1)
		{
			if(structKeyExists(rc, "id_plf")){
				checkPLFD_in_PLZD = PLZ_detailService.checkPLFExitInPLZDetail(rc.id_plf);
				if(checkPLFD_in_PLZD){
					var price_list_zone = PLZ_detailService.PLF_Exist_In_PLZF(rc.id_plf);
					var strListZoneCode = "";
					for(item in price_list_zone){
						strListZoneCode &= item.plz_code &"; ";
					}
					event.renderData(type="json",data={ 'success' : false , 'message' : "Delete price list factory detail failed. This price list is using for price list zone with code as #strListZoneCode# "});
				}else{
					var result = PLF_detailService.deleteByID(rc.id_plf);
					if(result){
						event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete price list factory detail successfully' });

					}else{
						event.renderData(type="json",data={ 'success' : false , 'message' : 'Delete price list factory detail failed' });
					}
				}
			}
		}else{
			event.renderData(type="json",data={ 'success' : false , 'message' : 'Access denied' });
		}
	}

	function insertPLFDetail(event, prc, rc) {
		// try {
			var plf = EntityLoad("price_list_factory", {id_plf: rc.id_plf}, true);
			var plzs = EntityLoad("price_list_zone",{price_list_factory:plf});

			for(itemcv in rc.arr_cv) {
				costing_version = entityLoad("costing_versions", {id_cost_version: itemcv}, true);
				costing = costing_version.getCosting();

				var user = userService.getLoggedInUser();
				var factory = user.getFactory();
				var checkCV = entityLoad("price_list_factory_detail", {costing: costing, costing_version: costing_version, price_list_factory: plf},true);

				if(isnull(checkCV)) {
					var plfDetail = EntityNew("price_list_factory_detail");
					plfDetail.setcosting_version(costing_version);
					plfDetail.setcosting(costing);
					plfDetail.setprice_list_factory(plf);
					plfDetail.setplfd_fty_cost_0(costing_version.getcv_fty_cost_0());

					var plf_cc = plf.getplf_Ex_Rate();
					var plfd_fty_sell_1 = numberService.roundDecimalPlaces(costing_version.getcv_fty_cost_0() + costing_version.getcv_fty_cost_0()*plf.getplf_correction()/100,2);
					var plfd_fty_sell_2 = numberService.roundDecimalPlaces(plfd_fty_sell_1 / plf_cc,2);

					plfDetail.setplfd_fty_sell_1(plfd_fty_sell_1);
					plfDetail.setplfd_fty_sell_2(plfd_fty_sell_2);
					plfDetail.setplfd_fty_sell_3(plfd_fty_sell_2);

					plfDetail.setfactory(factory);
					plfDetail.setcurrency(plf.getCurrency());
					writeDump(plfDetail.getprice_list_factory());
					plfdService.Save(plfDetail);

					for(plz in plzs){
						var  plzd = entityNew("price_list_zone_details");
						var plfcc_value = plf.getPlf_Ex_Rate();
						var plzcc_value = plz.getPlz_ex_rate();
						plzd.setplzd_Weight(costing_version.getcv_weight());
						plzd.setprice_list_zone(plz);
						plzd.setprice_list_factory_detail(plfDetail);
						var plzd_freight = val(numberService.roundDecimalPlaces(costing_version.getcv_weight() * plz.getPlz_freight()/1000,2));
						var plfd_fty_sell_3  = isNull(plfDetail)?0:plfDetail.getPlfd_fty_sell_3();

						var plzd_fty_sell_4 = val(numberService.roundDecimalPlaces(plfd_fty_sell_3 * (plzcc_value/plfcc_value),2));
						var plzd_taxes = val(numberService.roundDecimalPlaces((plzd_fty_sell_4 + plzd_freight)*plz.getplz_taxes()/100,2));
						var plzd_margin = val(numberService.roundDecimalPlaces((plzd_fty_sell_4 + plzd_freight + plzd_taxes)*plz.getplz_margin()/100,2));
						var plzd_zone_sell_5 = val(numberService.roundDecimalPlaces(plzd_fty_sell_4 + plzd_freight + plzd_taxes + plzd_margin,2));
						var plzd_zone_sell_6 = val(numberService.roundDecimalPlaces(plzd_zone_sell_5,2));
						var plzd_margin_1 = val(numberService.roundDecimalPlaces((plzd_zone_sell_6 - plzd_fty_sell_4 - plzd_freight - plzd_taxes)*100/(plzd_fty_sell_4 + plzd_freight + plzd_taxes),2));
						var plzd_pvpr_7 = val(numberService.roundDecimalPlaces(plzd_zone_sell_6*100/(100 - plz.getplz_commission()),2));
						var plzd_pvpr_8 = plzd_pvpr_7;
						var plzd_margin_2 = val(numberService.roundDecimalPlaces((plzd_pvpr_8 - plzd_zone_sell_6)*100/plzd_pvpr_8,2));

						plzd.SetPlzd_freight(plzd_freight);
						plzd.setPlzd_fty_sell_4(plzd_fty_sell_4);
						plzd.setPlzd_taxes(plzd_taxes);
						plzd.setplzd_Margin(plzd_margin);
						plzd.setPlzd_zone_sell_5(plzd_zone_sell_5);
						plzd.setPlzd_zone_sell_6(plzd_zone_sell_6);
						plzd.setplzd_Margin_1(plzd_margin_1);
						plzd.setPlzd_pvpr_7(plzd_pvpr_7);
						plzd.setplzd_PVPR_8(plzd_pvpr_8);
						plzd.setPlzd_margin_2(plzd_margin_2);
						plzd.setCreated(now());
						plzd.setuser_created(user);
						PLZ_detailService.save(plzd);
					}
				}
			}

			event.renderData(type="json",data={ 'success' : true , 'message' : 'Inserted P.L factory detail successfully!'});
		// }
		// catch(any e) {
		// 	event.renderData(type="json",data={ 'success' : false , 'message' : 'Something went wrong or data is exists. Can not insert data!'});
		// }
	}

	function updatePLFD_FTY_SELL_3(even, prc, rc) {
		var isSuccess = false;
		try {
			var plfd = entityLoad("price_list_factory_detail", {id_plf_det: rc.id}, true);
			if(!isnull(plfd)) {
				plfd.setplfd_fty_sell_3(val(numberService.roundDecimalPlaces(rc.sell3,2)));
				var plzds = entityLoad("price_list_zone_details",{price_list_factory_detail: plfd});
				for(item in plzds){
					PLZ_detailService.updatePriceListZoneDetail(item);
				}
				plfdService.save(plfd);
			}
			isSuccess = true;
		}
		catch(type variable) {
			isSuccess = false;
		}
		event.renderData(type="json",data=isSuccess);
	}

	function getSeason(event,prc,rc)
	{
		var listseason = [];
		var costings = QueryExecute("select distinct cost_season from costing order by cost_season asc");
		for(item in costings) {
		   var itemseason  = {};
		   itemseason.id   		=  item.cost_season;
		   itemseason.season   	=  item.cost_season;
		   if(ArrayContains(listseason,itemseason) == 0){
		   		ArrayAppend(listseason,itemseason);
		   }
		}
		event.renderData(type="json",data=listseason);
	}

	function getCurrencyConvertById(event,prc,rc) {
		var rs = currencyConvertService.getLatest_Cc(rc.id_currency);
		event.renderData(type="json",data=numberService.roundDecimalPlaces(rs.cc_value,2));
	}

	function resetPrice(event, prc, rc) {
		try {
			var plf = entityload("price_list_factory",{id_plf:rc.id_plf},true);
			var plfds = deserializeJSON(rc.filteredData);
			for(item in plfds){
				var plfd = plfdService.get(item.ID);
				plfd.setPlfd_fty_sell_3(plfd.getplfd_fty_sell_2());
				var plzds = entityLoad("price_list_zone_details",{price_list_factory_detail: plfd});
				for(plzd in plzds){
					PLZ_detailService.updatePriceListZoneDetail(plzd);
				}
				plfdService.save(plfd);
			}
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Reset all Prices successfully!'});
		}
		catch(any e) {
			event.renderData(type="json",data={ 'success' : false , 'message' : 'Something went wrong. Can not update data!'});
		}
	}
}