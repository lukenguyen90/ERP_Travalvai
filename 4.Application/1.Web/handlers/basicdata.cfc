/**
*
* @file  /E/projects/source/handlers/basicdata.cfc
* @author
* @description
*
*/

component output="false" displayname="basicdata" extends="adminHandler"  {
	property name='zoneService' 				inject='entityService:Zone';
	property name='currencyService' 			inject="entityService:Currency";
	property name='languagesService' 			inject="entityService:Languages";
	property name='type_of_customersService' 	inject='entityService:Type_of_customers';
	property name='price_list_zoneService' 		inject='entityService:Price_list_zone';
	property name='price_list_factoryService' 	inject='entityService:Price_list_factory';
	property name='agentService' 				inject='entityService:Agent';
	property name='type_of_productsService' 	inject='entityService:type_of_products';
	property name='price_agentService'			inject='entityService:agent_price';
	property name='type_of_customersService' 	inject='entityService:Type_of_customers';
	property name='customerService' 			inject='customerService';
	property name='accessPageService' 			inject='entityService:access_page';
	property name='freightService' 				inject='entityService:freight';
	property name='currency_convertService'     inject='entityService:currency_convert';
	property name='factoryService'              inject='entityService:Factory';
	property name='contactService'              inject="entityService:contact";
	property name='userService' 				inject="userService";
	property name='rightService' 				inject="rightService";
	property name='shipmenttypeService' 		inject='entityService:shipment_type';
	property name='incotermService'				inject='entityService:incoterm';
	property name='type_of_boxService'			inject='entityService:type_of_box';

	public function init(){
		return this;
	}

	function getcurrencyconvert(event,prc,rc)
	{
		var converts = [];
		var convertList = EntityLoad('currency_convert');
		for(item in convertList) {
		   var convert        = {};
		   convert.id         = item.getid_curr_conv();
		   convert.code       = isNull(item.getcurrency())?JavaCast("null", ""):item.getcurrency().getcurr_code();
		   convert.currencyID = isNull(item.getcurrency())?JavaCast("null", ""):item.getcurrency().getid_currency();
		   convert.dateformat = #LSDATEFORMAT(item.getcc_date(),'dd/mm/yyyy')#;
		   convert.date       = item.getcc_date();
		   convert.val        = item.getcc_value();
		   ArrayAppend(converts,convert);
		}

		event.renderData(type="json",data=converts);
	}

	function getAccessLevel(){
		var access_levels = EntityLoad("access_level");
		var objects = [];
		for(al in access_levels) {
			var newItem = {
				"id" = al.getid_access_level(),
				"name" = al.getal_name(),
				"right"= DeserializeJson( al.getal_right() )
			}
			arrayAppend( objects, newItem );
		}
		return SerializeJson(objects);
	}

	public boolean function updateCurrencyConvert(event, prc, rc){
		try{
			var converts = [];
			var defaultConvert = "USD";
			var convertList = EntityLoad('currency_convert');
			for(item in convertList) {
			   var code=isNull(item.getcurrency())?"":item.getcurrency().getcurr_code();
			   code = ucase(code);
			   if( code != "" AND code != defaultConvert ){
					var cvtCode = '%22#trim(code)##trim(defaultConvert)#%22';
					ArrayAppend(converts,cvtCode);
			   }
			}
			var cvtCodeResult = '#arrayToList(converts)#';
			if( cvtCodeResult != ""){
				var apiUrl = 'https://query.yahooapis.com/v1/public/yql?q=select*from%20yahoo.finance.xchange%20where%20pair%20in%20(#cvtCodeResult#)&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=';
				var getCurrencyConvert = new http();
				getCurrencyConvert.setURL(apiUrl);
				result = getCurrencyConvert.send().getPrefix();
				var CRresult = deserializeJSON(result.filecontent);

				if( isStruct(CRresult.query.results.rate) ){
					var rate = [CRresult.query.results.rate];
					CRresult.query.results.rate = rate ;
				}
				for(ccvt in CRresult.query.results.rate) {

					var s = Left(ccvt.id, 3);
					var temp = EntityLoad('currency_convert', {currency:EntityLoad('currency', {curr_code:s}, true)}, true);
					var abc = ccvt.Ask*1;
					temp.setCc_value(abc);
					temp.setCc_date(ccvt.Date);
					currency_convertService.save(temp);
				}
			}
		}catch(any e){
			return false;
		}
		return true ;
	}

	function getproductstatus(event,prc,rc)
	{
		var statuses = [];
		var statusList = EntityLoad('product_status');
		for(item in statusList) {
		   var status = {};
		   status.id=item.getid_pr_status();
		   status.des = item.getpr_stat_desc();
		   ArrayAppend(statuses,status);
		}
		event.renderData(type="json",data=statuses);
	}


	function getZoneRight(event, prc, rc){
		var zoneRight = rightService.getZoneRight();
		var right = 0;
		if( SESSION.level <= zoneRight.objectLevel){
			right = 1;
		}
		event.renderData(type="json",data=right);
	}


	public any function getLabels(event, rc, prc) {
		var keywords = rc.keys;
		var Mlanguages = {}; 
		for(key in keywords){
			if(structKeyExists(rc,"locale")){
				Mlanguages[key] = getResource(key,"**NOT FOUND**",rc.locale);
			}else{
				Mlanguages[key] = getResource(key);
			}
		}
		event.renderData(type="json",data=Mlanguages);
	}
	
	

	function getzone(event,prc,rc)
	{
		var zoneRight = rightService.getZoneRight();
		var data = userService.getZoneData();
		var zones = [];
		var zoneList ={};
		var userData = userService.getLoggedInUser();
		// writedump(rc);
		// abort;
		if(structKeyExists(rc, "idfac")){
			var zoneList = EntityLoad('zone', {factory:EntityLoadByPK("factory", rc.idfac)});
		}
		else if(userData.getIs_root() == 1){
			var zoneList = EntityLoad('zone');
		}
		else{
			if(zoneRight.rightType == 1){
				zoneList = data;
			}
			else{
				zoneList ={};
			}
		}
		for(item in zoneList) {
		   var zone = {};		   
		   var code_des    = item.getz_code() & ' - ' & item.getz_description();
		   zone.id         = item.getid_Zone();
		   zone.code       = item.getz_code();
		   zone.des        = item.getz_description();
		   zone.code_des   = len(code_des) gt 37 ? left(code_des,37)&'...' : code_des;
		   zone.factory    = isNull(item.getfactory())?"":item.getfactory().getfty_description();
		   zone.factoryId  = isNull(item.getfactory())?"":item.getfactory().getid_Factory();
		   zone.currency   = isNull(item.getcurrency())?"":item.getcurrency().getcurr_description();
		   zone.currencyId = isNull(item.getcurrency())?"":item.getcurrency().getid_currency();
		   zone.language   = isNull(item.getlanguage())?"":item.getlanguage().getlg_name();
		   zone.languageId = isNull(item.getlanguage())?"":item.getlanguage().getid_language();
		   zone.contact    = isNull(item.getContact())?"":item.getContact().getcn_name();
		   zone.contactId  = isNull(item.getContact())?"":item.getContact().getid_contact();
		   ArrayAppend(zones,zone);
		}

		event.renderData(type="json",data=zones);
	}

	function getzone_price (event,prc,rc)
	{
		var zoneps = [];
		var zonepList = EntityLoad('zone_price');
		for(item in zonepList) {
		   var zonep = {};
		   zonep.id          = item.getid_zone_pl();
		   zonep.zone        = isNull(item.getZone())?"":item.getZone().getz_code();
		   zonep.zoneid      = isNull(item.getZone())?"":item.getZone().getid_Zone();
		   zonep.fdate       = dateformat(item.getzpl_date_i(), "dd/mm/yyyy");
		   zonep.todate      = dateformat(item.getzpl_date_f(), "dd/mm/yyyy");
		   zonep.priceList   = isNull(item.getprice_list_factory())?"":item.getprice_list_factory().getplf_code();
		   zonep.priceListid = isNull(item.getprice_list_factory())?"":item.getprice_list_factory().getid_plf();
		   ArrayAppend(zoneps,zonep);
		}

		event.renderData(type="json",data=zoneps);
	}

	function getlanguage(event,prc,rc)
	{
		var listLang = entityload("languages");
		var newList = [];
		for(item in listLang){
			var newl = {
				'id_language' = item.getId_language(),
				'lg_code' = item.getLg_code(),
				'lg_name' = item.getLg_name()
			};

			arrayAppend(newList,newl);
		}
		event.renderData(type="json",data=newList);
	}

	function getStructlanguage(event,prc,rc)
	{
		var listLang = entityload("languages");
		var newList = {};
		for(item in listLang){
			var newl = {
				'id_language' = item.getId_language(),
				'lg_code' = item.getLg_code(),
				'lg_name' = item.getLg_name()
			};

			newList[item.getId_language()]=newl;
		}
		event.renderData(type="json",data=newList);
	}

	function getcurrency(event,prc,rc)
	{
		var listCurrency = currencyService.list(asQuery=false);
		event.renderData(type="json",data=listCurrency);
	}

	function getPLZ(event,prc,rc)
	{
		var usertype = userService.getUserLevel();
		var listPLZ=[];

		if(usertype == 1){
			listPLZ = entityload("price_list_zone");
		}else if(usertype == 2){
			userzone = userService.getLoggedInUser().getZone();
			var plf_ls = entityload("price_list_factory",{zone=userzone});

			for(item in plf_ls){
				var templist = EntityLoad('price_list_zone',{price_list_factory=item});
				arrayAppend(listPLZ,templist,true);
			}
		}

			lsplz = [];
			for(item in listPLZ){
				var plz = {
					"id_plz"          = item.getid_plz(),
					"plz_code"        = item.getplz_code(),
					"plz_description" = item.getplz_description(),
					"plz_season"      = item.getplz_season(),
					"plz_ex_Rate"     = item.getplz_ex_Rate(),
					"plz_correction"  = item.getplz_correction(),
					"plz_commission"  = item.getplz_commission(),
					"plz_freight"     = item.getplz_freight(),
					"plz_taxes"       = item.getplz_taxes(),
					"plz_margin"      = item.getplz_margin(),
					"plz_date"        = item.getplz_date(),
					"plz_update"      = item.getplz_update()
				};
				ArrayAppend(lsplz,plz);
			}
			event.renderData(type="json",data=lsplz);
	}


	function gettype_customer(event,prc,rc)
	{
		var listTCustomer = type_of_customersService.list(asQuery = false);
		lsTC = [];
		for(item in listTCustomer){
			var tc = {
				"id_type_Customer" = item.getId_type_Customer()
				, "tc_code"        = item.getTc_code()
				, "tc_description" = item.getTc_description()
				, "created"        = item.getCreated()
				, "updated"        = item.getUpdated()
			};

			arrayAppend(lsTC,tc);
		}
		event.renderData(type="json",data=lsTC);
	}

	function getFreight(event,prc,rc)
	{
		var listFreight = freightService.list(asQuery = false);
		freightList = [];
		for(item in listFreight){
			var f = {
				  "created"        = item.getCreated()
				, "fr_description" = item.getFr_description()
				, "id_freight"     = item.getId_freight()
				, "updated"        = item.getUpdated()
			};

			arrayAppend(freightList,f);
		}

		event.renderData(type="json",data=freightList);
	}

	function getShipment(event,prc,rc)
	{
		var listShipment = shipmenttypeService.list(asQuery = false);
		shipmentList = [];
		for(item in listShipment){
			var s = {
					"id_shipment_type" = item.getid_shipment_type(),
					"st_code"		   = item.getst_code(),
					"st_description"   = item.getst_description()
			};
			arrayAppend(shipmentList,s);
		}
		event.renderData(type="json",data=shipmentList);
	}

	function getIncoterm(event,prc,rc)
	{
		var listIncoterm = incotermService.list(asQuery = false);
		incotermList = [];
		for(item in listIncoterm){
			var i = {
					"id_incoterm" 	   = item.getid_incoterm(),
					"ict_code"		   = item.getict_code(),
					"ict_description"  = item.getict_description()
			};
			arrayAppend(incotermList,i);
		}
		event.renderData(type="json",data=incotermList);
	}

	function gettype_of_box(event,prc,rc)
	{
		var listType_of_box = type_of_boxService.list(asQuery = false);
		type_of_boxList = [];
		for(item in listType_of_box){
			var t = {
					"id_type_box" 	   = item.getid_type_box(),
					"tb_description"   = item.gettb_description(),
					"tb_depth"  	   = item.gettb_depth(),
					"tb_length"		   = item.gettb_length(),
					"tb_width"		   = item.gettb_width()
			};
			arrayAppend(type_of_boxList,t);
		}
		event.renderData(type="json",data=type_of_boxList);

	}

	function getpagent (event,prc,rc)
	{
		var usertype = userService.getUserLevel();
		var pagentList = [];

		if(usertype==1){
			pagentList = EntityLoad('agent_price');
		}else if(usertype=2){
			userzone = userService.getLoggedInUser().getZone();
			var ag_ls = entityload("agent",{zone=userzone});

			for(item in ag_ls){
				var templist = EntityLoad('agent_price',{agent=item});
				arrayAppend(pagentList,templist,true);
			}
		}else{
			pagentList = [];
		}

		var pagents = [];
		for(item in pagentList) {
		   var pagent = {};
		   pagent.id          = item.getid_agent_pl();
		   pagent.idagent     = isNull(item.getagent())?"":item.getagent().getid_agent();
		   pagent.code        = isNull(item.getagent())?"":item.getagent().getag_code();
		   pagent.des         = isNull(item.getagent())?"":item.getagent().getag_description();
		   pagent.fdate       = dateformat(item.getapl_date_i(), "dd/mm/yyyy");
		   pagent.todate      = dateformat(item.getapl_date_f(), "dd/mm/yyyy");
		   pagent.priceList   = isNull(item.getprice_list_zone())?"":item.getprice_list_zone().getplz_code();
		   pagent.priceListid = isNull(item.getprice_list_zone())?"":item.getprice_list_zone().getid_plz();
		   ArrayAppend(pagents,pagent);
		}

		event.renderData(type="json",data=pagents);
	}

	function getAgentRight(event, prc, rc){
		var agentRight = rightService.getAgentRight();
		var right = 0;
		if( SESSION.level <= agentRight.objectLevel){
			right = 1;
		}
		event.renderData(type="json",data=right);
	}

	function getagent (event,prc,rc)
	{
		var agentRight = rightService.getAgentRight();
		var data = userService.getAgentData();
		var agents = [];
		var agentList ={};
		var userData = userService.getLoggedInUser();
		if(structKeyExists(rc, "idzone")){
			var agentList = EntityLoad('agent',{zone:EntityLoadByPK("zone",rc.idzone)});
		}
		else if(userData.getIs_root() == 1){
			var agentList = EntityLoad('agent');
		}
		else{
			if(agentRight.rightType == 1){
				agentList = data;
			}
			else{
				agentList ={};
			}
		}
		for(item in agentList) {
		   var agent = {};
		   var code_des = item.getag_code() & ' - ' & item.getag_description();
		   agent.id          = item.getid_Agent();
		   agent.code        = item.getag_code();
		   agent.code_des 	 = len(code_des) gt 37 ? left(code_des,37)&'...' : code_des;
		   agent.des         = item.getag_description();
		   agent.commission  = item.getag_commission();
		   agent.zone        = isNull(item.getZone())?"":item.getZone().getz_description();
		   agent.zoneid      = isNull(item.getZone())?"":item.getZone().getid_Zone();
		   agent.language    = isNull(item.getlanguage())?"":item.getlanguage().getlg_name();
		   agent.languageid  = isNull(item.getlanguage())?"":item.getlanguage().getid_language();
		   // agent.priceList   = isNull(item.getPrice_list_zone())?"":item.getPrice_list_zone().getplz_code();
		   // agent.priceListid = isNull(item.getPrice_list_zone())?"":item.getPrice_list_zone().getid_plz();
		   agent.contact     = isNull(item.getContact())?"":item.getContact().getcn_name();
		   agent.contactid   = isNull(item.getContact())?"":item.getContact().getid_contact();
		   ArrayAppend(agents,agent);
		}

		event.renderData(type="json",data=agents);
	}

	function getFactoryRight(event, prc, rc){
		var factoryRight = rightService.getFactoryRight();
		var right = 0;
		if( SESSION.level <= factoryRight.objectLevel){
			right = 1;
		}
		event.renderData(type="json",data=right);
	}

	function getfactory(event, prc, rc)
	{
		var factoryRight = rightService.getFactoryRight();
		var data = userService.getFactoryData();
		var factories = [];
		var factoryList ={};
		var userData = userService.getLoggedInUser();
		if(userData.getIs_root() == 1){
			var factoryList = EntityLoad('factory');
		}
		else{
			if(factoryRight.rightType == 1){
				factoryList = data;
			}
			else{
				factoryList ={};
			}
		}

		for(item in factoryList){
			var factory         = {};
			factory.id          = item.getid_Factory();
			factory.code        = item.getfty_code();
			factory.description = item.getfty_description();
			factory.currency    = isNull(item.getcurrency())?"":item.getcurrency().getcurr_description();
			factory.language   	= isNull(item.getlanguages())?"":item.getlanguages().getlg_name();
			factory.contact     = isNull(item.getContact())?"":item.getContact().getcn_name();
			factory.currencyid  = isNull(item.getcurrency())?"":item.getcurrency().getid_currency();
			factory.languageid  = isNull(item.getlanguages())?"":item.getlanguages().getid_language();
			factory.contactid   = isNull(item.getContact())?"":item.getContact().getid_contact();
			factory.contact     = isNull(item.getContact())?"":item.getContact().getcn_name();
			ArrayAppend(factories,factory);
		}

		event.renderData(type="json",data=factories);
	}

	function getCustomerRight(event, prc, rc){
		var customerRight = rightService.getCustomerRight();
		var right = 0;
		if(SESSION.level <= customerRight.objectLevel){
			right = 1;
		}
		event.renderData(type="json",data=right);
	}


	function getcustomer(event,prc,rc)
	{
		var customers = [];
		var data = userService.getCustomerData();
		var customerList ={};
		var userData = userService.getLoggedInUser();
		if(structKeyExists(rc, "idagent")){
			var customerList = QueryExcecute("	SELECT *
												FROM customer
													INNER JOIN agent
														ON customer.id_agent = agent.id_agent
													INNER JOIN zone
														ON customer.id_zone  = zone.id_zone
													INNER JOIN type_of_customers tc
														ON customer.id_type_customer = tc.id_type_customer
													INNER JOIN languages
														ON languages.id_language = customer.id_language
													INNER JOIN contact
														ON contact.id_contact = customer.id_contact
												WHERE customer.id_agent = #rc.idagent#
											")
		}else if(userData.getIs_root() == 1){
			var customerList = EntityLoad('customer');
		}
		else{
			customerList = data;
		}
		for(item in customerList)
		{
			var customer = {};
			var customer_name = item.getcs_name();
			var id_name = item.getid_Customer() & ' - ' & item.getcs_name();
			customer.id = item.getid_Customer();
			customer.name = customer_name;
			customer.id_name = len(id_name) gt 37 ? left(id_name,37)&'...' : id_name;
			customer.agent = isNull(item.getAgent())?"":item.getAgent().getag_code();
			customer.agentid = isNull(item.getAgent())?"":item.getAgent().getid_Agent();
			customer.agent_des = isNull(item.getAgent())?"":(item.getAgent().getag_description() != "" ? (" - " & item.getAgent().getag_description() ): "");
			var objZone = isNull(item.getAgent())?"": item.getAgent().getZone();
			var zonename = !IsObject(objZone) ? "" : objZone.getz_code();
			var zoneid = !IsObject(objZone) ? "" : objZone.getid_Zone();
			customer.zone = zonename;
			customer.zoneid = zoneid;
			customer.language = isNull(item.getlanguage())?"":item.getlanguage().getlg_name();
			customer.languageid = isNull(item.getlanguage())?"":item.getlanguage().getid_language();
			customer.tc_description = isNull(item.gettype_of_customer())?"":item.gettype_of_customer().gettc_description();
			customer.tocid = isNull(item.gettype_of_customer())?"":item.gettype_of_customer().getid_type_Customer();
		   	customer.contactID = isNull(item.getContact())?"":item.getContact().getid_contact();
			customer.contact = isNull(item.getContact())?"":item.getContact().getcn_name();
			 ArrayAppend(customers,customer);
		}
		event.renderData(type="json",data=customers);
	}

	function getCustomerList(){
		var data = deserializeJSON(GetHttpRequestData().content);
		var rs = {};
		rs = customerService.getCustomerList(rc.start, val(rc.length), rc.columns, rc.order, rc.draw, rc.search);
		event.renderData(type = "json", data = rs);
	}

	function getAccessPage(event,prc,rc)
	{
		var listAPage = accessPageService.list(asQuery = false);
		event.renderData(type="json",data=listAPage);
	}

	function checkExistCode(event,rc,prc)
	{
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id eq 0){
				var result = QueryExecute("select count(*) as count from #rc.table# WHERE #rc.nameCol#=:code",{code=rc.code});
				event.renderData(type="json",data={ 'isExist' : !(result.count == 0) });
			}else{
				var result = QueryExecute("select count(*) as count from #rc.table# WHERE #rc.nameCol#=:code and #rc.idfield#!=:id",{code=rc.code,id:rc.id});
				event.renderData(type="json",data={ 'isExist' : !(result.count == 0) });
			}
		}
	}

	function getUserLevel(event, rc, pc){
		var user_type = userService.getUserLevel();
		var result={
			typeUser = "",
			idLog= SESSION.loggedInUserID
		};

		if(user_type >=0 and user_type<=4)
		{
			result.typeUser = user_type;
		}
		else{
			result.typeUser ="";
		}

		event.renderData(type="json",data=result);
	}
}