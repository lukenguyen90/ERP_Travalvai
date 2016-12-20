component output="false" displayname=""  {
	property name='numberService' 			inject='numberHelper';
	property name='userService' 			inject='userService';
	property name='shipmentService' 		inject='shipmentService';
	property name='shipmentTypeService' 	inject='entityService:shipment_type';
	property name='forwarderService'        inject='entityService:Forwarder';
	property name='contactService' 			inject='entityService:Contact';
	property name='freightService' 			inject='entityService:freight';
	property name='incotermService'			inject='entityService:incoterm';
	property name='factoryService'          inject='entityService:Factory';
	property name='currencyService' 		inject="entityService:Currency";
	property name='languagesService' 		inject="entityService:Languages";
	property name='rightService' 			inject="rightService";
	property name='agentService' 			inject='agentService';
	property name='customerService' 		inject='customerService';
	property name='boxService' 				inject='boxService';
	property name='typeBoxService' 			inject='entityService:type_of_box';
	property name='shipment_informationService'	inject='entityService:shipment_information';

	public function init(){
		return this;
	}	

	function getBoxList(event,prc,rc){
		var rs = {};
		rs = boxService.getBoxList(rc.start, val(rc.length), rc.columns, rc.order, rc.draw, rc.search);
		event.renderData(type = "json", data = rs);
	}

	function getTypeBox(event, prc, rc){
		var typeBox = EntityLoad("type_of_box");
		var result = [];
		for(item in typeBox){
			var str = {};
			str["id_type_box"] = item.getid_type_box();
			str["tb_description"] = item.gettb_description();
			arrayAppend(result, str);
		}
		event.renderData(type = "json", data = result);

	}

	function deleteBox(){
		var id_box = deserializeJSON(GetHttpRequestData().content);
		var box = EntityLoadByPK("box", id_box);
		try {
			boxService.delete(box,true);
			event.renderData(type = "json", data = {"isDeleted" : true});
		}
		catch(any e) {
			event.renderData(type = "json", data = {"isDeleted" : false});
		}
	}
	function createBox(event, prc, rc){
		var data = deserializeJSON(GetHttpRequestData().content);
		var typeBox = EntityLoadByPK("type_of_box", data.type_box.id_type_box);
		try {
			var box = boxService.new();
			box.setbx_weight(data.bx_weight);
			box.settype_of_box(typeBox);
			
			boxService.save(box);

			var box_code = 'BX'&'-'&box.getid_box();
			box.setbx_code(box_code);

			boxService.save(box);
			event.renderData(type = "json", data = {"success" : true});
		}catch(any e) {
			event.renderData(type = "json", data = {"success" : false});
		}
	}

	function editBox(event, prc, rc){
		var data = deserializeJSON(GetHttpRequestData().content);
		var typeBox = EntityLoadByPK("type_of_box", data.type_box.id_type_box);
		try {
			var box = EntityLoadByPK("box", data.id_box);
			box.setbx_weight(data.bx_weight);
			box.settype_of_box(typeBox);			
			boxService.save(box);
			event.renderData(type = "json", data = {"isEdit" : true});
		}catch(any e) {
			event.renderData(type = "json", data = {"isEdit" : false});
		}
	}

	function createShipmentInfo(event, rc, prc){
		var data = deserializeJSON(GetHttpRequestData().content);
		var forwarder 		= EntityLoadByPK("forwarder", data.forwarder.id);
		var shipment_type 	= EntityLoadByPK("shipment_type", data.shipmentType.id_shipment_type);
		var user_created 	= userService.getLoggedInUser();
		var freight 		= EntityLoadByPK("freight", data.freight.id_freight);
		var incoterm 		= EntityLoadByPK("incoterm", data.incoterm.id_incoterm);
		try {
			// create shipment
			var shipment = shipmentService.new();
				shipment.setsh_incoterm(data.incoterm.ict_code);
				shipment.setsh_send(data.sender.code);
				shipment.setsh_send_id(data.sender.id);
				shipment.setsh_desti(data.destination.code);
				shipment.setsh_desti_id(data.destination.id);
				shipment.setsh_open_date(data.openDate != "" ? data.openDate: JavaCast("null", ""));
				shipment.setsh_estim_del_date(data.estimateDelivery != "" ? data.estimateDelivery: JavaCast("null", "") );
				shipment.setsh_delivery_date(data.delivery != "" ? data.delivery : JavaCast("null", "") );
				shipment.setsh_estim_arr_date(data.estimatedArival != "" ? data.estimatedArival : JavaCast("null", "") );
				shipment.setsh_arrival_date(data.arival != "" ? data.arival : JavaCast("null", "") );
				shipment.setsh_frg_cost(data.freightCost != "" ? val(data.freightCost) : JavaCast("null", ""));
				shipment.setsh_taxes(data.taxes != "" ? val(data.taxes) : JavaCast("null", "") );
				shipment.setsh_imp_duty(data.importDuty != "" ? val(data.importDuty) : JavaCast("null", "") );
				shipment.setagent(structKeyExists(data.agent, "id") ? EntityLoadByPK("agent", data.agent.id) : JavaCast("null", "") );
				shipment.setzone(structKeyExists(data.zone, "id") ? EntityLoadByPK("zone", data.zone.id) : JavaCast("null", ""));
				shipment.setcustomer(structKeyExists(data.customer, "id") ? EntityLoadByPK("customer", data.customer.id) : JavaCast("null", ""));
				shipment.setforwarder(forwarder);
				shipment.setshipment_type(shipment_type);
				shipment.setuser_created(user_created);
				shipment.setfreight(freight);
				shipment.setincoterm(incoterm);
			//save shipment
			shipmentService.save(shipment);		
			event.renderData(type = "json", data = {"success" : true});
		}
		catch(any e) {
			event.renderData(type = "json", data = {"success" : false});
		}
	}

	function getShipmentList(event, rc, prc){
		var data = deserializeJSON(GetHttpRequestData().content);
		if(!StructIsEmpty(data)){
			var rs = {};
			rs = shipmentService.getShipmentList(data);
		}else{
			var rs = [];
		}		
		event.renderData(type = "json", data = rs);
	}

	function getForwarders(event, rc, prc){
		var forwarders = [];
		var forwarderList = EntityLoad('forwarder');
		for(item in forwarderList) {
		   var forwarder = {};
		   forwarder.id=item.getid_forwarder();
		   forwarder.name = item.getfw_name();
		   forwarder.contact = isNull(item.getContact())?"":item.getContact().getcn_name();
		   forwarder.contactID = isNull(item.getContact())?"":item.getContact().getid_contact();

		   ArrayAppend(forwarders,forwarder);
		}

		event.renderData(type="json",data=forwarders);
	}

	function getFreights(event, rc, prc){
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

	function getIncoterms(event, rc, prc){
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

	function getZone(event, rc, prc){
		var zoneRight = rightService.getZoneRight();
		var data = userService.getZoneData();
		var zones = [];
		var zoneList ={};
		var userData = userService.getLoggedInUser();
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

	function getAgent(event, rc, prc){
		var data = deserializeJSON(GetHttpRequestData().content);
		var aAgent = agentService.getAgentByIdzone(data.zoneId);
		event.renderData(type = "json", data = aAgent);
	}

	function getCustomer(event, prc, rc){
		var data = deserializeJSON(GetHttpRequestData().content);
		var aCustomer = customerService.getcustomerByIdAgent(data.agentId);
		event.renderData(type = "json", data = aCustomer);
	} 

	function getShipmentTypes(event, prc, rc){
		var userLevel = userService.getUserLevel();
		if(userLevel == 1){
			var sh_types = shipmentService.getShipmentTypeByCode("F");
		}else if(userLevel == 2){
			var sh_types = shipmentService.getShipmentTypeByCode("Z");
		}else if(userLevel == 3){
			var sh_types = shipmentService.getShipmentTypeByCode("A");
		}else{
			var sh_types = [];
		}
		event.renderData(type = "json", data = sh_types);
	}

	function getSender(event, prc, rc){
		var result = shipmentService.getSender();
		event.renderData(type = "json", data = result);
	}

	function addNewShipmentInfor(event, prc, rc){
		if(event.GETHTTPMETHOD() == "POST")
		{
			
				if(rc.id_shipmentinfor == 0)
				{
					var user_created = userService.getLoggedInUser();
					var user_updated = user_created;
					var created = now();
					var updated = created;
					writedump(rc);
					// writedump(EntityLoadByPk("contact",val(rc.contact)));
					// abort; 
					var newShipmentInfor = shipment_informationService.new({sh_name:rc.name, sh_address_1:rc.address_1, sh_address_2:rc.address_2, sh_address_3:rc.address_3,
																			sh_city:rc.city, sh_province:rc.province, sh_zip_code:rc.zip_code, sh_country:rc.country,
																			sh_phone:rc.phone, sh_email:rc.email, sh_note:rc.note, contact:rc.contact});
					// newShipmentInfor.setcontact(EntityLoadByPk("contact",val(rc.contact)));
					var result = shipment_informationService.save(newShipmentInfor);
					if(result)
						event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new shipment information successfully'});
					else
						event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new shipment information failed !' });
				}else{
					var ShipmentInfor = shipment_informationService.get(rc.id_shipmentinfor);
					// writedump(rc);
					// abort; 		
					var user_updated = userService.getLoggedInUser();
					var updated = now();

					ShipmentInfor.setUser_Updated(user_updated);
					ShipmentInfor.setUpdated(updated);
					ShipmentInfor.setsh_name(rc.name);
					ShipmentInfor.setsh_address_1(rc.address_1);
					ShipmentInfor.setsh_address_2(rc.address_2);
					ShipmentInfor.setsh_address_3(rc.address_3);
					ShipmentInfor.setsh_city(rc.city);
					ShipmentInfor.setsh_province(rc.province);
					ShipmentInfor.setsh_zip_code(rc.zip_code);
					ShipmentInfor.setsh_country(rc.country);
					ShipmentInfor.setsh_phone(rc.phone);
					ShipmentInfor.setsh_email(rc.email);
					ShipmentInfor.setsh_note(rc.note);
					ShipmentInfor.setcontact(EntityLoadByPk("contact",val(rc.contact)));

					var result = shipment_informationService.save(ShipmentInfor);

					if(result)
						event.renderData(type="json",data={ 'success' : true , 'message' : 'Update shipment information successfully'});
					else
						event.renderData(type="json",data={ 'success' : false , 'message' : 'Update shipment information failed !' });
				}
			
		}
	}

	function getShipmentInfor(event, prc, rc){
		if(structKeyExists(rc, "id")){
			if(rc.id != 0){
				var result = shipmentService.getShipmentInfor(rc.id);
				var shipmentinfor      = {};
				shipmentinfor.id       = result.id_shipment_information;
				shipmentinfor.name     = result.sh_name;
				shipmentinfor.address1 = result.sh_address_1;
				shipmentinfor.address2 = result.sh_address_2;
				shipmentinfor.address3 = result.sh_address_3;
				shipmentinfor.city 	   = result.sh_city;
				shipmentinfor.province = result.sh_province;
				shipmentinfor.zipcode  = result.sh_zip_code;
				shipmentinfor.country  = result.sh_country;
				shipmentinfor.phone    = result.sh_phone;
				shipmentinfor.email    = result.sh_email;
				shipmentinfor.note     = result.sh_note;
			}
		}
		event.renderData(type = "json", data = shipmentinfor);
	}
	
}