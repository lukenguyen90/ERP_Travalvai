component extends="cborm.models.VirtualEntityService" singleton{
	property name ='userService' 			inject='userService';
	property name = 'numberService' 		inject='numberHelper';
	property name='patternsVarService'     	inject='pattern_variantionsService';
	/**
	* Constructor
	*/
	function init(){

		// init super class
		super.init( entityName="product" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.product" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}
	public function CostCodeCondition(){
		var result = "CUS%";
		return result;
	}
	public function getplz_id(numeric agentID){
		var result ="";
		var usertype = userService.getUserLevel();
		//if (usertype != 4){
			var qPlz = QueryExecute("
				select *
				from price_list_zone
				where id_plz in(
					select id_plz
					from agent_price
					where id_agent = #agentID# and date(now()) between apl_date_i and apl_date_f
					group by id_plz)
				");
			result = qPlz;
		//}
		return result;
	}

	public function checkPlzExpire(numeric id_plz){
		var result = false;
		var check =  QueryExecute("
				select id_plz
					from agent_price
					where id_plz = #id_plz# and date(now()) between apl_date_i and apl_date_f
				");
		if(!check.recordCount){
			result = true;
		}
		return result;
	}

	public any function getProjectByCustomer(numeric id_customer) {
		var aProject = [];
		var check = QueryExecute("
			select *
			from project
			where project.id_customer = #id_customer#
			");
		if(check.recordCount){
			 var aProject = queryToArray(check);
		}		
		return  aProject;
	}
	


	public function getProject(numeric id_zone, numeric id_agent){
		var result = [];
		var check = QueryExecute("
			select *
			from project
			where project.id_customer in
				(	select id_customer
					from customer
					where id_agent in (#id_agent#) and id_zone = #id_zone#
					group by id_customer
				)
			");
		if(check.recordCount){
			result = queryToArray(check);
		}
		return result;
	}

	public function getcode_cost(plzid){
		var usertype = userService.getUserLevel();
		var result   = "";
		if(usertype != 4){
			var idUserLang = userService.getLoggedInUser().getlanguage().getid_language();
			var aCosting = [];
			var aPlzd 	 = [];
			var q_plfd = QueryExecute("
				select id_cost, id_cost_version
				from price_list_factory_detail
				where id_plf_det in
					(select id_plf_det
					from price_list_zone_details
					where id_plz = #plzid#)
			");
			if(q_plfd.recordCount){
				for(item2 in q_plfd){
					var t = structNew();
					t.id_cost = item2.id_cost;
					t.id_cost_version = item2.id_cost_version;
					arrayAppend(aPlzd, t);
					if( arrayFind(aCosting,t.id_cost) == 0){
						arrayAppend(aCosting,t.id_cost);
					}
				}
			}
			var lCostID = arrayLen(aCosting)? ArrayToList(aCosting, ",") : 0;
			result = QueryExecute("
				select cost.*,cd.cd_description,cd.id_language
				from costing cost
					left join costing_description  cd on cost.id_cost = cd.id_cost and cd.id_language = #idUserLang#
				where cost.id_cost in (#lCostID#) and cost.cost_code not like '#CostCodeCondition()#'
			");
		}
		return result;
	}

	public function getproducttype(numeric idcost){
		var idTypePr = QueryExecute("
				select costing.id_type_products
				from costing
				where id_cost = #idcost#
		");
		var result = QueryExecute("
			select *
			from type_of_products
			where id_type_products = #idTypePr.id_type_products#
		");
		return result;
	}

	public function getContract(numeric idcustomer){
		var result = QueryExecute("
			select id_contract,c_description, DATE_FORMAT(c_date_i,'%d-%m-%Y') as c_date_i, c_no_of_years, c_increase_year, id_Customer, id_agent, id_zone
			from contract
			where id_customer = #idcustomer#
			");
		return queryToArray(result);
	}

	public function getPrdTypeByDes(numeric id_type_products){
		var IdLangDefault = userService.get(SESSION.loggedInUserID).getlanguage().getid_language();
		var result = QueryExecute("
			select *
			from type_product_language tpl
				inner join type_of_products tpd
					on tpd.id_type_products = tpl.id_type
			where id_language = #IdLangDefault# and id_type = #id_type_products#
			");
		return result;
	}


	public function getcost_version(numeric id_cost){
		var IdLangDefault = userService.get(SESSION.loggedInUserID).getlanguage().getid_language();
		var checkDesExist = QueryExecute("
			select *
			From costing_version_description
			where id_cost_version in(
				select ct.id_cost_version
				from costing_versions ct
				where ct.id_cost = #id_cost#
				order by ct.id_cost_version )
			");
		if(!checkDesExist.recordCount){
			var result = QueryExecute("
			select ct.id_cost_version, ct.cv_version cvd_description,ct.cv_version  cv_version
			from costing_versions ct
			where ct.id_cost = #id_cost#
			order by ct.id_cost_version
			");
		}else{
			var result = QueryExecute("
			select ct.id_cost_version, ct.cv_version, cvd.cvd_description
			from costing_versions ct
				inner join costing_version_description cvd
					on cvd.id_cost_version = ct.id_cost_version
			where ct.id_cost = #id_cost# and cvd.id_language = #IdLangDefault#
			order by ct.id_cost_version
			");
			if(!result.recordCount){
				result = QueryExecute("
				select ct.id_cost_version, ct.cv_version, cvd.cvd_description
				from costing_versions ct
					inner join costing_version_description cvd
						on cvd.id_cost_version = ct.id_cost_version
				where ct.id_cost = #id_cost# and cvd.id_language = 1
				order by ct.id_cost_version
				");
			}
		}
		return result;
	}


	public any function getProduct(numeric id) {
		var userLevel = userService.getUserLevel();
		var numberformat = 2;
		var plzid = "";
		var cvList=[];
		var pattern_vars=[];
		var product = EntityLoadByPK("product",LSParseNumber(id));
		var project = isNull(product)?JavaCast("null", ""):product.getProject();
		var customer = isNull(project)?JavaCast("null", ""):project.getCustomer();
		var agent = isNull(customer)?JavaCast("null", ""):customer.getAgent();
		var zone = isNull(agent)?JavaCast("null", ""):agent.getZone();
		var plzd = isNull(product)?JavaCast("null", ""):product.getPrice_list_zone_detail();
		//get project
		var aProject = getProject(zone.getid_zone(), agent.getid_agent());
		var lstPj 	 = [];
		var lstPlz_dets = [];
		var aContract   = [];
		var id_contract = isNull(product.getcontract())?0:product.getcontract().getid_contract();
		var contract 	= getContract(customer.getid_customer());
		if(arrayLen(contract) gt 0){
			aContract = contract;
		}
		
		if(!isnull(aProject)) {
			for(item in aProject) {
				var str = {};
				var pj_description = item.id_display &" - "& item.pj_description;
				str["id_Project"] = item.id_Project;
				str["pj_description"] = pj_description;
				arrayAppend(lstPj, str);
			}
		}
		//get price list
		var qPlz = getplz_id(agent.getid_agent());
		var price_list_zone = EntityLoadByPK("price_list_zone", qPlz.id_plz);
		var plz_currency = price_list_zone.getcurrency().getcurr_code();
		var plf_currency = price_list_zone.getprice_list_factory().getcurrency().getcurr_code();
		if(!isNull(qPlz)) {
			for(item in qPlz) {
				var str = {};
				str["id_plz"] = item.id_plz;
				str["des"] = item.plz_code&"_"&item.plz_description;
				arrayAppend(lstPlz_dets, str);
			}
		}
		//-----
		if(userLevel != 4){
			var fty_sell_4 		 = isNull(plzd)?"":plzd.getPlzd_Fty_Sell_4();
			var plzd_zone_sell_6 = isNull(plzd)?"":plzd.getPlzd_zone_sell_6();
			var plzd_pvpr_8 	 = isNull(plzd)?"":plzd.getPlzd_pvpr_8();
			var plz = QueryExecute("select id_plz
						from price_list_zone
						where id_plz in (
							select id_plz from price_list_zone_details where id_plz_det = #product.getPrice_list_zone_detail().getid_plz_det()#)");
			plzid = plz.id_plz;
		}
		if(not isNull(product.getCosting())){
			var cvs = getcost_version(product.getCosting().getId_Cost());
			if(cvs.recordCount) {
				for(item in cvs) {
					var newcv = {};
					newcv["id_cost_version"] = item.id_cost_version;
					newcv["cv_version"] = item.cvd_description;
					arrayAppend(cvList, newcv);
				}
			}
		}

		if(not isNull(product.getPattern())){
			var patternsVar = patternsVarService.getPatternVariForAddProduct(product.getPattern().getid_pattern());
			if(arrayLen(patternsVar)) {
				for(item in patternsVar) {
					var des = item.pv_code & (item.pv_description != "" ? " - " : "") & item.pv_description;
					var pv_code = len(des) gt 25 ? left(des,25)&'...' : des;
					var str = {};
					str["id_pattern_var"] = item.id_pattern_var;
					str["pv_code"] = pv_code;
					arrayAppend(pattern_vars, str);
				}
			}
		}

		prd = {
			"id_product"       = product.getId_product(),
			"pr_comment"       = product.getpr_comment(),
			"pr_commission"    = product.getpr_commission(),
			"pr_version"       = val(product.getPr_version()),
			"pr_description"   = product.getPr_description(),
			"pr_section"       = product.getPr_section(),
			"pr_fty_sell_9"    = isNull(product.getPr_fty_sell_9())? 0 :val(product.getPr_fty_sell_9()),
			"pr_zone_sell_10"  = isNull(product.getPr_zone_sell_10())? 0 :val(product.getPr_zone_sell_10()),
			"pr_pvpr_11"       = isNull(product.getPr_PVPR_11()) ? 0 : val(product.getPr_PVPR_11()),
			"pr_club_12"       = isNull(product.getPr_Club_12())?0:val(product.getPr_Club_12()),
			"pr_web_13"        = isNull(product.getPr_Web_13())?0:val(product.getPr_Web_13()),
			"pr_date"          = dateformat(product.getPr_date(), "dd/mm/yyyy"),
			"pr_date_update"   = !isNull(product.getPr_date_update())?dateformat(product.getPr_date_update(), "dd/mm/yyyy"):dateformat(now(), "dd/mm/yyyy"),
			"pr_web"           = val(product.getPr_web()),
			// "pr_9_valid"       = product.getPr_9_valid(),
			// "pr_10_valid"      = product.getPr_10_valid(),
			// "pr_11_valid"      = product.getPr_11_valid(),
			"pr_sketch"        = product.getPr_sketch(),
			"pr_picture"       = product.getPr_picture(),
			"pr_stock"         = product.getPr_stock(),
			"plzd_zone_sell_6" = numberService.roundDecimalPlaces(plzd_zone_sell_6,numberformat),
			"fty_sell_4"       = numberService.roundDecimalPlaces(fty_sell_4,numberformat),
			"plzd_pvpr_8"      = numberService.roundDecimalPlaces(plzd_pvpr_8,numberformat),
			"z_description"    = isNull(zone)?"":zone.getZ_description(),
			"ag_description"   = isNull(agent)?"":agent.getAg_description(),
			"cs_name"          = isNull(customer)?"":customer.getid_Customer()&' - '&customer.getCs_name(),
			"factory"          = isNull(product.getFactory())?"":product.getFactory().getId_Factory(),
			"aProject"         = lstPj,
			"aPriceList"       = lstPlz_dets,
			"project"          = isNull(product.getProject())?"":product.getProject().getId_Project(),
			"pattern_var"      = isNull(product.getPattern_variantion())?"":product.getPattern_variantion().getId_pattern_var(),
			"pv_variation"	   = isNull(product.getPattern_variantion())?"":product.getPattern_variantion().getPv_code(),
			"sz"         	   = isNull(product.getSize())?"":product.getSize().getId_size(),
			"size_des"         = isNull(product.getSize())?"":product.getSize().getSz_description(),
			"product_status"   = isNull(product.getProduct_status())?"":product.getProduct_status().getId_pr_status(),
			"cost"             = isNull(product.getCosting())?"":product.getCosting().getId_Cost(),
			"cost_version"     = isNull(product.getCosting_versions())?"":product.getCosting_versions().getId_cost_version(),
			"pattern"          = isNull(product.getPattern())?"":product.getPattern().getId_Pattern(),
			"cvList" 		   = cvList,
			"pattern_vars"	   = pattern_vars,
			"id_plz"		   = plzid,
			"contract"		   = aContract,
			"id_contract"	   = id_contract,
			"plFactoryCus"	   = 0,
			"plZoneCus"   	   = 0,
			"plFinalCus"	   = 0,
			"plz_currency"	   = plz_currency,
			"plf_currency"	   = plf_currency
		};
		return prd;
	}


	public function getListProduct(projectID){
		var usertype = userService.getUserLevel();
		var productList = entityLoad('product', {project: EntityLoadByPK('project', projectID)});
		var products = [];
		if(usertype == 1 or usertype == 0){
			if(arraylen(productList)){
				for(product in productList){
					var product = getProductDetail(product);
					ArrayAppend(products,product);
				}
				return products;
			}else{
				return products;
			}
		}else if(usertype == 2){
			if(arraylen(productList)){
				for(product in productList){
					var zoneID 	 = userService.getZoneID();
					var project  = isNull(product)?JavaCast("null", ""):product.getProject();
					var customer = isNull(project)?JavaCast("null", ""):project.getCustomer();
					var agent    = isNull(customer)?JavaCast("null", ""):customer.getAgent();
					var zone     = isNull(agent)?JavaCast("null", ""):agent.getZone();
					if(zone.getid_zone() == zoneID){
						var products = [];
						for(product in productList){
							var product = getProductDetail(product);
							ArrayAppend(products,product);
						}
						return products;
					}else{
						return products;
					}
				}
			}else{
				return products;
			}
		}else if(usertype == 3){
			if(arraylen(productList)){
				for(product in productList){
					var zoneID   = userService.getZoneID();
					var agentID  = userService.getAgentID();
					var project  = isNull(product)?JavaCast("null", ""):product.getProject();
					var customer = isNull(project)?JavaCast("null", ""):project.getCustomer();
					var agent    = isNull(customer)?JavaCast("null", ""):customer.getAgent();
					var zone     = isNull(agent)?JavaCast("null", ""):agent.getZone();
					if(zone.getid_zone() == zoneID and agent.getid_agent() == agentID){
						var products = [];
						for(product in productList){
							var product = getProductDetail(product);
							ArrayAppend(products,product);
						}
						return products;
					}else{
						return products;
					}
				}
			}else{
				return products;
			}
		}else if(usertype == 4) {
			
			if(arraylen(productList)){
				for(product in productList){
					var zoneID   = userService.getZoneID();
					var agentID  = userService.getAgentID();
					var customerID  = userService.getCustomerID();
					var project  = isNull(product)?JavaCast("null", ""):product.getProject();
					var customer = isNull(project)?JavaCast("null", ""):project.getCustomer();
					var agent    = isNull(customer)?JavaCast("null", ""):customer.getAgent();
					var zone     = isNull(agent)?JavaCast("null", ""):agent.getZone();
					if(zone.getid_zone() == zoneID and agent.getid_agent() == agentID and customer.getid_Customer() == customerID){
						var products = [];
						for(product in productList){
							var product = getProductDetail(product);
							ArrayAppend(products,product);
						}
						return products;
					}else{
						return products;
					}
				}
			}else{
				return products;
			}
		}
		
	}
	
	function getProductDetail(component productItem){
		var numberFormat = 2;
		var productCust  = EntityLoad("prod_cust",{product = productItem});
		var factoryPriceCus    = 0;
		var agentPriceCus 	   = 0;
		var finalPriceCus 	   = 0;
		var sizes              = productItem.getSize();
		var listSizeDetail 	   = [];
		var sizesDetail = QueryExecute("
				SELECT sd.id_size_det, s.id_size, sd.szd_position, sd.szd_size
				FROM sizes_details sd
				INNER JOIN sizes s
					ON s.id_size = sd.id_size
				WHERE s.id_size = #sizes.getid_size()#
				ORDER BY sd.szd_position ASC
			");
		for(item in sizesDetail){
			var str = {};
			str["id_size_det"] 	= item.id_size_det;
			str["id_size"] 		= item.id_size;
			str["szd_position"] = item.szd_position;
			str["szd_size"] 	= item.szd_size;
			str["quantity"] 	= "";
			str["number"] 		= "";
			str["name"] 		= "";
			arrayAppend(listSizeDetail, str)
		}
		var factoryPriceManual    = isNull(productItem.getPr_fty_sell_9()) ? 0 : numberService.roundDecimalPlaces(productItem.getPr_fty_sell_9(),numberFormat);
		var agentPriceManual      = isNull(productItem.getPr_zone_sell_10()) ? 0 : numberService.roundDecimalPlaces(productItem.getPr_zone_sell_10(),numberFormat);
		var finalPriceManual      = isnull(productItem.getPr_PVPR_11()) ? 0 : numberService.roundDecimalPlaces(productItem.getPr_PVPR_11(),numberFormat);
		var product               = {};
		var contractID 		      = !isNull(productItem.getContract())?productItem.getContract().getid_contract():0;
		var contract 			  = EntityLoadByPK("contract", contractID);
		//contract and set status color
		var contractDate = "None";
		var contractStatusColor = "";
		if(!isNull(contract)){
			contractDate 	= dateFormat(contract.getc_date_i(), 'dd/mm/yyyy');
			var startDate	= contract.getc_date_i();
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
		var project               = productItem.getProject();
		product["idProduct"]      = productItem.getId_product();
		product["contractDate"]   = contractDate;
		product["contractStatusColor"] = contractStatusColor;		
		product["sizesDetail"]    = listSizeDetail;		
		product["group"]          = "";		
		product["garmentCode"]    = project.getId_display()&"-"&(isNull(productItem.getPattern())?"":productItem.getPattern().getpt_code())&"-"&(isNull(productItem.getPattern_variantion())?"":productItem.getPattern_variantion().getpv_code());
		product["version"]        = productItem.getPr_version();
		product["cost_code"]      = isNull(productItem.getCosting())?"":productItem.getCosting().getCost_code();
		product["cost_code_vers"] = isNull(productItem.getCosting_versions())?"":productItem.getCosting_versions().getcv_version();
		product["description"]    = productItem.getPr_description();
		product["customer"]       = isNull(project.getCustomer())?"":project.getCustomer().getCs_name();
		var agent 			   	  = isNull(project.getCustomer())?javaCast("null", ""):project.getCustomer().getAgent();
		product["agent"]          = isNull(agent)?"":agent.getAg_description();
		var zone 			   	  = isNull(agent)?javaCast("null", ""):agent.getZone();
		product["zone"]           = isNull(zone)?"":zone.getz_description();
		product["section"]        = productItem.getPr_section();
		product["status"]         = isNull(productItem.getProduct_status())?"":productItem.getProduct_status().getPr_stat_desc();
		product["sketch"]         = isNull(productItem.getPr_sketch())?"":productItem.getPr_sketch();
		product["picture"]        = isNull(productItem.getpr_picture())?"":productItem.getpr_picture();
		var plz_det 		      = productItem.getprice_list_zone_detail();
		var plz_id 			   	  = plz_det.getprice_list_zone().getid_plz();
		var isPlzExpire 	   	  = checkPlzExpire(plz_id);
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
		//final price
		var finalPriceFactory 	= calFinalPrice(plz_det.getPlzd_Fty_Sell_4(), factoryPriceManual, factoryPriceCus, contractID);
		var finalPriceAgent 	= calFinalPrice(plz_det.getPlzd_zone_sell_6(), agentPriceManual, agentPriceCus, contractID);
		var finalPriceFinal 	= calFinalPrice(plz_det.getPlzd_pvpr_8(), finalPriceManual, finalPriceCus, contractID);
		//contract price
		var priceContractFactory = calPriceContract(factoryPriceManual, contractID);		
		var priceContractAgent 	 = calPriceContract(agentPriceManual, contractID);
		var priceContractFinal   = calPriceContract(finalPriceManual, contractID);

		var structPriceDetail = {
				"hasContract" = priceContractFactory.isContract,
				"isContractExpired" = priceContractFactory.isExpire,

				"priceList" = {
				/* sell_4 */	"factory" = !isPlzExpire ? (isnull(plz_det) ? 0 : numberService.roundDecimalPlaces(plz_det.getPlzd_Fty_Sell_4(),numberFormat)) : 0,
				/* sell_6 */	"zone" 	  = !isPlzExpire ? (isnull(plz_det) ? 0 : numberService.roundDecimalPlaces(plz_det.getPlzd_zone_sell_6(),numberFormat)) : 0,
				/* pvpr_8 */	"agent"   = !isPlzExpire ? (isnull(plz_det) ? 0 : numberService.roundDecimalPlaces(plz_det.getPlzd_pvpr_8(),numberFormat)) : 0
				}
				,"manual" = {
				/* sell_9 */	"factory" 	   =  !isPlzExpire ? factoryPriceManual : 0,
				/* sell_10 */	"zone" 	       =  !isPlzExpire ? agentPriceManual : 0,
				/* pvpr_11 */	"agent" 	   =  !isPlzExpire ? finalPriceManual : 0
				}
				,"order" = {
					"factory" 	   =  !isPlzExpire ? priceContractFactory.price : 0,
					"zone" 	       =  !isPlzExpire ? priceContractAgent.price : 0,
					"agent" 	   =  !isPlzExpire ? priceContractFinal.price : 0					
				}
				,"custom" = {
				/* cst_fty */	"factory" 	   = !isPlzExpire ? factoryPriceCus : 0,
				/* cst_zone */	"zone" 	   	   = !isPlzExpire ? agentPriceCus : 0,
				/* cst_cs */	"agent" 	   = !isPlzExpire ? finalPriceCus :0
				}
				,"total" = {
				/* valid9 */	"factory" 	   = !isPlzExpire ? finalPriceFactory:0,
				/* valid10 */	"zone" 	       = !isPlzExpire ? finalPriceAgent:0,
				/* valid11 */	"agent" 	   = !isPlzExpire ? finalPriceFinal:0
				}
				, "grandTotal" = {
				/* valid9 */	"factory" 	   = 0,
				/* valid10 */	"zone" 	       = 0,
				/* valid11 */	"agent" 	   = 0
				}
		};

		var clubPrice = productItem.getPr_Club_12();
		var webPrice  = productItem.getPr_Web_13();
		product["club_12"] 	= calFinalPrice(0, clubPrice, finalPriceCus, contractID);
		product["web_13"] 	= calFinalPrice(0, webPrice,  finalPriceCus, contractID);
		product["price"] 	= structPriceDetail;
		return product;
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

	function calPriceContract(numeric manualPrice, numeric idcontract){
		var priceContract = {};
		var price = 0;
		var numberFormat = 2;
		if(idcontract == 0){
			return {'price': price, 'isContract': false, 'isExpire' : ''};
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
				return {'price': price, 'isContract': true, 'isExpire' : true};
			}
			for(var i =0; i < noOfYear; i++){
				j = i + 1;
				var start = i * daysOfYear;
				var end = j * daysOfYear;
				if( (start < currentDay) && (currentDay < end)){
					price = numberService.roundDecimalPlaces((((1 + (increase_year/100)) ^ i) * manualPrice), numberFormat);
					return {'price': price, 'isContract': true, 'isExpire' : false};
				}
			}
		}
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

}