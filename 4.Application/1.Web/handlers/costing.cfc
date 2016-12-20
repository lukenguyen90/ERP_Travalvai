component output="false" displayname=""  {
	  property  name='type_of_productsService'     	inject='entityService:type_of_products';
	  property  name='customerService'           	inject='entityService:customer';
	  property 	name='Costing_desService'           inject='entityService:costing_description';
	  property 	name='factoryService'           	inject='entityService:factory';
	  property 	name='costingService'           	inject='entityService:costing';
	  property 	name='userService'           		inject='userService';
	  property 	name='languagesService'           	inject='entityService:languages';
	  property  name='numberService' 			    inject='numberHelper';

	public function init(){
		return this;
	}

	function getCostingLst(event,prc,rc)
	{
		var Costings = [];
		var userLevel = userService.getUserLevel();
		var costingList = [];
		if(event.GETHTTPMETHOD() == "POST"){
			if(userLevel == 0){
				costingList = EntityLoad('costing',{cost_season = rc.season,cost_pl = 1}, "id_cost desc");
			}else if(userLevel == 1){
				var Efactory = userService.getLoggedInUser().getFactory();
				costingList = EntityLoad('costing',{factory = Efactory,cost_season = rc.season,cost_pl=1}, "id_cost desc");
			}
		}else if(userLevel == 0){
				costingList = EntityLoad('costing', "id_cost desc");
			}else if(userLevel == 1){
				var Efactory = userService.getLoggedInUser().getFactory();
				costingList = EntityLoad('costing',{factory = Efactory}, "id_cost desc");
		}
		if(!isNull(costingList)){
			for(item in costingList) {
				 var tp_code 	= isNull(item.getType_of_product())?"":item.getType_of_product().getTp_code();
			     var costing        		= {};
			     var idlanguage =  userService.getLoggedInUser().getLanguage().getid_language();
			     var idcost = item.getId_cost();
			     var costingDes = queryExecute("select * from costing_description where id_language = #idlanguage# and id_cost=#idcost#");
			     costing.idfactory         	=  isNull(item.getFactory())?"":item.getFactory().getid_Factory();
			     costing.idtype_of_product 	=  isNull(item.getType_of_product())?"":item.getType_of_product().getid_type_products();
			     costing.id_cost         	=  item.getId_cost();
			     costing.cost_code       	=  item.getCost_code();
			     costing.description 		=  costingDes.cd_description;
			     costing.cost_season     	=  item.getCost_season();
			     costing.cost_pl         	=  not isNull(item.getCost_pl()) and item.getCost_pl()?"YES":"NO";
			     costing.tp_code 			=  tp_code;
			     var tp_des = "";
			     var idcustomer 	= isNull(item.getCustomer())?"":item.getCustomer().getid_Customer();
			     var cs_name 		= isNull(item.getCustomer())?"":item.getCustomer().getCs_name();
			     if(!isNull(item.getType_of_product())) {
			     	var typeOfProductLang = entityLoad("type_product_language", {type: item.getType_of_product(), language: userService.getLoggedInUser().getLanguage()}, true);
			     	tp_des = isNull(typeOfProductLang.getdescription())?"":typeOfProductLang.getdescription();
			     }
			     costing.type_of_products 	= tp_code & ' - ' & tp_des;
			     costing.tp_description 	=  tp_des;
			     costing.idcustomer        	=  idcustomer;
			     costing.cs_name        	=  cs_name;
			     costing.customer_detail 	=  idcustomer & ' - ' & cs_name;
			     costing.cost_date       	=  dateformat(item.getCost_date(), "dd/mm/yyyy");
			     costing.cost_update     	=  dateformat(item.getCost_update(), "dd/mm/yyyy");
			     costing.cost_weight     	=  isnull(item.getCost_weight()) ? '' : item.getCost_weight();
			     costing.cost_volume     	=  isnull(item.getCost_volume()) ? '' : item.getCost_volume();
			     var countCV = queryExecute("select count(id_cost_version) as count_cv from costing_versions where id_cost = #item.getid_cost()#");
			     costing.cost_variants   	=  isnull(countCV.count_cv) ? 0 : countCV.count_cv;
			     costing.cost_sketch     	=  isnull(item.getCost_sketch()) ? '' : item.getCost_sketch();
			   ArrayAppend(Costings,costing);
			}
		}
		event.renderData(type="json",data=Costings);
	}


	private any function getCostDes(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST"){
			if(rc.id_cost>0){
				var costing   = costingService.get(id=rc.id_cost);
				var listCost  = entityload("costing_description",{costing=costing});
				var languages = entityload("languages");
				var DEScostList = {};

				for(item in languages){
					var newl = {
						'id_language' = item.getId_language(),
						'lg_code'     = item.getLg_code(),
						'lg_name'     = item.getLg_name(),
						'description' = ""
					};
					DEScostList[item.getId_language()] = newl;
				}

				for(costdes in listCost){
					DEScostList[costdes.getLanguage().getId_language()].description = costdes.getCd_description();
				}
			}
			event.renderData(type="json",data=DEScostList);
		}
	}



	function getCostingVerions(event,prc,rc)
	{
		var viewList = [];
		if(rc.view == 0) {
			viewList = [];
		}
		else {
			var id_costs = "";
			var costings = entityLoad("costing", {cost_season: rc.oseason});
			if(rc.oCode == "all") {
				var denim = "";
				for(item in costings) {
					id_costs &= denim & item.getid_cost();
					denim = ",";
				}
			}
			else {
				var arrTemp = listToArray(rc.oCode, ",");
				var denim ="";
				for(item in arrTemp) {
					if(item neq "all") {
						id_costs &= denim & item;
						denim=",";
					}
				}
			}
			var data = queryExecute( "select c.id_cost,cv.id_cost_version, cv.cv_version, c.cost_code, cd.cd_description, c.cost_season, IF(c.cost_pl = 1, 'YES', 'NO') as cost_pl, c.cost_variants
									from costing_versions cv inner join costing c on cv.id_cost = c.id_cost
									inner join costing_description cd on c.id_cost = cd.id_cost
										WHERE cv.id_cost IN (#id_costs#) and c.cost_pl = 1 and cd.id_language = #userService.getLoggedInUser().getLanguage().getid_language()#" );
			viewList = queryToArray(data);
		}
		event.renderData(type="json",data=viewList);
	}

	private function queryToArray(required query inQuery) {
        result = arrayNew(1);
        for(row in inQuery) {
            item = {};
            for(col in queryColumnArray(inQuery)) {
                item[col] = row[col];
            }
            arrayAppend(result, item);
        }
        return result;
   	}
 //   	for(item in season_costs) {
	// 	var idhash = hash(item.getCost_code() & "" & newSeason,"md5", "utf-8");
	// 	var newcosting = costingService.new({
	// 		  cost_code       : item.getCost_code()
	// 		, cost_season     : newSeason
	// 		, cost_pl         : item.getCost_pl()
	// 		, cost_variants   : 0
	// 		, cost_sketch     : isNull(item.getCost_sketch()) ?"":item.getCost_sketch()
	// 		, factory         : item.getFactory()
	// 		, type_of_product : item.getType_of_product()

	// 		, cost_update     : #LSDateTimeFormat(Now(), 'yyyy-mm-dd HH:nn:ss')#
	// 		, cost_date       : #LSDateTimeFormat(Now(), 'yyyy-mm-dd HH:nn:ss')#
	// 		, user_created    : SESSION.loggedInUserID});
	// 	if(!isNull(customer)){
	// 		newcosting.setcustomer(item.getCustomer());
	// 	}

	// 	if(!checkHashIdExist(idhash)){
	// 		newcosting.setHashid(idhash);
	// 		result = costingService.save(newcosting);
	// 		counter++;

	// 		//Copy Costing Description
	// 		var costingDess = EntityLoad("costing_description",{costing=item});

	// 		for(des in costingDess) {
	// 			var newDesCosting = Costing_desService.new({
	// 				  costing		  : newcosting
	// 				, cd_description  : des.getCd_description()
	// 				, language 		  : des.getLanguage()
	// 				, created 	      : #LSDateTimeFormat(Now(), 'yyyy-mm-dd HH:nn:ss')#
	// 				, updated         : #LSDateTimeFormat(Now(), 'yyyy-mm-dd HH:nn:ss')#
	// 				, user_created    : SESSION.loggedInUserID
	// 				, user_updated    : SESSION.loggedInUserID
	// 				});

	// 			Costing_desService.save(newDesCosting);
	// 		}
	// 	}
	// }

	public any function CopyDataBlank(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.oseason != '0'){
				var oldseason = trim(rc.oseason);
				var newseason = trim(rc.newSeason);
				var newCode  = structKeyExists(rc,"newCode") ? rc.newCode : 0;
				var increase  = structKeyExists(rc,"increase") and not isEmpty(rc.increase)? rc.increase:0;
				increase = val(increase);				
				if(rc.typeOfCopy == "costing"){
					var counter = 0;
					if(rc.oCode == "all"){
						var ocosting = EntityLoad("costing",{cost_season=oldseason,cost_pl = true});
					}else{
						var ocosting = [];
						var costing  = EntityLoad("costing",{cost_season=oldseason,id_cost = rc.oCode},true);
						arrayAppend(ocosting, costing)
					}					
					if(not isnull(ocosting)){
						for(item in ocosting){
							if(rc.oCode == "all" ) {
								var idhash = hash(item.getCost_code() & "" & newSeason,"md5", "utf-8");
							}else{
								var idhash = hash(newCode & "" & newSeason,"md5", "utf-8");
							}
							if(!checkHashIdExist(idhash)) {
								var newcosting = entityNew("costing");
								if(rc.oCode == "all") {
									newcosting.setcost_code(item.getCost_code());
								}
								else {
									newcosting.setcost_code(newCode);
								}
								newcosting.setcost_season(newSeason);								
								newcosting.setcost_pl(numberService.roundDecimalPlaces(item.getCost_pl(),2));
								newcosting.setcost_weight(item.getCost_weight());
								newcosting.setcost_volume(item.getCost_volume());
								newcosting.setcost_variants(0);
								newcosting.setcost_sketch(isNull(item.getCost_sketch()) ?"":item.getCost_sketch());

								newcosting.setcustomer(isNull(item.getCustomer()) ?javaCast("null", ""):item.getCustomer());
								newcosting.setfactory(isNull(item.getFactory()) ?javaCast("null", ""):item.getFactory());
								newcosting.settype_of_product(isNull(item.getType_of_product()) ? javaCast("null", ""):item.getType_of_product());

								newcosting.setcost_update(LSDateTimeFormat(Now(),'yyyy-mm-dd HH:nn:ss'));
								newcosting.setcost_date(LSDateTimeFormat(Now(),'yyyy-mm-dd HH:nn:ss'));
								newcosting.setuser_created(entityLoad("user",{id_user:SESSION.loggedInUserID},true));

								newcosting.setHashid(idhash);
								entitySave(newcosting);
								counter++;
								//Copy Costing Description
								var costingDess = EntityLoad("costing_description",{costing=item});

								for(des in costingDess) {
									var newDesCosting = entityNew("costing_description");
									newDesCosting.setcosting(newcosting);
									newDesCosting.setcd_description(des.getCd_description());
									newDesCosting.setlanguage(des.getLanguage());
									newDesCosting.setcreated(LSDateTimeFormat(Now(),'yyyy-mm-dd HH:nn:ss'));
									newDesCosting.setupdated(LSDateTimeFormat(Now(),'yyyy-mm-dd HH:nn:ss'));
									newDesCosting.setuser_created(userService.getLoggedInUser());
									newDesCosting.setuser_updated(userService.getLoggedInUser());

									entitySave(newDesCosting);
								}

								//copy costing version
								var cv = entityload("costing_versions", {costing=item});
								if(arrayLen(cv) > 0) {
									for(itemcv in cv) {
										var fty_cost_0 = itemcv.getcv_fty_cost_0();
										fty_cost_0 = fty_cost_0 * (1+increase/100);
										var cver = entityNew("costing_versions");
										cver.setcosting(newcosting);
										cver.setcv_version(itemcv.getcv_version());
										cver.setcv_material_cost(itemcv.getcv_material_cost());
										cver.setcv_process_cost(itemcv.getcv_process_cost());
										cver.setcv_waste(itemcv.getcv_waste());
										cver.setcv_structure(itemcv.getcv_structure());
										cver.setcv_margin(itemcv.getcv_margin());
										cver.setcv_fty_cost_0(numberService.roundDecimalPlaces(fty_cost_0 ,2));
										cver.setcv_weight(itemcv.getcv_weight());
										cver.setcv_volume(itemcv.getcv_volume());
										cver.setcv_sketch(itemcv.getcv_sketch());
										cver.setuser_created(userService.getLoggedInUser());
										cver.setuser_updated(userService.getLoggedInUser());
										cver.setupdated(LSDateTimeFormat(Now(), 'yyyy-mm-dd HH:nn:ss'));
										cver.setcreated(LSDateTimeFormat(Now(), 'yyyy-mm-dd HH:nn:ss'));
										entitySave(cver);

										var cver_des = entityload("costing_version_description", {costing_version: itemcv});
										for(itemcvdes in cver_des) {
											var cverDes = entitynew("costing_version_description");
											cverDes.setcvd_description(itemcvdes.getcvd_description());
											cverDes.setcreated(LSDateTimeFormat(Now(), 'yyyy-mm-dd HH:nn:ss'));
											cverDes.setupdated(LSDateTimeFormat(Now(), 'yyyy-mm-dd HH:nn:ss'));
											cverDes.setuser_created(userService.getLoggedInUser());
											cverDes.setuser_updated(userService.getLoggedInUser());
											cverDes.setcosting_version(cver);
											cverDes.setlanguage(itemcvdes.getLanguage());
											entitySave(cverDes)
										}
									}
								}
							}
						}
					}
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Copyed ' & counter &' costing record is successfully'});
				}
			}else{
				if(rc.typeOfCopy == "type_product"){
					var type_prod = entityLoad("type_of_products");
					var counter = 0;
					for(item in type_prod) {
						var idhash = hash(item.gettp_code() & "" & newSeason,"md5", "utf-8");
						var newcosting = costingService.new({
							  cost_code       : item.gettp_code()
							, cost_season     : newSeason
							, cost_pl         : 1
							, cost_variants   : 0
							, factory         : item.getFactory()
							, type_of_product : item.getid_type_products()

							, cost_date       : #LSDateTimeFormat(Now(), 'yyyy-mm-dd HH:nn:ss')#
							, user_created    : SESSION.loggedInUserID});

						if(!checkHashIdExist(idhash)){
							newcosting.setHashid(idhash);
							result = costingService.save(newcosting);
							counter++;
							//Copy Costing Description
							var costingDess = EntityLoad("type_product_language",{type=item});
							for(des in costingDess) {
								var newDesCosting = Costing_desService.new({
									  costing		  : newcosting
									, cd_description  : des.getdescription()
									, language 		  : des.getLanguage()
									, created 	      : #LSDateTimeFormat(Now(), 'yyyy-mm-dd HH:nn:ss')#
									, updated         : #LSDateTimeFormat(Now(), 'yyyy-mm-dd HH:nn:ss')#
									, user_created    : SESSION.loggedInUserID
									, user_updated    : SESSION.loggedInUserID
									});
								Costing_desService.save(newDesCosting);
							}
						}
					}
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Copyed ' & counter &' costing record is successfully'});
				}
			}
		}
	}

	private boolean function checkHashIdExist(hashid) {
		var costing = entityload("costing",{hashid=hashid});
		return !isEmpty(costing);
	}



	function gettype_of_products(event,prc,rc)
	{
		var factory  = factoryService.get(id=userService.getFactoryID());
		var listTP = entityLoad("type_of_products",{factory=factory});
		var languages = entityload("languages");
		var TypeDes = {};

		for(lang in languages){
			var newl = {
				'id_language' = lang.getId_language(),
				'lg_code'     = lang.getLg_code(),
				'lg_name'     = lang.getLg_name(),
				'description' = ""
			};
			TypeDes[lang.getId_language()] = newl;
		}

		var listData = [];

		for(item in listTP){
			var languageCurrent = userService.get(SESSION.loggedInUserID).getlanguage();
			var TypeDesCopy = duplicate(TypeDes);
			var listTPL = entityload("type_product_language",{type = item});
			for(tpl in listTPL){
				TypeDesCopy[tpl.getLanguage().getId_language()].description = tpl.getDescription();
			}
			var description = entityload("type_product_language",{type = item, language = languageCurrent})[1].getdescription();
			if(description == ""){
				var description = entityload("type_product_language",{type = item, language = entityloadByPK("languages", 1)})[1].getdescription();
			}

			if(description != ""){
				var tp_description_set_TpCode = item.getTp_code() & ' - ' & description;
			}else{
				var tp_description_set_TpCode = item.getTp_code();
			}
			var tp_code = len(tp_description_set_TpCode) gt 25 ? left(tp_description_set_TpCode,25)&'...' : tp_description_set_TpCode;
			var myTP = {
				"id_type_products"   = item.getId_type_products()
				, "tp_code"          = tp_code
				, "tp_description"   = description
				, "created"          = item.getCreated()
				, "updated"          = item.getUpdated()
				, "factory"          = item.getFactory().getId_Factory()
				, "group_of_product" = item.getGroup_of_product().getid_group_products()
				, "DES"              = TypeDesCopy
			};
			arrayAppend(listData,myTP);
		}
		event.renderData(type="json",data=listData);
	}


	function getAllSeason(){
		var listSeason = queryExecute("select distinct cost_season from costing order by cost_season asc");
		var lsSeason = [];
		for(item in listSeason)
		{
			var cvSeason={};
			cvSeason.season = item.cost_season;
			arrayAppend(lsSeason,cvSeason);
		}
		event.renderData(type="json",data=lsSeason);
	}

	function checkseasoncode() {
		var costing = entityLoad("costing", {cost_code: rc.newcode, cost_season: rc.newseason}, true);

		if(!isnull(costing)) {
			event.renderData(type="json",data=true);
		}
		else {
			event.renderData(type="json",data=false);
		}
	}


	function addNew(event,prc,rc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_cost == "0"){
				var user_created = userService.getLoggedInUser();
				var userLevel = userService.getUserLevel()
				var created = now();
				var idhash = hash(UCase(rc.cost_code) & "" & rc.cost_season,"md5", "utf-8");

				var newcosting = costingService.new({
										 cost_code:UCase(rc.cost_code)
										, cost_season:rc.cost_season
										, cost_pl:rc.cost_pl
										, cost_weight:rc.cost_weight
										, cost_volume:rc.cost_volume
										, cost_variants:0
										, cost_date:created
										, cost_update:created
										, user_created:user_created
										, user_updated:user_created
									});
				newcosting.setHashid(idhash);

				// set foreign key
				if(userLevel == 0){
					var factory = factoryService.get(rc.idfactory)
					newcosting.setFactory(factory);
				}else if(userLevel == 1){
					var idfactory = userService.getFactoryID();
					var factory = factoryService.get(idfactory);
					newcosting.setFactory(factory);
				}
				if(structKeyExists(rc,"id_customer") and rc.id_customer > 0){
					var customer = customerService.get(id=rc.id_customer);
					newcosting.setCustomer(customer);
				}

				var tp_product = type_of_productsService.get(id = rc.id_type_products);
				newcosting.setType_of_product(tp_product);

	          	if(structKeyExists(rc,'image')){
					if(rc.image neq ''){
						var fc1 = fileupload("#expandpath('/includes/img/ao')#", "#image#" ,"","makeunique");
						newcosting.setCost_sketch(fc1.serverfile);
					}
				}

				if(!checkHashIdExist(idhash)){
					var result = costingService.save(newcosting);
					// Xu ly Costing description Multilanguage
					var dataDes = deserializeJSON(rc.des);
					for(item in dataDes){if(!structKeyExists(dataDes[item], "description")){
							dataDes[item].description = "";
						}
						var language = languagesService.get(id=dataDes[item].id_language);
						var cdes = Costing_desService.new({
								   cd_description  : dataDes[item].description
								 , created         : created
								 , updated         : created
								 , language        : language
								 , costing 		   : newcosting
								 , user_updated    : user_created
								 , user_created    : user_created
							});
						Costing_desService.save(cdes);
					}

					if(result){
						event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new costing successfully' , 'id_cost' : newcosting.getid_cost()});
					}
				}else{
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Season and Code is already exist !' });
				}
			}else{
				var checkSeasonCode = queryExecute("select id_cost from costing where cost_code = '#trim(rc.cost_code)#' and cost_season =#rc.cost_season#");
				if(!checkSeasonCode.recordCount or checkSeasonCode.id_cost == val(rc.id_cost)){
					var costing = costingService.get(id=rc.id_cost);
					var user_updated = userService.getLoggedInUser();
					var updated = now();

					costing.setCost_code(rc.cost_code);
					costing.setCost_season(rc.cost_season);
					costing.setCost_pl(rc.cost_pl);
					costing.setCost_weight(rc.cost_weight);
					costing.setCost_volume(rc.cost_volume);

					costing.setCost_update(updated);
					costing.setUser_updated(user_updated);

					if(structKeyExists(rc,'image')){
						if(rc.image neq ''){
							var fc1 = fileupload("#expandpath('/includes/img/ao')#", "#image#" ,"","makeunique");
							if(fc1.contenttype != "image"){
								var temp = expandpath('/includes/img/ao/')&fc1.serverfile;
								FileDelete(temp);
								event.renderData(type="json",data={ 'success' : false , 'message' : 'Please upload an image file!' });
							}else{
								costing.setCost_sketch(fc1.serverfile);
							}
						}
					}

					if(structKeyExists(rc,"id_customer") and rc.id_customer > 0){
						var customer = customerService.get(id=rc.id_customer);
						costing.setCustomer(customer);
					}
					else{
						costing.setCustomer(javaCast("null",""));
					}

					var idfactory = userService.getFactoryID();
					var factory = factoryService.get(idfactory);
					costing.setFactory(factory);
					var tp = type_of_productsService.get(id=rc.id_type_products)
					costing.setType_of_product(tp);

					costingService.save(costing);



					var dataDes = deserializeJSON(rc.des);
					entityDelete(entityLoad("costing_description", {costing: costing}));

					for(item in dataDes){
						if(!structKeyExists(dataDes[item], "description")){
							dataDes[item].description = "";
						}

						var language = languagesService.get(id=dataDes[item].id_language);
						var cdes = Costing_desService.new({
								   cd_description  : dataDes[item].description
								 , created         : updated
								 , updated         : updated
								 , language        : language
								 , costing 		   : costing
								 , user_updated    : user_updated
								 , user_created    : user_updated
							});
						Costing_desService.save(cdes);
					}

					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update costing successfully!' , 'id_cost' : costing.getid_cost()});
				}else{
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Season and Code is already exist !' });
				}
			}

		}
	}

	function deletecosting(event,prc,rc) {
		transaction {
			try {
				var costing = entityLoad("costing", {id_cost: rc.id_cost}, true);
				if(!isnull(costing)) {
					var plf_det = entityLoad("price_list_factory_detail", {costing: costing});
					if(arraylen(plf_det) > 0) {
						event.renderData(type="json",data={ 'success' : false , 'message' : 'Costing is in use. Can not delete.' });
					}
					else {
						var cd = entityLoad("costing_description", {costing: costing});
						for (itemcd in cd) {
							entityDelete(itemcd);
						}
						var cv = entityLoad("costing_versions", {costing: costing});
						for(var item in cv) {
							var cv_des = entityLoad("costing_version_description", {costing_version: item});
							for(item_child in cv_des) {
								entityDelete(item_child);
							}
							entityDelete(item);
						}
						var oldImage = expandpath('/includes/img/ao/')&costing.getCost_sketch();
						if(FileExists(oldImage)){
							FileDelete(oldImage);
						}
						entityDelete(costing);
						transactioncommit();
						event.renderData(type="json",data={ 'success' : true , 'message' : 'Deleted costing successfully' });
					}
				}
				else {
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Costing does not exists' });
				}
			}
			catch(any ex) {
				transactionrollback();
				event.renderData(type="json",data={ 'success' : false , 'message' : ex.message});
			}
		}
	}
}