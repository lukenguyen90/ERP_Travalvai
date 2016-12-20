component output="false" displayname=""  {
	 property  name='costingService'              inject='entityService:costing';
	 property  name='costing_versionService'      inject='entityService:costing_versions';
	 property  name='costing_version_desService'  inject='entityService:costing_version_description';
	 property  name='languagesService'            inject='entityService:languages';
	 property  name='userService' 				  inject='userService';
	 property  name='numberService' 			  inject='numberHelper';
	 property  name='currencyConvertService' 	  inject='currency_convertService';
	 property  name='priceListZoneDetailsService' 	  	  inject='price_list_zone_detailsService';
	 property  name='priceListFactoryDetailService' 	  inject='entityService:price_list_factory_detail';

	public function init(){
		return this;
	}

	public any function getCosting(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST"){
			if(not isEmpty(rc.id_cost) or not structKeyExists(rc,"id_cost") or isNull(rc.id_cost)){
				var item  =  entityLoad("costing",{id_cost = rc.id_cost},true);
				if(not IsEmpty(item)){
					var costing    = {};
					var loggedLanguage = userService.getLoggedInUser().getLanguage();
					var idlanguage = loggedLanguage.getId_language();

				    var idcost = item.getId_cost();
				    var type_lang	= isNull(item.getType_of_product())?javaCast("null",""):EntityLoad('type_product_language', {type = item.getType_of_product(), language = EntityLoadByPK("languages", idlanguage)}, true);
				    var costingDes              = queryExecute("select * from costing_description where id_language = #idlanguage# and id_cost=#idcost#");
				    costing.idfactory         	= isNull(item.getFactory())?"":item.getFactory().getid_Factory();
				    costing.Fcurrency         	= isNull(item.getFactory())?"":item.getFactory().getCurrency().getcurr_code();
				    costing.idtype_of_product 	= isNull(item.getType_of_product())?"":item.getType_of_product().getid_type_products();
				    costing.id_cost         	=  item.getId_cost();
				    costing.cost_code       	=  item.getCost_code();
				    costing.description 		=  costingDes.cd_description;
				    costing.cost_season     	=  item.getCost_season();
				    costing.cost_pl         	=  item.getCost_pl()?"YES":"NO";
				    costing.tp_code 			=  isNull(item.getType_of_product())?"":item.getType_of_product().getTp_code();
				    costing.tp_description 		=  isNull(type_lang)?"":type_lang.getDescription();
				    costing.idcustomer        	=  isNull(item.getCustomer())?"":item.getCustomer().getid_Customer();
				    costing.cs_name        		=  isNull(item.getCustomer())?"":item.getCustomer().getCs_name();
				    costing.cost_date       	=  dateformat(item.getCost_date(), "dd-mm-yyyy");
				    costing.cost_update     	=  dateformat(item.getCost_update(), "dd-mm-yyyy");
				    costing.cost_weight     	=  item.getCost_weight();
				    costing.cost_volume     	=  item.getCost_volume();
				    costing.cost_variants   	=  item.getCost_variants();
				    costing.cost_sketch     	=  item.getCost_sketch();

				    return event.renderData(type="json",data=costing);
				}else {
					return event.renderData(type="json",data={"success":false,"message":"Costing do not exist"});
				}
			}else event.renderData(type="json",data={"success":false,"message":"Costing is Required"});
		}
	}

	public any function updateDes(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST"){
			var counterInsearted=0;
			var counteUpdated=0;
			var dataDes = deserializeJSON(rc.des);
			var user_created = userService.getLoggedInUser();
			var created = now();
			for(item in dataDes){
				var language = languagesService.get(id=item.id_language);
				var cv = costing_versionService.get(id=item.id_cv);
				var cvdes = entityLoad("costing_version_description",{language=language,costing_version=cv},true);
				if(not isNull(cvdes)){
					cvdes.setCvd_description(item.description);
					costing_version_desService.save(cvdes);
					counteUpdated++
				}else if(not isEmpty(item.description) and item.description neq ""){
					var cvdes = costing_version_desService.new({
							 cvd_description   : item.description
							 , created         : created
							 , updated         : created
							 , language        : language
							 , costing_version : cv
							 , user_updated    : user_created
							 , user_created    : user_created
						});
					costing_version_desService.save(cvdes);
					counterInsearted++;
				}
			}

			event.renderData(type="json",data={ 'success' : true , 'Inserted' :  counterInsearted, 'updated' : counteUpdated});
		}
	}

	public any function getCosting_Version(event,rc,prc) {
		var userLevel = userService.getUserLevel();
		if(userLevel eq 1){
			if(not IsEmpty(rc.id_cost)){
				var cting = costingService.get(id = rc.id_cost);
				var cvs = [];
				if(!isnull(cting)) {
					var costing_versions  =  entityLoad("costing_versions",{costing = cting});
					for(item in costing_versions){
						var cv={};
						idlanguage = userService.getLoggedInUser().getLanguage().getid_language();
						var idcv = item.getId_cost_version();
						var cvDes = queryExecute("select * from costing_version_description where id_language = #idlanguage# and id_cost_version=#idcv#");

						cv.idcv             = item.getId_cost_version();
						cv.cv_version       = item.getCv_version();
						cv.cv_waste         = item.getCv_waste();
						cv.cv_margin        = item.getCv_margin();
						cv.cv_fty_cost_0    = item.getCv_fty_cost_0();
						cv.cv_weight        = item.getCv_weight();
						cv.cv_volume        = item.getCv_volume();
						cv.cv_sketch        = item.getCv_sketch();
						cv.created        	= dateformat(item.getCreated(), "dd/mm/yyyy");
						cv.updated        	= dateformat(item.getUpdated(), "dd/mm/yyyy");
						cv.cv_description 	= cvDes.cvd_description;
						cv.cv_des = [];
						var des_cvs = entityLoad("costing_version_description",{costing_version = item});
						var descvs = [];
						for(item in des_cvs)
						{
							var des={};
							des.id          = item.getId_cost_version_desc();
							des.des         = item.getCvd_description();
							des.id_language = isNull(item.getLanguage())?"":item.getLanguage().getId_language();
							des.id_cv       = isNull(item.getCosting_Version())?"":item.getCosting_Version().getId_cost_version();
							arrayAppend(descvs,des);
						}
						cv.cv_des = descvs;
						arrayAppend(cvs,cv);
					}
				}

				return event.renderData(type="json",data=cvs);
			}else event.renderData(type="json",data={"success":false,"message":"Do not have the Costing"});
		}else event.renderData(type="json",data={"success":false,"message":"You don not have permission"});
	}

	public any function getCosting_VersionByCVID(event,rc,prc) {
		var userLevel = userService.getUserLevel();
		if(userLevel eq 1){
			if(not IsEmpty(rc.id_cost)){
				var cting = costingService.get(id = rc.id_cost);
				var costing_versions  =  entityLoad("costing_versions",{costing = cting, id_cost_version = rc.id_cv});
				var cvs = [];
				for(item in costing_versions){
					var cv={};
					idlanguage =  userService.getLoggedInUser().getLanguage().getid_language();
					var idcv = item.getId_cost_version();
					var cvDes = queryExecute("select * from costing_version_description where id_language = #idlanguage# and id_cost_version=#idcv#");

					cv.idcv             = item.getId_cost_version();
					cv.cv_version       = item.getCv_version();
					cv.cv_waste         = item.getCv_waste();
					cv.cv_margin        = item.getCv_margin();
					cv.cv_fty_cost_0    = item.getCv_fty_cost_0();
					cv.cv_weight        = item.getCv_weight();
					cv.cv_volume        = item.getCv_volume();
					cv.cv_sketch        = item.getCv_sketch();
					cv.created        	= dateformat(item.getCreated(), "dd/mm/yyyy");
					cv.updated        	= dateformat(item.getUpdated(), "dd/mm/yyyy");
					cv.cv_description 	= cvDes.cvd_description?:"";
					cv.cv_des = [];
					var des_cvs = entityLoad("costing_version_description",{costing_version = item});
					var descvs = [];
					for(item in des_cvs)
					{
						var des={};
						des.id          = item.getId_cost_version_desc();
						des.des         = item.getCvd_description();
						des.id_language = isNull(item.getLanguage())?"":item.getLanguage().getId_language();
						des.id_cv       = isNull(item.getCosting_Version())?"":item.getCosting_Version().getId_cost_version();
						arrayAppend(descvs,des);
					}
					cv.cv_des = descvs;
					arrayAppend(cvs,cv);
				}
				return event.renderData(type="json",data=cvs);
			}else event.renderData(type="json",data={"success":false,"message":"Do not have the Costing"});
		}else event.renderData(type="json",data={"success":false,"message":"You don not have permission"});
	}
	public any function getDes_cv(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST")
		{
			var cv = costing_versionService.get(id=rc.id_cost_version);
			var des_cvs = entityLoad("costing_version_description",{costing_version = cv});
			var descvs = [];
			for(item in des_cvs)
			{
				var des={};
				des.id          = item.getId_cost_version_desc();
				des.des         = item.getCvd_description();
				des.id_language = isNull(item.getLanguage())?"":item.getLanguage().getId_language();
				des.id_cv       = isNull(item.getCosting_Version())?"":item.getCosting_Version().getId_cost_version();
				arrayAppend(descvs,des);
			}
			return event.renderData(type="json",data=descvs);
		}
		return;
	}
	function checkExistVersion(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST"){
			if(rc.id_cost_version == '0' ){
				var costing = EntityLoadByPK("costing", rc.id_cost);
				var result  = entityload("costing_versions",{cv_version : rc.cv_version, costing : costing});
				event.renderData(type="json",data={ 'exists' : (!arrayLen(result) ? false : true)});
			}else{
				var costing = EntityLoadByPK("costing", rc.id_cost);
				var cos_Ver = EntityLoadByPK("costing_versions", rc.id_cost_version);
				var version = cos_ver.getcv_version();
				if(version == rc.cv_version){
					event.renderData(type="json",data={ 'exists' : false});
				}else{
					var result  = entityload("costing_versions",{cv_version : rc.cv_version, costing : costing});
					event.renderData(type="json",data={ 'exists' : (!arrayLen(result) ? false : true)});
				}
			}
		}
	}

	public any function updateCostingVersion(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			// transaction {
				try {
					var user_created = userService.getLoggedInUser();
					var	factory = userService.getLoggedInUser().getFactory();
					var created = now();

					if(rc.id_cost_version == 0) {
						var costingVersion = entityNew("costing_versions");
					}
					else {
						var costingVersion = entityLoad("costing_versions", {id_cost_version: rc.id_cost_version}, true);
					}
					var filename = "";
					if(structKeyExists(rc,'image')){
						if(rc.image neq ''){
							var fc1 = fileupload("#expandpath('/includes/img/ao')#", "#image#" ,"","makeunique");
							filename = fc1.serverfile;
						}
					}
					costingVersion.setcv_version   (rc.cv_version);
					costingVersion.setcv_waste     (rc.cv_waste);
					costingVersion.setcv_margin    (rc.cv_margin);
					costingVersion.setcv_fty_cost_0(rc.cv_fty_cost_0);
					costingVersion.setcv_weight    (rc.cv_weight);
					costingVersion.setcv_volume    (rc.cv_volume);
					costingVersion.setcv_sketch    (filename);
					costingVersion.setupdated      (created);
					costingVersion.setuser_created (user_created);
					costingVersion.setuser_updated (user_created);
					var costing = costingService.get(id=rc.id_cost);
					costingVersion.setCosting(costing);

					costing_versionService.save(costingVersion);

					//Description
					var dataDes = deserializeJSON(rc.des);
					for(item in dataDes){
						var language = languagesService.get(id=item.id_language);
						var cv = costing_versionService.get(id=costingVersion.getId_cost_version());
						var cvdes = entityLoad("costing_version_description",{language=language,costing_version=cv},true);
						if(not isNull(cvdes)){
							cvdes.setCvd_description(item.description);
							costing_version_desService.save(cvdes);
						}else if(not isEmpty(item.description) and item.description neq ""){
							var cvdes = costing_version_desService.new({
									 cvd_description   : item.description
									 , created         : created
									 , updated         : created
									 , language        : language
									 , costing_version : cv
									 , user_updated    : user_created
									 , user_created    : user_created
								});
							costing_version_desService.save(cvdes);
						}
					}

					if(rc.id_cost_version != 0){
						plfd_details = entityload("price_list_factory_detail",{costing_version: costingVersion});
						for(plfd in plfd_details){
							var plf = plfd.getPrice_list_factory();
							plfd.setplfd_fty_cost_0(costingVersion.getcv_fty_cost_0());

							var plf_cc = plf.getPlf_Ex_Rate();

							var plfd_fty_sell_1 = costingVersion.getcv_fty_cost_0() + costingVersion.getcv_fty_cost_0()*plf.getplf_correction()/100;
							var plfd_fty_sell_2 = plfd_fty_sell_1/plf_cc;

							plfd.setplfd_fty_sell_1(plfd_fty_sell_1);
							plfd.setplfd_fty_sell_2(plfd_fty_sell_2);
							priceListFactoryDetailService.save(plfd);
							var plzds = entityload("price_list_zone_details",{price_list_factory_detail: plfd});
							for(plzd in plzds){
								priceListZoneDetailsService.updatePriceListZoneDetail(plzd);
							}
						}
					}

					if(rc.createonpl == true) {
						costing = EntityLoad("costing", {id_cost: rc.id_cost}, true);

						var plfs = EntityLoad("price_list_factory", {plf_season: costing.getCost_season()});
						for (item_plf in plfs) {
							plfDetail = EntityNew("price_list_factory_detail");
							plfDetail.setplfd_fty_cost_0(costingVersion.getCv_fty_cost_0());

							var plf_cc = item_plf.getPlf_Ex_Rate();

							var plfd_fty_sell_1 = val(numberService.roundDecimalPlaces(costingVersion.getcv_fty_cost_0() + costingVersion.getcv_fty_cost_0()*item_plf.getplf_correction()/100,2));
							var plfd_fty_sell_2 = val(numberService.roundDecimalPlaces(plfd_fty_sell_1/plf_cc,2));

							plfDetail.setplfd_fty_sell_1(plfd_fty_sell_1);
							plfDetail.setplfd_fty_sell_2(plfd_fty_sell_2);
							plfDetail.setplfd_fty_sell_3(plfd_fty_sell_2);

							plfDetail.setcosting_version(costingVersion);
							plfDetail.setcosting(costing);
							plfDetail.setprice_list_factory(item_plf);
							plfDetail.setfactory(factory);
							plfDetail.setcurrency(item_plf.getCurrency());
							priceListFactoryDetailService.save(plfDetail);
							var listPlz = entityload("price_list_zone",{price_list_factory: item_plf})
							for(plz in listPlz){
								var new_plzdetail = entityNew("price_list_zone_details");
								var plzcc_value = plz.getplz_ex_Rate();

								new_plzdetail.setplzd_Weight(costingVersion.getcv_weight())

								var plzd_freight = val(numberService.roundDecimalPlaces(costingVersion.getcv_weight() * plz.getPlz_freight()/1000,2));
								var plfd_fty_sell_3  = isNull(plfDetail)?0:val(plfDetail.getPlfd_fty_sell_3());

								var plzd_fty_sell_4 = val(numberService.roundDecimalPlaces(plfd_fty_sell_3/ plzcc_value,2));
								var plzd_taxes = val(numberService.roundDecimalPlaces((plzd_fty_sell_4 + plzd_freight)*plz.getplz_taxes()/100,2));
								var plzd_margin = val(numberService.roundDecimalPlaces((plzd_fty_sell_4 + plzd_freight + plzd_taxes)*plz.getplz_margin()/100,2));
								var plzd_zone_sell_5 = val(numberService.roundDecimalPlaces(plzd_fty_sell_4 + plzd_freight + plzd_taxes + plzd_margin,2));
								var plzd_zone_sell_6 = val(numberService.roundDecimalPlaces(plzd_zone_sell_5,2));
								var plzd_margin_1 = val(numberService.roundDecimalPlaces((plzd_zone_sell_6 - plzd_fty_sell_4 - plzd_freight - plzd_taxes)*100/(plzd_fty_sell_4 + plzd_freight + plzd_taxes),2));
								var plzd_pvpr_7 = val(numberService.roundDecimalPlaces(plzd_zone_sell_6*100/(100 - plz.getplz_commission()),2));
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

								new_plzdetail.setprice_list_zone(plz);
								new_plzdetail.setprice_list_factory_detail(plfDetail);

								priceListZoneDetailsService.save(new_plzdetail);

							}
						}
					}

					// transactioncommit();
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Save costing version successfully!' });
				}
				catch(any ex) {
					// transactionrollback();
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Save costing version fail !' });
				}
			// }
		}
	}

	public any function getSomeFields() {
		var getMaxVerionByCode = QueryExecute("select If(max(CONVERT(cv_version, SIGNED)) is null,0,max(CONVERT(cv_version, SIGNED))) as maxversion from costing_versions where id_cost = :id_cost", {id_cost: rc.id_cost});
		var getWeightVolume = entityLoad("costing", {id_cost: rc.id_cost}, true);
		event.renderData(type="json",data = {newverno: getMaxVerionByCode.maxversion + 1, costweight: getWeightVolume.getCost_weight(), costvolume: getWeightVolume.getCost_volume(), costpl: getWeightVolume.getcost_pl()});
	}

	function deleteCV(event,prc,rc) {
		try {
			var cv = entityLoad("costing_versions", {id_cost_version: rc.id_cv}, true);
			if(!isnull(cv)) {
				var cv_des = entityLoad("costing_version_description", {costing_version: cv});
				for(var item in cv_des) {
					costing_version_desService.delete(item,true);
				}
				costing_versionService.delete(cv,true);
				event.renderData(type="json",data={ 'success' : true , 'message' : 'Deleted costing version successfully' });
			}
			else {
				event.renderData(type="json",data={ 'success' : false , 'message' : 'Costing version does not exists' });
			}
		}
		catch(any ex) {
			event.renderData(type="json",data={ 'success' : false , 'message' : "Costing version can't deleted"});
		}
	}
}