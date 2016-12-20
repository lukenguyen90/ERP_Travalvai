/**
*
* @file  /E/projects/source/handlers/product.cfc
* @author
* @description
*
*/

component output="false" displayname=""  {
	property name="productService" 			inject="productService";
	property name="product_statusService" 	inject="entityService:Product_status";
	property name="product_groupService" 	inject="entityService:Group_of_products";
	property name="product_typeService" 	inject="entityService:Type_of_products";
	property name="group_language" 			inject="entityService:Group_product_language";
	property name="type_language" 			inject="entityService:Type_product_language";
	property name='languagesService'        inject='entityService:languages';
	property name='factoryService' 			inject='entityService:factory';
	property name='contractService' 		inject='entityService:contract';
	property name='userService' 			inject='userService';
	property name='productCustService' 		inject='prod_custService';
	property name='patternsService'     	inject='patternsService';
	property name='patternsVarService'     	inject='pattern_variantionsService';
	property name='customerService' 		inject='customerService';
	property name  = 'numberService' 		inject='numberHelper';

	public function init(){
		return this;
	}
	public function getPatternList(event, rc, prc){
		var userLevel = userService.getUserLevel();
		if(userLevel != 4){
			var factory = factoryService.get(id=userService.getFactoryID());
			var patterns = [];
			var patternsList = EntityLoad('patterns',{factory=factory},"id_pattern desc");
			for(item in patternsList) {
			   var sPattern        = {};
			   sPattern.idPattern  = item.getid_pattern();
			   sPattern.code       = item.getpt_code();
			   sPattern.description 		= patternsService.getPatternDesByLangCurrent(item.getid_pattern());
			   ArrayAppend(patterns,sPattern);
			}
			event.renderData(type="json",data=patterns);
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function getProduct(event,rc,prc){
		var usertype = userService.getUserLevel();
		var productList = entityLoad('product');
		if(usertype == 1 or usertype == 0){
			if(arraylen(productList)){
				var products = [];
				for(product in productList){
					var product = getProductDetail(product);
					ArrayAppend(products,product);
				}
				event.renderData(type="json",data=products);
			}else{
				event.renderData(type="json",data=[]);
			}
		}else if(usertype == 2){
			if(arraylen(productList)){
				var products = [];
				for(product in productList){
					var zoneID 	 = userService.getZoneID();
					var project  = isNull(product)?JavaCast("null", ""):product.getProject();
					var customer = isNull(project)?JavaCast("null", ""):project.getCustomer();
					var agent    = isNull(customer)?JavaCast("null", ""):customer.getAgent();
					var zone     = isNull(agent)?JavaCast("null", ""):agent.getZone();
					if(zone.getid_zone() == zoneID){
						var productDetail = getProductDetail(product);
						ArrayAppend(products,productDetail);
					}
				}
				event.renderData(type="json",data=products);
			}else{
				event.renderData(type="json",data=[]);
			}
		}else if(usertype == 3){
			if(arraylen(productList)){
				var products = [];
				for(product in productList){
					var zoneID   = userService.getZoneID();
					var agentID  = userService.getAgentID();
					var project  = isNull(product)?JavaCast("null", ""):product.getProject();
					var customer = isNull(project)?JavaCast("null", ""):project.getCustomer();
					var agent    = isNull(customer)?JavaCast("null", ""):customer.getAgent();
					var zone     = isNull(agent)?JavaCast("null", ""):agent.getZone();
					if(zone.getid_zone() == zoneID and agent.getid_agent() == agentID){
						var productDetail = getProductDetail(product);
						ArrayAppend(products,productDetail);
					}
				}					
				event.renderData(type="json",data=products);						
			}else{
				event.renderData(type="json",data=[]);
			}
		}else{
			if(arraylen(productList)){
				var products = [];
				for(product in productList){
					var customerID  = val(userService.getCustomerID());
					var project  = isNull(product)?JavaCast("null", ""):product.getProject();
					var customer = isNull(project)?JavaCast("null", ""):project.getCustomer().getid_Customer();
					if(customer == customerID){
						var productDetail = getProductDetail(product);
						ArrayAppend(products,productDetail);
					}
				}					
				event.renderData(type="json",data=products);						
			}else{
				event.renderData(type="json",data=[]);
			}
		}
	}

	function getProductDetail(component productItem){
		var numberFormat = 2;
		var productCust  = EntityLoad("prod_cust",{product = productItem});
		var factoryPriceCus  = 0;
		var agentPriceCus 	 = 0;
		var finalPriceCus 	 = 0;
		var factoryPriceManual = isNull(productItem.getPr_fty_sell_9()) ? 0 : numberService.roundDecimalPlaces(productItem.getPr_fty_sell_9(),numberFormat);
		var agentPriceManual   = isNull(productItem.getPr_zone_sell_10()) ? 0 : numberService.roundDecimalPlaces(productItem.getPr_zone_sell_10(),numberFormat);
		var finalPriceManual   = isnull(productItem.getPr_PVPR_11()) ? 0 : numberService.roundDecimalPlaces(productItem.getPr_PVPR_11(),numberFormat);
		var product            = {};
		var contractID 		   = !isNull(productItem.getContract())?productItem.getContract().getid_contract():0;
		var contract 		   = EntityLoadByPK("contract", contractID);
		//contract and set status color
		var contractDate = "No";
		var contractStatusColor = "";
		var contractYear = "";
		if(!isNull(contract)){
			contractDate 	= dateFormat(contract.getc_date_i(), 'dd/mm/yyyy');
			var startDate	= contract.getc_date_i();
			contractYear 	= " - "&contract.getc_no_of_years();
			var today 		= now();
			var noOfYear 	= contract.getc_no_of_years();
			var currentDay 	= dateDiff("d", startDate,today );
			var daysOfYear 	= 365;
			var totalContactDays = noOfYear * daysOfYear;
			if(currentDay > totalContactDays){
				contractStatusColor = "red";
			}
		}
		//end contract
		var project            = productItem.getProject();
		product.idProduct      = productItem.getId_product();
		product.contractDate   = contractDate;
		product.contractStatusColor = contractStatusColor;
		product.contractYear   = contractYear;
		product.garmentCode    = project.getId_display()&"-"&(isNull(productItem.getPattern())?"":productItem.getPattern().getpt_code())&"-"&(isNull(productItem.getPattern_variantion())?"":productItem.getPattern_variantion().getpv_code());
		product.version        = productItem.getPr_version();
		product.cost_code      = isNull(productItem.getCosting())?"":productItem.getCosting().getCost_code();
		product.cost_code_vers = isNull(productItem.getCosting_versions())?"":productItem.getCosting_versions().getcv_version();
		product.description    = productItem.getPr_description();
		product.sizes          = productItem.getSize().getsz_description();
		product.customer       = (isNull(project.getCustomer())?"":project.getCustomer().getId_customer())&' - '& (isNull(project.getCustomer())?"":project.getCustomer().getCs_name());
		var agent 			   = isNull(project.getCustomer())?javaCast("null", ""):project.getCustomer().getAgent();
		product.agent          = isNull(agent)?"":agent.getAg_description();
		var zone 			   = isNull(agent)?javaCast("null", ""):agent.getZone();
		product.zone           = isNull(zone)?"":zone.getz_description();
		product.section        = productItem.getPr_section();
		product.status         = isNull(productItem.getProduct_status())?"":productItem.getProduct_status().getPr_stat_desc();
		product.sketch         = isNull(productItem.getPr_sketch())?"":productItem.getPr_sketch();
		product.picture        = isNull(productItem.getpr_picture())?"":productItem.getpr_picture();
		product.pr_web 		   = productItem.getpr_web() == 0 ? 'No' : 'Yes';
		var plz_det 		   = productItem.getprice_list_zone_detail();
		var plz_id 			   = plz_det.getprice_list_zone().getid_plz();
		var isPlzExpire 	   = productService.checkPlzExpire(plz_id);
		if(!isPlzExpire){
			product.price = {
				"sell_4" = isnull(plz_det) ? 0 : numberService.roundDecimalPlaces(plz_det.getPlzd_Fty_Sell_4(),numberFormat),
				"sell_6" = isnull(plz_det) ? 0 : numberService.roundDecimalPlaces(plz_det.getPlzd_zone_sell_6(),numberFormat),
				"pvpr_8" = isnull(plz_det) ? 0 : numberService.roundDecimalPlaces(plz_det.getPlzd_pvpr_8(),numberFormat)
			};
		}else{
			product.price = {
				"sell_4" = 0,
				"sell_6" = 0,
				"pvpr_8" = 0
			};
		}
		
		//price for product custom
		if(!isNull(productCust)){
			for(item in productCust){
				var quantity 	= item.getprd_cust_qtty();
				var plz_detail  = EntityLoadByPK("price_list_zone_details",item.getprice_list_zone_detail().getid_plz_det());
				factoryPriceCus += numberService.roundDecimalPlaces(quantity*plz_detail.getplzd_fty_sell_4(),numberFormat);
				agentPriceCus   += numberService.roundDecimalPlaces(quantity*plz_detail.getplzd_zone_sell_6(), numberFormat);
				finalPriceCus   += numberService.roundDecimalPlaces(quantity*plz_detail.getplzd_pvpr_8(), numberFormat);
			}
		}
		if(!isPlzExpire){
			product.customize = {
				"cst_fty" 	   = factoryPriceCus,
				"cst_zone" 	   = agentPriceCus,
				"cst_cs" 	   = finalPriceCus
			};
		}else{
			product.customize = {
				"cst_fty" 	   = 0,
				"cst_zone" 	   = 0,
				"cst_cs" 	   = 0
			};
		}
		//end price product custom
		if(!isPlzExpire){
			product.manual = {
				"sell_9" 	   = factoryPriceManual,
				"sell_10" 	   = agentPriceManual,
				"pvpr_11" 	   = finalPriceManual
			};
		}else{
			product.manual = {
				"sell_9" 	   = 0,
				"sell_10" 	   = 0,
				"pvpr_11" 	   = 0
			};
		}
		//final price
		var finalPriceFactory 	= calFinalPrice(plz_det.getPlzd_Fty_Sell_4(), factoryPriceManual, factoryPriceCus, contractID);
		var finalPriceAgent 	= calFinalPrice(plz_det.getPlzd_zone_sell_6(), agentPriceManual, agentPriceCus, contractID);
		var finalPriceFinal 	= calFinalPrice(plz_det.getPlzd_pvpr_8(), finalPriceManual, finalPriceCus, contractID);
		if(!isPlzExpire){
			product.valid = {
				"valid9" 	   = finalPriceFactory,
				"valid10" 	   = finalPriceAgent,
				"valid11" 	   = finalPriceFinal
			};
		}else{
			product.valid = {
				"valid9" 	   = 0,
				"valid10" 	   = 0,
				"valid11" 	   = 0
			};
		}
		var clubPrice = productItem.getPr_Club_12();
		var webPrice  = productItem.getPr_Web_13();
		product.club_12 = calFinalPrice(0, clubPrice, finalPriceCus, contractID);
		product.web_13 	= calFinalPrice(0, webPrice,  finalPriceCus, contractID);
		return product;
	}

	public function getprojects(event, rc, prc) {
		var usertype = userService.getUserLevel();
		var lstPj = [];
		if((usertype neq 4))
		{
			var projects = entityLoad("project");
			if(!isnull(projects)) {
				for(item in projects) {
					var str = {};
					var des = item.getpj_description();
					var pj_description = len(des) gt 25 ? left(des,25)&'...' : des;
					str["id_Project"] = item.getid_Project();
					str["pj_description"] = pj_description;
					arrayAppend(lstPj, str);
				}
			}
			event.renderData(type="json",data=lstPj);
		}else{
			event.renderData(type="json",data={});
		}
	}

	function getProductById(event,rc,prc){
		if(rc.id != 0 and isNumeric(rc.id)){
			var prd = productService.getProduct(rc.id);
			event.renderData(type="json",data = prd);
		}else event.renderData(type="json",data = "Can't get Info");
	}

	function getFinalPrice(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST"){
			var id_contract		= rc.id_contract;
			var plFactory 		= rc.plFactory;
	    	var plAgent  		= rc.plAgent;
	    	var plFinal 		= rc.plFinal;

	    	var plFactoryManual = rc.plFactoryManual;
	    	var plAgentManual   = rc.plAgentManual;
	    	var plFinalManual   = rc.plFinalManual;

	    	var plFactoryCus 	= rc.plFactoryCus;
	    	var plAgentCus 		= rc.plAgentCus;
	    	var plFinalCus  	= rc.plFinalCus;

	    	var factoryFinalPrice = calFinalPrice(plFactory, plFactoryManual, plFactoryCus, id_contract);
	    	var agentFinalPrice	  = calFinalPrice(plAgent, plAgentManual, plAgentCus, id_contract);
	    	var finalFinalPrice   = calFinalPrice(plFinal, plFinalManual, plFinalCus, id_contract);
	    	event.renderData(type="json",data = {"factoryFinalPrice":factoryFinalPrice, "agentFinalPrice": agentFinalPrice, "finalFinalPrice" : finalFinalPrice});
		}
	}

	function calFinalPrice(numeric priceList, numeric manualPrice, numeric customPrice, numeric idcontract){
		var finalPrice 	 = 0;
		var numberFormat = 2;
		if(manualPrice == 0){
			if(priceList > 0){
				finalPrice = numberService.roundDecimalPlaces(priceList + customPrice,numberFormat);
			}else{
				finalPrice = 0;
			}
		}else{
			if(idcontract == 0){
				finalPrice = numberService.roundDecimalPlaces(manualPrice + customPrice, numberFormat);
			}else{
				var contract 	= entityLoad("contract", {id_contract: idcontract}, true);
				var startDate	= contract.getc_date_i();
				var increase_year = contract.getc_increase_year();
				var today 		= now();
				var noOfYear 	= contract.getc_no_of_years();
				var currentDay 	= dateDiff("d", startDate,today );
				var daysOfYear 	= 365;
				var totalContactDays = noOfYear * daysOfYear;
				if(currentDay > totalContactDays){
					if(priceList > 0){
						finalPrice = numberService.roundDecimalPlaces(priceList + customPrice,numberFormat);
						return finalPrice;
					}else{
						finalPrice = numberService.roundDecimalPlaces(manualPrice + customPrice,numberFormat);
						return finalPrice;
					}
				}
				for(var i =0; i < noOfYear; i++){
					j = i + 1;
					var start = i * daysOfYear;
					var end = j * daysOfYear;
					if( (start < currentDay) && (currentDay < end)){
						finalPrice = numberService.roundDecimalPlaces((((1 + (increase_year/100)) ^ i) * manualPrice + customPrice), numberFormat);
						return finalPrice;
					}
				}
			}
		}
		return finalPrice;
	}

	function caculatorPrdCus(){
		var userLevel = userService.getUserLevel();
		var numberFormat = 2;
		var product 	= EntityLoadByPK("product",LSParseNumber(URL.id));
		var productCust = EntityLoad("prod_cust",{product = product});
		var factoryPriceCus  = 0;
		var agentPriceCus 	 = 0;
		var finalPriceCus 	 = 0;
		if(!isNull(productCust)){
			for(item in productCust){
				var quantity 	= item.getprd_cust_qtty();
				if (userLevel != 4){
					var plz_detail  = EntityLoadByPK("price_list_zone_details",item.getprice_list_zone_detail().getid_plz_det());
					factoryPriceCus += numberService.roundDecimalPlaces(quantity*plz_detail.getplzd_fty_sell_4(),numberFormat);
					agentPriceCus   += numberService.roundDecimalPlaces(quantity*plz_detail.getplzd_zone_sell_6(), numberFormat);
					finalPriceCus   += numberService.roundDecimalPlaces(quantity*plz_detail.getplzd_pvpr_8(), numberFormat);
				}

			}
			event.renderData(type="json",data={"factoryPriceCus":factoryPriceCus, "agentPriceCus":agentPriceCus, "finalPriceCus":finalPriceCus});
		}else{
			event.renderData(type="json",data={"factoryPriceCus":factoryPriceCus, "agentPriceCus":agentPriceCus, "finalPriceCus":finalPriceCus});
		}
	}

	function addNewType(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_Type== 0)
			{
				var user_created = userService.getLoggedInUser();
				var created = now();

				var newZone = product_typeService.new({tp_code:UCase(rc.code)
														,group_of_product : rc.group
														,updated:created,created:created,user_created:user_created,user_updated:user_created
														});
				var factory = factoryService.get(id=userService.getFactoryID());
				newZone.setFactory(factory);
				var result = product_typeService.save(newZone);

				var dataDes = deserializeJSON(rc.des);
				for(item in dataDes){
					if(!structKeyExists(dataDes[item], "description")){
						dataDes[item].description = "";
					}
					var language = languagesService.get(id=dataDes[item].id_language);
					var cdes = type_language.new({
							   description  	: dataDes[item].description
							 , created         	: created
							 , updated         	: created
							 , language        	: language
							 , type 		   	: newZone
							 , user_updated    	: user_created
							 , user_created    	: user_created
						});
					type_language.save(cdes);
				}


				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new product type successfully' , 'typeId' : newZone.getid_type_products(), 'typecode' : newZone.gettp_code()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new product type failed !' });
			}else{
				var zone = product_typeService.get(rc.id_Type);
				var user_updated = userService.getLoggedInUser();
				var updated = now();
				var factory = factoryService.get(id=userService.getFactoryID());

				zone.setFactory(factory);
				zone.setUser_Updated(user_updated);
				zone.setUpdated(updated);
				zone.setTp_code(UCase(rc.code));
				zone.setGroup_of_product(product_groupService.get(rc.group));
				var result = product_typeService.save(zone);

				var dataDes = deserializeJSON(rc.des);
				for(item in dataDes){
					if(!structKeyExists(dataDes[item], "description")){
						dataDes[item].description = "";
					}
					var group_type = EntityLoad("type_product_language", {type = zone, language = EntityLoadByPK("languages", dataDes[item].id_language)}, true);
					group_type.setdescription(dataDes[item].description);
					group_type.setupdated(updated);
					group_type.setuser_updated(user_updated);
					type_language.save(group_type);
				}

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update product type successfully', 'typecode' : zone.gettp_code() });
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update product type failed !' });
			}
		}
	}

	function getproducttype(event,prc,rc)
	{
		var types = [];
		if(userService.getUserLevel() == 0){
			var typeList = EntityLoad('type_of_products');
		}else{
			var factory  = factoryService.get(id=userService.getFactoryID());
			var typeList = EntityLoad('type_of_products',{factory=factory});
		}
		var languagesetting = userService.getUserLanguageSetting();
		var languages = entityload("languages");
		var typePDesList = {};

		for(lang in languages){
			lang["description"] = "";
			typePDesList[lang.getId_language()] = {
				"id_language" : lang.getId_language(),
				"lg_code" 	  : lang.getLg_code(),
				"lg_name"	  : lang.getLg_name(),
				"description" : ""
			};
		}

		for(item in typeList) {
		   var type = {};
		   var ldes= typePDesList;
		   var type_lang	= EntityLoad('type_product_language', {type = item, language = EntityLoadByPK("languages", languagesetting)}, true);
		   var description = EntityLoad('group_product_language', {group = item.getGroup_of_product(), language = EntityLoadByPK("languages", languagesetting)}, true).getDescription();
		   if(description != ""){
		   		var group_prd_description = item.getGroup_of_product().getgp_code() & ' - ' & description;
		   }else{
		   		var group_prd_description = item.getGroup_of_product().getgp_code() & ' - ' & EntityLoad('group_product_language', {group = item.getGroup_of_product(), language = EntityLoadByPK("languages", 1)}, true).getDescription();
		   }		   
		   var code_group_prd_description = len(group_prd_description) gt 61 ? left(group_prd_description,61)&'...' : group_prd_description;
		   	if(isNull(type_lang)){
		   		type.des = "";
		   	}else{
		   		type.des = type_lang.getdescription();
		   	}
		   type.id 			= item.getid_type_products();
		   type.code 		= item.gettp_code();
		   type.group 		= isNull(item.getGroup_of_product())?0:item.getGroup_of_product().getgp_code();
		   type.groupID 	= isNull(item.getGroup_of_product())?0:item.getGroup_of_product().getid_group_products();
		   type.code_group_prd_description = code_group_prd_description;
		   	var full_lang = EntityLoad('type_product_language', {type = item});
		   	for(page in full_lang){
				ldes[page.getLanguage().getId_language()]["description"] = page.getDescription();
			}

			type.full_language = SerializeJson(ldes);

		   ArrayAppend(types,type);
		}

		event.renderData(type="json",data=types);
	}

	function getPrdTypeByCost(event, rc, prc){
		var usertype = userService.getUserLevel();
		var lstTypePrd = [];
		if(usertype neq 4)
		{
			var qTypeProduct = productService.getproducttype(rc.id_cost);
			var qTypeProductDes = productService.getPrdTypeByDes(qTypeProduct.id_type_products);
			if(qTypeProductDes.recordCount) {
				for(item in qTypeProductDes) {
					var str = {};
					str["tp_id"] = item.id_type_products;
					str["des"] = item.description == "" ? item.tp_code : (item.tp_code & "-" & item.description);
					str["tp_code"] = item.tp_code;
					arrayAppend(lstTypePrd, str);
				}
			}
			event.renderData(type="json",data=lstTypePrd);
		}
	}

	function deleteProductStatus(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			var getZone = product_statusService.get(rc.sId);
			product_statusService.delete(getZone,true);
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete status product successfully' });
		}
	}

	function deleteProductGroup(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			try {
				var gProduct = product_groupService.get(rc.gId);
				entityDelete(entityLoad("group_product_language",{group=gProduct}));
				product_groupService.delete(gProduct,true);
				event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete product group successfully!' });
			}
			catch(any e) {
				event.renderData(type="json",data={ 'success' : false , 'message' : 'Failed, Please Delete all relative data' });
			}
		}
	}

	function deleteProductType(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			try {
				var tProduct = product_typeService.get(rc.gId);
				entityDelete(entityLoad("type_product_language",{type=tProduct}));
				product_typeService.delete(tProduct,true);
				event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete product type successfully!' });
			}
			catch(any e) {
				event.renderData(type="json",data={ 'success' : false , 'message' : 'Failed, Please Delete all relative data' });
			}
		}
	}

	public any function addNewGroup(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			var created = now();
			if(rc.id_Group== 0)
			{
				var userType = userService.getUserLevel();
				var user_created = userService.getLoggedInUser();
				var newGProduct = product_groupService.new({gp_code:UCase(rc.code),updated:created,created:created,user_created:user_created,user_updated:user_created});
				var factory = factoryService.get(id=userService.getFactoryID());

				var dataDes = deserializeJSON(rc.des);
				newGProduct.setFactory(factory);
				var result = product_groupService.save(newGProduct);
				for(item in dataDes){
					if(!structKeyExists(dataDes[item], "description")){
						dataDes[item].description = "";
					}
					var language = languagesService.get(id=dataDes[item].id_language);
					var cdes = group_language.new({
							   description  	: dataDes[item].description
							 , created         	: created
							 , updated         	: created
							 , language        	: language
							 , group 		   	: newGProduct
							 , user_updated    	: user_created
							 , user_created    	: user_created
					});
					group_language.save(cdes);
				}
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new product group successfully' , 'groupId' : newGProduct.getid_group_products()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new product group failed !' });
			}else{
				var groupProduct = product_groupService.get(rc.id_Group);
				var user_updated = userService.getLoggedInUser();

				groupProduct.setUser_Updated(user_updated);
				groupProduct.setUpdated(created);
				groupProduct.setGp_code(UCase(rc.code));

				var dataDes = deserializeJSON(rc.des);
				var result = product_groupService.save(groupProduct);
				for(item in dataDes){
					if(!structKeyExists(dataDes[item], "description")){
						dataDes[item].description = "";
					}

					var group_lang = EntityLoad("group_product_language", {group = groupProduct, language = EntityLoadByPK("languages", dataDes[item].id_language)}, true);
					if(isNull(group_lang)){
						var group_lang = group_language.new({
								group : groupProduct,
								language: EntityLoadByPK("languages", dataDes[item].id_language)
							});
					}
					group_lang.setdescription(dataDes[item].description);
					group_lang.setupdated(created);
					group_lang.setuser_updated(user_updated);
					group_language.save(group_lang);
				}

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update product group successfully' });
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update product group failed !' });
			}
		}
	}

	function checkExistCodeGP(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id==0){
				var factory = factoryService.get(id=userService.getFactoryID());
				var result = entityload("group_of_products",{gp_code=UCase(rc.code),factory=factory},true);
				event.renderData(type="json",data={ 'success' : !isNull(result),"cCode": rc.code });
			}else{
				var factory = factoryService.get(id=userService.getFactoryID());
				var listItem = entityload("group_of_products",{gp_code=UCase(rc.code),factory=factory});
				for(item in listItem){
					if(item.getId_group_products() != rc.id)
					{
						return event.renderData(type="json",data={ 'success' : true,"cCode": rc.code });
					}
				}
				event.renderData(type="json",data={ 'success' : false,"cCode": rc.code });
			}
		}
	}

	function checkExistCodePT(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id==0){
				var factory = factoryService.get(id=userService.getFactoryID());
				var result = entityload("type_of_products",{tp_code=UCase(rc.code),factory=factory},true);
				event.renderData(type="json",data={ 'success' : !isNull(result),"cCode": rc.code });
			}else{
				var factory = factoryService.get(id=userService.getFactoryID());
				var listItem = entityload("type_of_products",{tp_code=UCase(rc.code),factory=factory});
				for(item in listItem){
					if(item.getid_type_products() != rc.id)
					{
						return event.renderData(type="json",data={ 'success' : true});
					}
				}
				event.renderData(type="json",data={ 'success' : false });
			}
		}
	}

	function getproductgroup(event,prc,rc)
	{
		var groups = [];
		if(userService.getUserLevel() == 0){
			var groupList = EntityLoad('group_of_products');
		}else{
			var factory = factoryService.get(id=userService.getFactoryID());
			var groupList = EntityLoad('group_of_products',{factory=factory});
		}
		var languagesetting = userService.getUserLanguageSetting();
		var languages = entityload("languages");
		var gProductListDes = {};

		for(lang in languages){
			gProductListDes[lang.getId_language()] = {
				"id_language" : lang.getId_language(),
				"lg_code" 	  : lang.getLg_code(),
				"lg_name"	  : lang.getLg_name(),
				"description" : ""
			};;
		}

		for(item in groupList) {
			var ldes = gProductListDes;
		   	var group = {};
		   	group.id 		= item.getid_group_products();
		   	group.code 		= item.getgp_code();
		   	var group_lang	= EntityLoad('group_product_language', {group = item, language = EntityLoadByPK("languages", languagesetting)}, true);

		   	if(isNull(group_lang)){
		   		group.des = "";
		   	}else{
		   		group.des = group_lang.getDescription();
		   	}
		   	var full_lang = EntityLoad('group_product_language', {group = item});

		   	for(page in full_lang){
				ldes[page.getLanguage().getId_language()]["description"] = page.getDescription();
			}
			group.full_language = SerializeJson(ldes);

		   	ArrayAppend(groups,group);
		}

		event.renderData(type="json",data=groups);
	}

	public any function addNewStatus(event,rc,prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id_Status== 0)
			{
				var newZone = product_statusService.new({pr_stat_desc:rc.description});
				var result = product_statusService.save(newZone);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new product status successfully' , 'zoneId' : newZone.getid_pr_status()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new zone failed !' });
			}else{
				var zone = product_statusService.get(rc.id_Status);
				zone.setPr_stat_desc(rc.description);
				var result = product_statusService.save(zone);

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Update product status successfully' });
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Update product status failed !' });
			}
		}
	}

	public function getZone(event, rc, prc){
		var userType = userService.getUserLevel();
		if(userType == 1){
			var zone = entityLoad('zone');
			var aZoneInfo = [];
			for(item in zone){
				var struZoneInfo = {};
				struZoneInfo["id_zone"] = item.getid_zone();
				struZoneInfo["z_code"]	= item.getz_code() & " - " & item.getz_description();
				arrayAppend(aZoneInfo, struZoneInfo);
			}
			event.renderData(type="json",data=aZoneInfo);
		}else{
			event.renderData(type="json",data=[]);
		}
	}


	public function getAgent(event, rc, prc){
		var userType = userService.getUserLevel();
		if(event.GETHTTPMETHOD() == "POST"){
			if(userType == 1){
				var aAgentInfo = [];
				var zone = EntityLoadByPK('zone',rc.id_zone);
				var agent = entityLoad('agent',{zone = zone});
				var aAgentInfo = [];
				for(item in agent){
					var struAgentInfo = {};
					struAgentInfo["id_agent"] = item.getid_agent();
					struAgentInfo["ag_code"]	= item.getId_agent() & " - " & item.getag_code();
					arrayAppend(aAgentInfo, struAgentInfo);
				}
				event.renderData(type="json",data=aAgentInfo);
			}
		}
		if(userType == 2){
			var aAgentInfo = [];
			var aAgentID = listToArray(userService.getAgentID());
			for(item in aAgentID){
				var agent = EntityLoadByPK("agent",item);
				var struAgentInfo = {};
				struAgentInfo["id_agent"] = agent.getid_agent();
				struAgentInfo["ag_code"]	= agent.getId_agent() & " - " & agent.getag_code();
				arrayAppend(aAgentInfo, struAgentInfo);
			}
			event.renderData(type="json",data=aAgentInfo);
		}
	}

	public function getCustomer(event, rc, prc){
		var userType = userService.getUserLevel();
		if(userType != 4 ){
			
			if(structKeyExists(rc,"id_agent") and userType != 3) {
				var agent = entityLoad("agent",{id_Agent:rc.id_agent},true);
				var id_agent = agent.getId_agent();
			}
			else if(userType == 3){
				var agent =userService.getLoggedInUser().getAgent();
				var id_agent = agent.getId_agent();
			}

			var zone = agent.getZone().getId_Zone();
			var prl ={};
			var custInfos = customerService.getcustomerByIdAgent(id_agent);
			var pricelistZone = productService.getplz_id(id_agent);
			if(pricelistZone.recordCount != 0) {
				prl = {
					"id_plz" : pricelistZone.id_plz,
					"des" : pricelistZone.plz_code&"_"&pricelistZone.plz_description
				};
			}

			var projects = productService.getProject(zone,id_agent);

			var data = {
					  "custs": custInfos
					, "projectIsExist" : arraylen(projects) != 0
					, "priceListExist" : pricelistZone.recordCount != 0
					, "priceList": prl
			};
			event.renderData(type="json",data=data);
		}else{
			event.renderData(type="json",data=[]);
		}
	}

	public function getplz_id(event, rc, prc) {
		var usertype = userService.getUserLevel();
		var zoneID = userService.getZoneID();
		var agentID = userService.getAgentID();
		var lstPlz_dets = [];
		var lstPj = [];
		// if(event.GETHTTPMETHOD() == "POST"){
			if(usertype neq 4){
				if(structKeyExists(rc, "id_zone")){
					zoneID = rc.id_zone;
				}

				if(structKeyExists(rc, "id_agent")){
					agentID = rc.id_agent;
				}

				if(structKeyExists(rc, "id_customer")){
					customerId = rc.id_customer;
				}
				else if(userType == 3){
					customerId = userService.getLoggedInUser().getCustomer().getId_customer();
				}

				var qPlz = productService.getplz_id(agentID);
				if(!isNull(qPlz)) {
					for(item in qPlz) {
						var str = {};
						str["id_plz"] = item.id_plz;
						str["des"] = item.plz_code&"_"&item.plz_description;
						arrayAppend(lstPlz_dets, str);
					}
				}
				
				if(userType < 4){
					var aProject = productService.getProjectByCustomer(customerId);
				}
				
				if(!isnull(aProject)) {
					for(item in aProject) {
						var str = {};
						var des = item.pj_description;
						var pj_description = len(des) gt 25 ? left(des,25)&'...' : des;
						str["id_Project"] = item.id_Project;
						str["pj_description"] = item.id_display & " - " & pj_description;
						arrayAppend(lstPj, str);
					}
				}
				event.renderData(type="json",data={"priceList":lstPlz_dets, "project":lstPj,});
			}
		// }
	}

	public function getcost_code(event,rc,prc) {
		var usertype = userService.getUserLevel();
		var lstCodes = []
		if(usertype neq 4){
			if(structKeyExists(rc, "plz_id")){
				var costing = productService.getcode_cost(rc.plz_id);
			}else{
				var costing = [];
			}

			if(!isNull(costing)) {
				for(item in costing) {
					var str = {};
					str["id_cost"] = item.id_cost;
					str["cost_code"] = item.cost_code & " - " & item.cd_description;
					arrayAppend(lstCodes, str);
				}
				event.renderData(type="json",data=lstCodes);
			}else{
				event.renderData(type="json",data={'message' : 'No price list zone detail in price list'});
			}

		}else{
			event.renderData(type="json",data={});
		}
	}

	public function getcost_codePrdCus(event,rc,prc) {
		var usertype = userService.getUserLevel();
		var lstCodes = []
		if(usertype neq 4){
			if(structKeyExists(rc, "plz_id")){
				var costing = productCustService.getCostCodeForPrdCus(rc.plz_id);
			}else{
				var costing = productCustService.getCostCodeForPrdCus();
			}
			if(!isNull(costing)) {
				for(item in costing) {
					var str = {};
					str["id_cost"] = item.id_cost;
					str["cost_code"] = item.cost_code;
					arrayAppend(lstCodes, str);
				}
				event.renderData(type="json",data=lstCodes);
			}else{
				event.renderData(type="json",data={'message' : 'No price list zone detail in price list'});
			}

		}else{
			event.renderData(type="json",data={});
		}
	}

	public function getcost_version(event,rc,prc) {
		var usertype = userService.getUserLevel();
		var lstVers = []
		if(usertype neq 4){
			var cv = productService.getcost_version(rc.id_cost);
			if(cv.recordCount) {
				for(item in cv) {
					var str = {};
					str["id_cost_version"] = item.id_cost_version;
					str["cv_version"] = item.cv_version &" - "& item.cvd_description;
					arrayAppend(lstVers, str);
				}
			}
			event.renderData(type="json",data=lstVers);
		}else{
			event.renderData(type="json",data="");
		}
	}
	public function getCostVerForPrdCus(event, rc, prc){
		var usertype = userService.getUserLevel();
		var lstVers = [];
		if(usertype neq 4){
			var aCostCodeCUS = productService.getcost_version(rc.cost_codeID);
			if(aCostCodeCUS.recordCount) {
				for(item in aCostCodeCUS) {
					var str = {};
					str["id_cost_version"] = item.id_cost_version;
					str["cv_version"] = item.cvd_description;
					arrayAppend(lstVers, str);
				}
			}
			event.renderData(type="json",data=lstVers);
		}else{
			event.renderData(type="json",data="");
		}
	}

	public function getPattern(event, rc, prc) {
		var usertype = userService.getUserLevel();
		var lstPatt = []
		if((usertype neq 4))
		{
			var patterns = patternsService.getAllPatternDesByLangCurrent();
			if(arrayLen(patterns)) {
				for(item in patterns) {
					var des = item.pt_code & (item.pd_description != "" ? " - " : "") & item.pd_description;
					var pt_code = len(des) gt 32 ? left(des,32)&'...' : des;
					var str = {};
					str["id_pattern"] = item.id_pattern;
					str["pt_code"] 	  = pt_code;
					arrayAppend(lstPatt, str);
				}
				event.renderData(type="json",data=lstPatt);
			}else{
				event.renderData(type="json",data=[]);
			}

		}else{
			event.renderData(type="json",data={});
		}
	}

	public function getPatternVar(event, rc, prc) {
		var usertype = userService.getUserLevel();
		var lstPattVar = [];
		if(event.GETHTTPMETHOD() == "POST"){
			if(usertype neq 4){
				var patternsVar = patternsVarService.getPatternVariForAddProduct(rc.id_pattern);
				if(arrayLen(patternsVar)) {
					for(item in patternsVar) {
						var des = item.pv_code & (item.pv_description != "" ? " - " : "") & item.pv_description;
						var pv_code = len(des) gt 32 ? left(des,32)&'...' : des;
						var str = {};
						str["id_pattern_var"] = item.id_pattern_var;
						str["pv_code"] = pv_code;
						arrayAppend(lstPattVar, str);
					}
				}else{
					event.renderData(type="json",data=[]);
				}
				event.renderData(type="json",data=lstPattVar);
			}
		}
	}

	public function getSizes(event, rc, prc) {
		var usertype = userService.getUserLevel();
		var lstSizes = [];
		var sizes = entityLoad("sizes");
		if(!isnull(sizes)) {
			for(item in sizes) {
				var str = {};
				str["id_size"] = item.getid_size();
				str["sz_description"] = item.getsz_description();
				arrayAppend(lstSizes, str);
			}
		}
		event.renderData(type="json",data=lstSizes);
	}

	public function addNewProduct(event, rc, prc) {
		var usertype = userService.getUserLevel();
		var user_created = userService.get(SESSION.loggedInUserID);
		if(event.GETHTTPMETHOD() == "POST")
		{
			try {
				var project = entityLoad('project', {id_Project: rc.id_project},true);
				var newProduct = productService.new();
				if(userType != 4){
					var idplz_det = QueryExecute("
					      				select id_plz_det
										from price_list_zone_details
										where id_plz = #rc.id_plz_id# and id_plf_det in
											(select id_plf_det
											from price_list_factory_detail
											where id_cost = #rc.id_cost# and id_cost_version = #rc.id_cost_version#)
							      			");
					newProduct.setprice_list_zone_detail(idplz_det.id_plz_det);
		      		var plz_det = QueryExecute("SELECT *
		      									FROM price_list_zone_details
		      									WHERE id_plz_det = #idplz_det.id_plz_det#");
		      		newProduct.setprice_list_zone_detail(entityLoad("price_list_zone_details", {id_plz_det: plz_det.id_plz_det}, true));
				}
				newProduct.setpr_date(DateFormat(now(),'dd/mm/yyyy'));
				newProduct.setpr_version(rc.pr_version);
	      		newProduct.setproject(project);
	      		newProduct.setcosting(entityLoad('costing', {id_cost: rc.id_cost},true));
	      		newProduct.setcosting_versions(entityLoad('costing_versions', {id_cost_version: rc.id_cost_version},true));
	      		newProduct.settype_of_products(entityLoad('type_of_products', {id_type_products: rc.id_tp_code},true));
	      		newProduct.setpattern(entityLoad('patterns', {id_pattern: rc.id_pattern},true));
	      		newProduct.setpattern_variantion(entityLoad('pattern_variantions', {id_pattern_var: rc.id_pattern_var},true));
	      		newProduct.setsize(entityLoad('sizes', {id_size: rc.id_size},true));
	      		newProduct.setpr_section(isnull(rc.section) ? '' : rc.section);
	      		newProduct.setpr_description(isnull(rc.pr_des) ? '' : rc.pr_des);
	      		newProduct.setuser_created(user_created);
	      		newProduct.setpr_Club_12(0);
	      		newProduct.setpr_Web_13(0);


	      		if(structKeyExists(rc,'image')){
					if(rc.image neq ''){
						var fc1 = fileupload("#expandpath('/includes/img/ao')#", "#image#" ,"","makeunique");
						newProduct.setpr_sketch(fc1.serverfile);
					}
				}
				if(structKeyExists(rc,'picture')){
					if(rc.picture neq ''){
						var fc2 = fileupload("#expandpath('/includes/img/ao')#", "#picture#" ,"","makeunique");
						newProduct.setpr_picture(fc2.serverfile);
					}
				}
				productService.save(newProduct);
				event.renderData(type="json", data = {'success': true, 'message': 'New product added successfully !', 'id_product': newProduct.getId_product()});
			}
			catch(any ex) {
				event.renderData(type="json", data = {'success': false, 'message': 'New product added failed !'});
			}
		}
	}


	public any function editProduct(event, rc, prc) {
		if(event.GETHTTPMETHOD() == "POST")
		{
			var usertype = userService.getUserLevel();
			var user_updated = userService.get(SESSION.loggedInUserID);
			if(isNumeric(rc.id_Product) and rc.id_Product >0){
				try{
					var product = productService.get(id=rc.id_Product);
					var pr_status = product_statusService.get(id=rc.product_status);
					var p_variation = entityload("pattern_variantions",{id_pattern_var:rc.pattern_var},true);
					var project = entityLoad('project', {id_Project: rc.project},true);
					product.setpr_version(rc.pr_version);
		      		product.setproject(project);
		      		product.setcosting(entityLoad('costing', {id_cost: rc.cost},true));
		      		product.setcosting_versions(entityLoad('costing_versions', {id_cost_version: rc.cost_version},true));
		      		product.setpattern(entityLoad('patterns', {id_pattern: rc.pattern},true));
		      		product.setsize(entityLoad('sizes', {id_size: rc.size},true));
		      		product.setProduct_status(!isNull(pr_status.getid_pr_status())? pr_status : JavaCast("null", ""));
		      		product.setPattern_variantion(p_variation);
		      		product.setpr_section(isnull(rc.pr_section) ? '' : rc.pr_section);
		      		product.setpr_description(isnull(rc.pr_description) ? '' : rc.pr_description);
		      		product.setcontract(EntityLoadByPK("contract",rc.id_contract));
		      		product.setPr_web(rc.pr_web);
		      		product.setPr_date(rc.pr_date);
		      		product.setPr_date_update(rc.pr_date_update);
		      		product.setuser_updated(user_updated);
		      		product.setpr_comment(rc.pr_comment != "undefined" and rc.pr_comment != "null" ? rc.pr_comment : JavaCast("null", ""));
		      		product.setpr_commission(rc.pr_commission != "undefined" and rc.pr_commission != "null" ? rc.pr_commission : 0);
		      		// if(usertype != 4){
		      		// 	var plz_det = QueryExecute("SELECT * FROM price_list_zone_details plz_det
										// 		inner join price_list_factory_detail plf_det on plz_det.id_plf_det = plf_det.id_plf_det
										// 		inner join price_list_factory plf on plf_det.id_plf = plf.id_plf
										// 		where plf.id_zone = #project.getCustomer().getZone().getId_zone()# and id_cost = #rc.cost# and id_cost_version = #rc.cost_version# and id_plz = #rc.id_plz#");
		      		// 	writeDump(plz_det);abort;
		      		// 	product.setPrice_list_zone_detail(entityLoad("price_list_zone_details", {id_plz_det: plz_det.id_plz_det}, true));
		      		// }
		      		if(structKeyExists(rc,'pr_sketch')){
						if(rc.pr_sketch neq ''){
							var fsk1 = fileupload("#expandpath('/includes/img/ao')#", "#pr_sketch#" ,"","makeunique");
							product.setpr_sketch(fsk1.serverfile);
							var epr_picture = fsk1.serverfile;
						}
					}

					if(structKeyExists(rc,'pr_picture')){
						if(rc.pr_picture neq ''){
							var fc1 = fileupload("#expandpath('/includes/img/ao')#", "#pr_picture#" ,"","makeunique");
							product.setPr_picture(fc1.serverfile);
							var epr_sketch = fc1.serverfile;
						}
					}
		      		product.setPr_fty_sell_9(rc.pr_fty_sell_9);
		      		product.setPr_zone_sell_10(rc.pr_zone_sell_10);
		      		product.setPr_pvpr_11(rc.pr_pvpr_11);
		      		product.setPr_club_12(rc.pr_club_12);
		      		product.setpr_web_13(rc.pr_web_13);
					productService.save(product);
					var eprd = productService.getProduct(rc.id_Product);
					event.renderData(type="json", data = {'success': true, 'message': 'Updated product successfully !', 'id_product': product.getId_product(),'prd': eprd});
				}
				catch(any ex) {
					event.renderData(type="json", data = {'success': false, 'message': 'Product updated failed !'});
				}
			}
		}
	}

	public function deleteProduct(event, rc, prc) {
		if(event.GETHTTPMETHOD() == "POST") {
			// try {
				var product = entityLoad("product", {id_product: rc.id_product}, true);
				var productCus = entityLoad("prod_cust", {product: product});
				var plf_det = entityLoad("price_list_factory_detail", {costing: product.getcosting()});
				if(arraylen(plf_det) > 0) {
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Product is in use. Can not delete.' });
				}
				var oldImagesSketch = expandpath('/includes/img/ao/')&product.getPr_sketch();
				var oldImagesPicture = expandpath('/includes/img/ao/')&product.getPr_picture();
				for(item in productCus){
					entityDelete(item);
				}
				entityDelete(product);
				ormflush();
				if(FileExists(oldImagesSketch)){
					FileDelete(oldImagesSketch);
				}
				if(FileExists(oldImagesPicture)){
					FileDelete(oldImagesPicture);
				}
				event.renderData(type="json", data = {'success': true, 'message': 'Delete product successfully !'});
			// }
			// catch(any ex) {
			// 	event.renderData(type="json", data = {'success': false, 'message': 'Delete product failed !'});
			// }
		}
	}

	public function getCostCodeForPrdCus(event, rc, prc){
		var aCostCodeCST = productCustService.getCostCodeForPrdCus();
		event.renderData(type="json", data = aCostCodeCST);
	}
	public function checkExistCusCode(event, rc, prc){
		if(event.GETHTTPMETHOD() == "POST"){
			if(rc.id_prdcust == 0){
				var result = productCustService.checkProdCus(rc.cost_id, rc.cost_versionID, URL.id);
				event.renderData(type="json",data={ 'exist' : ((arraylen(result) gt 0) ? true : false) });
			}else{
				var result = productCustService.checkProdCus(rc.cost_id, rc.cost_versionID);
				event.renderData(type="json",data={ 'exist' : ((arraylen(result) gt 0) ? false : true) });
			}
		}
	}

	public function addProdCus(event, rc, prc){
		if(event.GETHTTPMETHOD() == "POST"){
			if(structKeyExists(URL, "id")){
				if(rc.id_prdcust == 0){
					var usertype = userService.getUserLevel();
					var id_plz_det = '';
					var IdLangDefault = userService.get(SESSION.loggedInUserID).getlanguage().getid_language();
					var prdcus = productCustService.new({
						 cost_code 			: rc.cost_id
						,cv_version			: rc.cost_versionID
						,prd_cust_qtty		: rc.quantity
						,prd_cust_description : structKeyExists(rc, "des")? rc.des : ""
						,product            : URL.id
					});
					if(userType != 4){
						var idplz_det = QueryExecute("
						      				select id_plz_det
											from price_list_zone_details
											where id_plz = #rc.id_plz# and id_plf_det in
												(select id_plf_det
												from price_list_factory_detail
												where id_cost = #rc.cost_id# and id_cost_version = #rc.cost_versionID#)
								      	");
						id_plz_det = idplz_det.id_plz_det;
						prdcus.setprice_list_zone_detail(EntityLoadByPK("price_list_zone_details", id_plz_det));
					}
					var result = productCustService.save(prdcus);
					if(result){
						event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new product custom successfully!' });
					}else{
						event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new product custom failed !' });
					}
				}else{
					var IdLangDefault = userService.get(SESSION.loggedInUserID).getlanguage().getid_language();
					prdcus = productCustService.get(id_prdcust);
					prdCus.setcost_code(rc.cost_id);
					prdCus.setcv_version(rc.cost_versionID);
					prdCus.setprd_cust_qtty(rc.quantity);
					prdCus.setprd_cust_description(structKeyExists(rc, "des")? rc.des : prdCus.getprd_cust_description());
					var result = productCustService.save(prdCus);
					if(result){
						event.renderData(type="json",data={ 'success' : true , 'message' : 'Edit product custom successfully!' });
					}else{
						event.renderData(type="json",data={ 'success' : false , 'message' : 'Edit new product custom failed !' });
					}
				}
			}
		}
	}

	public function getProductCus(event, rc, prc){
		if(structKeyExists(URL, "id")){
			var prdCus = productCustService.getProdCus(URL.id);
			event.renderData(type="json",data=prdCus);
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function editProductCus(event, rc, prc){
		if(structKeyExists(URL, "id")){
			var prdCus = productCustService.getProdCusID(URL.id, id_prd_cust);
			event.renderData(type="json",data=prdCus);
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function deleleProdCus(event, rc, prc){
		if(event.GETHTTPMETHOD() == "POST")
		{
			var del = productCustService.deleteByID(rc.id_prdcust);
			if(del){
				event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete product custom successfully' });
			}else{
				event.renderData(type="json",data={ 'success' : false , 'message' : 'Delete product custom failed' });
			}

		}
	}

	public function getImagesOfProducts(event, rc, prc) {
		try {
			var lstimages = [];
			var products = entityLoad('product');
			for(item in products) {
				if(!isNull(item.getPr_sketch())){
					var sketch = item.getPr_sketch();
				}
				if(!isNull(item.getpr_picture())){
					var picture = item.getpr_picture();
				}
				arrayAppend(lstimages, {"sketch": sketch, "picture": picture, "productId" : item.getid_product()});
			}
			event.renderData(type="json", data = lstimages);
		}
		catch(any ex) {
			event.renderData(type="json", data = {'success': false, 'message': 'Delete product failed !'});
		}
	}

	public function getInfoToEditById(event, rc, prc) {
		try {
			var rs= {};
			var product = entityLoad("product", {id_product: rc.id_product}, true);
			rs.prId 				= product.getId_product();
			rs.prversion 			= product.getPr_version();
			rs.prdes 				= product.getPr_description();
			rs.sell_9 		  		= isnull(product.getPr_fty_sell_9()) ? "" : product.getPr_fty_sell_9();
			rs.sell_10 	   			= isnull(product.getPr_zone_sell_10()) ? "" : product.getPr_zone_sell_10();
			rs.pvpr_11 	   			= isnull(product.getPr_PVPR_11()) ? "" : product.getPr_PVPR_11();
			rs.club_12 	   			= product.getPr_Club_12();
			rs.web_13 	    		= product.getPr_Web_13();
			event.renderData(type="json", data = {'success': true, 'data': rs});
		}
		catch(any ex) {
			event.renderData(type="json", data = {'success': false, 'message': 'Get data product failed !'});
		}
	}

	public function updateInfoProduct(event, rc, prc) {
		try {
			var product = entityLoad("product", {id_product: rc.prId}, true);
			product.setPr_version(rc.prversion);
			product.setPr_description(rc.prdes);
			if(isFullEdit == true) {
				product.setPr_fty_sell_9(rc.pricefty);
				product.setPr_zone_sell_10(rc.pricezone);
				product.setPr_PVPR_11(rc.pricecustomer);
				product.setPr_Club_12(rc.priceclub);
				product.setPr_Web_13(rc.priceweb);
			}
			entitySave(product);
			ormflush();
			event.renderData(type="json", data = {'success': true, 'message': 'Update product successfully !'});
		}
		catch(any ex) {
			event.renderData(type="json", data = {'success': false, 'message': 'Update product failed !'});
		}
	}
}