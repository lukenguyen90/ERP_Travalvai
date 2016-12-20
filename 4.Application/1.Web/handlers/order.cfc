component output="false" displayname=""  {
	property name='userService' 			inject='userService';
	property name='zoneService' 			inject='zoneService';
	property name='agentService' 			inject='agentService';
	property name='customerService' 		inject='customerService';
	property name='paymentService' 			inject='paymentService';
	property name='orderConditionService' 	inject='order_conditionService';
	property name='orderTypeService' 		inject='order_typeService';
	property name='productService' 			inject='productService';
	property name='projectService' 			inject='projectService';
	property name='orderService' 			inject='orderService';
	property name='orderDetailsService' 	inject='order_detailsService';
	property name='sizesService' 			inject="sizesService";
	property name='sizesDetailsService' 	inject="entityService:sizes_details";
	property name='numberService' 			inject='numberHelper';

	

	function getOrderDetailsLineView(event,prc,rc){
		var data = deserializeJSON(GetHttpRequestData().content);
		var rs = {};
		rs = orderDetailsService.getOrderDetailsLineView(data.orderID);
		event.renderData(type = "json", data = rs);
	}
	function getOrderInfo(){
		var data = deserializeJSON(GetHttpRequestData().content);
		var rs = {};
		rs = orderDetailsService.getOrderInfo(data.orderID);
		event.renderData(type = "json", data = rs);
	}
	function getListOrders(event,prc,rc){
		var rs = {};
		rs = orderDetailsService.getListOrders(rc.start, val(rc.length), rc.columns, rc.order, rc.draw, rc.search);
		event.renderData(type = "json", data = rs);
	}

	function getListConditions(event, prc, rc){
		var ns = {};
		ns = orderConditionService.getListConditions();
		event.renderData(type = "json", data = ns);
	}

	function getListOrderTypes(event, prc, rc){
		var es = {};
		es = orderTypeService.getListOrderTypes();
		event.renderData(type = "json", data = es);
	}

	function getListPayments(event, prc, rc){
		var ts = {};
		ts = paymentService.getPayment();
		event.renderData(type = "json", data = ts);
	}

	function getResumeOrders(event,prc,rc){
		var rs = {};
		rs = orderDetailsService.getResumeOrders(rc.start, val(rc.length), rc.columns, rc.order, rc.draw, rc.search);
		event.renderData(type = "json", data = rs);
	}


	function getOrderDetails_SizeView(event,prc,rc){
		var data = deserializeJSON(GetHttpRequestData().content);
		var rs = {};
		rs = orderDetailsService.getOrderDetails_SizeView(data.orderID);
		event.renderData(type = "json", data = rs);
	}

	function getZone(event, prc, rc){
		var aZone = zoneService.getZoneByFactory();
		event.renderData(type = "json", data = aZone);
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

	function getCustomerDetail(event, prc, rc){
		var data = deserializeJSON(GetHttpRequestData().content);
		var customer = customerService.getCustomerDetail(data.customerId);
		event.renderData(type = "json", data = customer);
	}

	function getPayment(event, prc, rc){
		var aPayment = paymentService.getPayment();
		event.renderData(type = "json", data = aPayment);
	}

	function getOrderCondition(event, prc, rc){
		var aOrderCondition = orderConditionService.getListConditions();
		event.renderData(type = "json", data = aOrderCondition);
	}

	function getOrderType(event, prc, rc){
		var aOrderType = orderTypeService.getListOrderTypes();
		event.renderData(type = "json", data = aOrderType);
	}

	function getProject(event, prc, rc){
		var data = deserializeJSON(GetHttpRequestData().content);
		var aProject = productService.getProjectByCustomer(data.customerId);
		event.renderData(type = "json", data = aProject);
	}
	function getSizes(event, prc, rc){
		var aSizes = sizesService.getSizes();
		event.renderData(type = "json", data = aSizes);
	}

	function getProduct(event, prc, rc){
		var data = deserializeJSON(GetHttpRequestData().content);
		var aProduct = productService.getListProduct(data.projectID);
		event.renderData(type = "json", data = aProduct);
	}

	// function readeCSVFile(event, prc, rc) {
	// 	var listSizeDetail = [];

	// 	if(structKeyExists(rc, "uploadFile")){
	// 		var getFile 	= rc.uploadFile ?:"";
	// 		var alert_path 	= expandPath("/includes/");
 //            if( len(getFile) > 0){
 //                newUpload 		= fileUpload(alert_path, "uploadFile", "", "makeUnique");
 //                fileName 		= newUpload.serverfile;
	// 			var myFile 		= FileOpen("#alert_path##fileName#","readBinary","utf-8");
	// 			var readFile 	= FileRead(myFile);
	// 			var FileLines 	= listtoarray(readFile,"#chr(13)##chr(10)#");

	// 			for(i=1;i<=arrayLen(FileLines);i++){
	// 				var size_detail  = {
	// 					  "id_size" 		= "#listgetat(FileLines[i],1)#"
	// 					, "id_size_det" 	= "#listgetat(FileLines[i],2)#"
	// 					, "name" 			= "#listgetat(FileLines[i],3)#"
	// 					, "number" 			= "#listgetat(FileLines[i],4)#"
	// 					, "quantity" 		= "#listgetat(FileLines[i],5)#"
	// 					, "szd_position" 	= "#listgetat(FileLines[i],6)#"
	// 					, "szd_size" 		= "#listgetat(FileLines[i],7)#"
	// 				}
	// 				arrayAppend(listSizeDetail,size_detail);
	// 			}
	// 			FileClose(myFile);
 //            }
	// 	}
	// 	event.renderData(type = "json", data = listSizeDetail);
	// }
	function strorder(){
		var a = {"deliveryFactory":{"priceList":"PSB - PSB - 2016","delivered":0,"confirmationDate":"","toDeliver":"No factory to deliver","deliveryDate":""},"condition":{"$MIXED":true,"id_order_condition":2,"oc_description":"Agent"},"units":"","date":"04/11/2016","offer":"ttt","deliveryZone":{"delivered":0,"confirmationDate":"","toDeliver":"No zone to deliver","deliveryDate":""},"customer":{"ID":40,"description":"40 - vy dan"},"discount2":20,"status":{"$MIXED":true,"id_order_status":2,"os_description":"Delivered"},"discount1":10,"agent":{"description":"BN - Berne"},"id":76,"deliveryAgent":{"priceList":"PSB - PSB - 2016","delivered":0,"toDeliver":"No zone to deliver","deliveryDate":""},"type":{"$MIXED":true,"id_order_type":2,"ot_description":"Reposition"},"zone":{"description":"16 - thuy sy"},"description":"thinh test NOT DELETE","payment":{"$MIXED":true,"id_payment":1,"pay_code":"PAY-1","pay_description":"First pay ","pay_dp":10,"pay_delivery":15,"pay_30_days":20,"pay_60_days":25,"pay_other":30,"pay_day":30},"product":{"garmentCode":"23-PSB-PSB","club_12":0,"cost_code":"PSB","price":{"priceList":{"factory":2.06,"agent":2.68,"zone":2.6},"order":{"factory":0,"agent":0,"zone":0},"hasContract":false,"manual":{"factory":37,"agent":30,"zone":39},"total":{"factory":173.4,"agent":179.6,"zone":184.2},"custom":{"factory":136.4,"agent":149.6,"zone":145.2},"grandTotal":{"factory":0,"agent":0,"zone":0},"isContractExpired":""},"customer":"vy dan","version":5,"web_13":0,"status":"Approved","agent":"Berne","sizesDetail":[{"id_size":1,"number":"","szd_position":"1","id_size_det":87,"name":"","quantity":"4","szd_size":"6XS"},{"id_size":1,"number":"","szd_position":"4","id_size_det":88,"name":"","quantity":"5","szd_size":"3XS"},{"id_size":1,"number":"","szd_position":"5","id_size_det":89,"name":"","quantity":"6","szd_size":"XXS"},{"id_size":1,"number":"","szd_position":"6","id_size_det":90,"name":"","quantity":"7","szd_size":"XS"},{"id_size":1,"number":"","szd_position":"7","id_size_det":91,"name":"","quantity":"","szd_size":"S"},{"id_size":1,"number":"","szd_position":"8","id_size_det":92,"name":"","quantity":"","szd_size":"M"},{"id_size":1,"number":"","szd_position":"9","id_size_det":93,"name":"","quantity":"","szd_size":"L"},{"id_size":1,"number":"","szd_position":"10","id_size_det":94,"name":"","quantity":"","szd_size":"XL"},{"id_size":1,"number":"","szd_position":"11","id_size_det":95,"name":"","quantity":"","szd_size":"XXL"},{"id_size":1,"number":"","szd_position":"12","id_size_det":96,"name":"","quantity":"","szd_size":"3XL"},{"id_size":1,"number":"","szd_position":"13","id_size_det":97,"name":"","quantity":"","szd_size":"4XL"},{"id_size":1,"number":"","szd_position":"14","id_size_det":98,"name":"","quantity":"","szd_size":"5XL"},{"id_size":1,"number":"","szd_position":"15","id_size_det":99,"name":"","quantity":"","szd_size":"6XL"},{"id_size":1,"number":"","szd_position":"2","id_size_det":216,"name":"","quantity":"","szd_size":"5XS"},{"id_size":1,"number":"","szd_position":"3","id_size_det":217,"name":"","quantity":"","szd_size":"4XS"}],"cost_code_vers":"0","sketch":"5.jpg","picture":"","zone":"thuy sy","idProduct":45,"description":"test","section":"4","group":"","$$hashKey":13},"sizeType":0,"group":"thinh"};
		writeDump(a);
		abort;
		return "";
	}

	function getProductDetail(event, rc, prc){
		var data = deserializeJSON(GetHttpRequestData().content);
		var strProductDetail = orderDetailsService.getProductDetail(data.id_order, data.id_product, data.priceList, data.group, data.size_custom);
		event.renderData(type = "json", data = strProductDetail);		
	}
	

	
    function createOrder(event, rc, prc){		
		// if(event.GETHTTPMETHOD() == "POST"){
			// if(rc.id_order_temp == 0){
		var data = deserializeJSON(GetHttpRequestData().content);
		var orderInfo 		= data;
		var product 		= data.product;
		var dataSizes 		= data.product.sizesDetail;
		if(orderInfo.id != 0){
			var idorder 		= orderInfo.id;
			var order 			 = entityLoadByPK("orders", idorder);
			var productComponent = entityLoadByPK("product", product.idProduct);
			var priceZone 	= productComponent.getprice_list_zone_detail().getprice_list_zone();
			var priceFac 	= productComponent.getprice_list_zone_detail().getprice_list_zone().getprice_list_factory();
			order.setprice_list_factory(priceFac);
			order.setprice_list_zone(priceZone);
			orderService.save(order);
		}							
				
		//end set price list	
		for(item in dataSizes){
			if(val(item.quantity) > 0){
				var size = entityLoadByPK("sizes",item.id_size);
				var sizesDetail 	= entityLoad("sizes_details", {id_size_det : item.id_size_det},true);
				/* set orderDetails */
				var orderDetails = orderDetailsService.new();
					orderDetails.setordd_size_custom(orderInfo.sizeType);
					orderDetails.setordd_cg_name(!isNull(orderInfo.group)?orderInfo.group: "");
					orderDetails.setordd_line(JavaCast("null", ""));
					if(orderInfo.sizeType != 0){
						orderDetails.setordd_name(item.name);
						orderDetails.setordd_number(item.number);
					}				
					orderDetails.setordd_qtty(item.quantity);
					orderDetails.setordd_fty_pr(JavaCast("null", ""));
					orderDetails.setordd_zone_pr(JavaCast("null", ""));
					orderDetails.setordd_ag_pr(JavaCast("null", ""));

					orderDetails.setordd_pricelist(SerializeJSON(product.price));
					orderDetails.setorder(order);
					orderDetails.setproduct(productComponent);				
					orderDetails.setsize_details(sizesDetail);
				//save orderDetails	
				orderDetailsService.save(orderDetails);
			}
		}
			// }
		// }
		event.renderData(type="json",data={"id":order.getid_order()});
	}

	function editOrder(event, rc, prc){
		var data = deserializeJSON(GetHttpRequestData().content);
		var orderInfo 		= data;
		var product 		= data.product;
		var dataSizes 		= data.product.sizesDetail;
		var order 			= entityLoadByPK("orders", data.id);
		var productComponent 	= entityLoadByPK("product", product.idProduct);
		var order_details 		= entityLoad("order_details", {order : order, product: productComponent, ordd_pricelist: SerializeJSON(product.price), ordd_cg_name: data.group});
		//delete product 
		try {
			orderDetailsService.deleteProductSizeView(data.id, product.idProduct, SerializeJSON(product.price), data.group, data.sizeType);
			//add product	
			if(data.sizeType == 0){
				for(item in dataSizes){
					if(val(item.quantity) > 0){
						var sizesDetail 	= entityLoad("sizes_details", {id_size_det : item.id_size_det},true);
						/* set orderDetails */
						var orderDetails = orderDetailsService.new();
							orderDetails.setordd_size_custom(data.sizeType);
							orderDetails.setordd_cg_name(!isNull(orderInfo.group)?orderInfo.group: "");
							orderDetails.setordd_line(JavaCast("null", ""));
							orderDetails.setordd_qtty(item.quantity);
							orderDetails.setordd_fty_pr(JavaCast("null", ""));
							orderDetails.setordd_zone_pr(JavaCast("null", ""));
							orderDetails.setordd_ag_pr(JavaCast("null", ""));

							orderDetails.setordd_pricelist(SerializeJSON(product.price));
							orderDetails.setorder(order);
							orderDetails.setproduct(productComponent);				
							orderDetails.setsize_details(sizesDetail);
						//save orderDetails	
						orderDetailsService.save(orderDetails);
					}
				}
				event.renderData(type="json",data={"success":true});
			}else{
				for(item in data.orderItems){
					var sizesDetail 	= entityLoad("sizes_details", {id_size_det : item.id_size_det},true);
					/* set orderDetails */
					var orderDetails = orderDetailsService.new();
						orderDetails.setordd_size_custom(data.sizeType);
						orderDetails.setordd_cg_name(!isNull(orderInfo.group)?orderInfo.group: "");
						orderDetails.setordd_line(JavaCast("null", ""));
						if(orderInfo.sizeType != 0){
							orderDetails.setordd_name(structKeyExists(item, "name") ? item.name : JavaCast("null", ""));
							orderDetails.setordd_number(structKeyExists(item, "number") ? item.number : JavaCast("null", ""));
						}				
						orderDetails.setordd_qtty(item.quantity);
						orderDetails.setordd_fty_pr(JavaCast("null", ""));
						orderDetails.setordd_zone_pr(JavaCast("null", ""));
						orderDetails.setordd_ag_pr(JavaCast("null", ""));

						orderDetails.setordd_pricelist(SerializeJSON(product.price));
						orderDetails.setorder(order);
						orderDetails.setproduct(productComponent);				
						orderDetails.setsize_details(sizesDetail);
					//save orderDetails	
					orderDetailsService.save(orderDetails);
				}
				event.renderData(type="json",data={"success":true});
			}
		}
		catch(any e) {
			event.renderData(type="json",data={"success":false});
		}	
		
	}

    function createOrderInfo(){
    	var orderInfo = deserializeJSON(GetHttpRequestData().content);
		var description 	= orderInfo.description;
		var discount_1 		= isNull(orderInfo.discount1)?0:orderInfo.discount1;
		var discount_2 		= isNull(orderInfo.discount2)?0:orderInfo.discount2;
		var customerId		= orderInfo.customer.ID;
		var orderTypeId 	= orderInfo.type.id_order_type;
		var orderConId 		= orderInfo.condition.id_order_condition;
		var paymentId 		= orderInfo.payment.id_payment;
		var ag_commission 	= isNull(orderInfo.ag_commission)?0:orderInfo.ag_commission;
		var customer 	= entityLoadByPK("customer", customerId);
		var orderType 	= entityLoadByPK("order_type", orderTypeId);
		var orderCon 	= entityLoadByPK("order_condition", orderConId);
		var payment 	= entityLoadByPK("payment", paymentId);
		//set order
		var order 		= orderService.new();
			order.setord_description(description);
			order.setord_date(now());
			/* order.setord_fty_del_date(now());//none
			order.setord_fty_confirm(now());//none
			order.setord_zone_del_date(now());//none
			order.setord_zone_confirm(now());//none
			order.setord_ag_del_date(now());//none */
			order.setord_ag_commission(ag_commission);
			order.setoffer(orderInfo.offer);
			order.setord_discount_1(discount_1);
			order.setord_discount_2(discount_2);
			order.setcustomer(customer);
			order.setorder_type(orderType);
			order.setorder_condition(orderCon);
			order.setpayment(payment);
		//save order
		orderService.save(order);	
		event.renderData(type="json",data={"id":order.getid_order()});	
		//return order.getid_order();
    }

    function createPaymentInfo(){
    	var paymentInfo 	= deserializeJSON(GetHttpRequestData().content);
    	writedump(paymentInfo);
    	var pay_code		= paymentInfo.paymentcode;
    	var pay_description = paymentInfo.description;
    	var pay_dp 			= paymentInfo.downpayment;
    	var pay_delivery 	= paymentInfo.ondelivery;
    	var pay_30_days 	= paymentInfo.thirtydays;
    	var pay_60_days 	= paymentInfo.sixtydays;
    	var pay_other 		= paymentInfo.other;
    	var pay_day 		= paymentInfo.paymentday;
    	var payment 		= paymentService.new();
    		payment.setpay_code(pay_code);
    		payment.setpay_description(pay_description);
    		payment.setpay_dp(pay_dp);
    		payment.setpay_delivery(pay_delivery);
    		payment.setpay_30_days(pay_30_days);
    		payment.setpay_60_days(pay_60_days);
    		payment.setpay_other(pay_other);
    		payment.setpay_day(pay_day);
    	paymentService.save(payment);
    	event.renderData(type="json",data={"id":payment.getid_payment()});	
    }

    function editOrderInfo(){
    	var data = deserializeJSON(GetHttpRequestData().content);
		var orderInfo 		= data;
    	var description 	= orderInfo.description;
		var discount_1 		= isNull(orderInfo.discount1)?0:orderInfo.discount1;
		var discount_2 		= isNull(orderInfo.discount2)?0:orderInfo.discount2;
		var orderTypeId 	= orderInfo.type.id_order_type;
		var orderConId 		= orderInfo.condition.id_order_condition;
		var paymentId 		= orderInfo.payment.id_payment;
		var ag_commission 	= isNull(orderInfo.ag_commission)?0:orderInfo.ag_commission;
		var orderType 	= entityLoadByPK("order_type", orderTypeId);
		var orderCon 	= entityLoadByPK("order_condition", orderConId);
		var payment 	= entityLoadByPK("payment", paymentId);
		//set order
		var order 		= entityLoadByPK("orders", orderInfo.id);
			order.setord_description(description);
			//fac confirm
			if(orderInfo.deliveryFactory.confirmationDate != "None" and orderInfo.deliveryFactory.confirmationDate != "NaN/NaN/NaN"){
				var confirmationDate = orderInfo.deliveryFactory.confirmationDate;
				order.setord_fty_confirm(confirmationDate);
			}
			//fac deliver
			if(orderInfo.deliveryFactory.deliveryDate != "None" and orderInfo.deliveryFactory.deliveryDate != "NaN/NaN/NaN"){
				var deliveryDate = orderInfo.deliveryFactory.deliveryDate;
				order.setord_fty_del_date(deliveryDate);
			}
			//zone confirm
			if(orderInfo.deliveryZone.confirmationDate != "None" and orderInfo.deliveryZone.confirmationDate != "NaN/NaN/NaN"){
				var confirmationDate = orderInfo.deliveryZone.confirmationDate;
				order.setord_zone_confirm(confirmationDate);
			}
			//zone deliver
			if(orderInfo.deliveryZone.deliveryDate != "None" and orderInfo.deliveryZone.deliveryDate != "NaN/NaN/NaN"){
				var deliveryDate = orderInfo.deliveryZone.deliveryDate;
				order.setord_zone_del_date(deliveryDate);
			}
			//agent deliver
			if(orderInfo.deliveryAgent.deliveryDate != "None" and orderInfo.deliveryAgent.deliveryDate != "NaN/NaN/NaN"){
				var deliveryDate = orderInfo.deliveryAgent.deliveryDate;
				order.setord_ag_del_date(deliveryDate);
			}
			order.setord_ag_commission(ag_commission);
			if(orderInfo.offer != ""){
				order.setoffer(orderInfo.offer);
			}	
			//writeDump(discount_1);abort;
			order.setord_discount_1(discount_1);
			order.setord_discount_2(discount_2);
			order.setorder_type(orderType);
			order.setorder_condition(orderCon);
			order.setpayment(payment);
		//save order
		var result = orderService.save(order);
		if(result == 1){
			event.renderData(type="json",data={"success": true, "message": "Edit order success!"});
		}else{
			event.renderData(type="json",data={"success": false, "message": "Edit order failed!"});
		}		
		
		
    }
    function editSizeQuantity(event, prc, rc){
    	var data 	= deserializeJSON(GetHttpRequestData().content);
    	var result  = orderDetailsService.editSizeQuantity(data.id_order_det, data.quantity);
    	event.renderData(type = "json", data = {"isEdit" : result});
    }

    function deleteProduct(event,prc,rc){
    	var data 	= deserializeJSON(GetHttpRequestData().content);
    	var result  = orderDetailsService.deleteProduct(data.order_detailId);
    	event.renderData(type = "json", data = {"isDeleted" : result});
    }

    function deleteProductSizeView(event,prc,rc){
    	var data 	= deserializeJSON(GetHttpRequestData().content);
    	var result  = orderDetailsService.deleteProductSizeView(data.id_order, data.id_product, data.priceList, data.group_name, data.size_custom);
    	event.renderData(type = "json", data = {"isDeleted" : result});
    }


    function deleteOrder(event,prc,rc){
    	var result  = true;
    	var data 	= deserializeJSON(GetHttpRequestData().content);
    	var order   = entityLoadByPK("orders",data.orderId);
    	var order_details = entityLoad("order_details",{order = order});
    	for(orderDetailsItem in order_details){
    		try{
    			orderDetailsService.deleteProduct(data.orderId, orderDetailsItem.getid_order_det());
    		}catch(any ex) {
   				result = false;
   			}
    	}
    	var delOrder = orderDetailsService.deleteOrder(order.getid_order()); 
    	if(delOrder == false){
    		result = false;
    	}
    	event.renderData(type = "json", data = {"isDeleted": result});   	
    }
	
	function getOrders(){
		var rs = [];
		rs = orderService.getOrders();
		event.renderData(type = "json", data = rs);
	}

	function getUserLevel() {
		event.renderData(type = "json", data = userService.getUserLevel()); 
	}

	function getOrderById(event,prc,rc){
		var rs = {};
		rs = orderService.getOrderById(rc.orderId);
		event.renderData(type = "json", data = rs);
	}
	
	///////////////////
	function getOrderTypes(event, prc, rc){
		var userType = userService.getUserLevel();
		var oderTypes = [];
		if(userType == 3){
			oderTypes = orderService.getOrderTypes();
		}		
		event.renderData(type="json",data=oderTypes);
	}
	
	
}