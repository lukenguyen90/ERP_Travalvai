component extends="cborm.models.VirtualEntityService" singleton{
	property name ='userService' 			inject='userService';
	property name ='numberService' 			inject='numberHelper';
	property name ='productService' 		inject='productService';
	property name ='projectService' 		inject='projectService';	
	property name='orderDetailsService' 	inject='order_detailsService';
	/**
	* Constructor
	*/
	function init(){
		// init super class
		super.init( entityName="order_details" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.order_details" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}
	private function getGroupOrderID(){
		var userLevel 	= userService.getUserLevel();
		var result = [];
		if(userLevel == 1){
			result = QueryExecute("
					select id_order
					from orders
					group by id_order
				");
		}else if(userLevel == 2){
			var zoneId = userService.getZoneID();
			result = QueryExecute("
					select id_order
					from orders od
						inner join customer cu
							on od.id_customer = cu.id_customer
					where cu.id_zone = #zoneId#
					group by id_order
				");
		}else if(userLevel == 3){
			var agentId = userService.getAgentID();
			result = QueryExecute("
					select id_order
					from orders od
						inner join customer cu
							on od.id_customer = cu.id_customer
					where cu.id_agent = #agentId#
					group by id_order
				");
		}else{
			var customerID = userService.getCustomerID();
			result = QueryExecute("
					select id_order
					from orders od
						inner join customer cu
							on od.id_customer = cu.id_customer
					where cu.id_customer = #customerID#
					group by id_order
				");
		}
		return result;
	}
	private function sumOfQuantityDetails(orderID){
		var result = QueryExecute("
				select sum(ordd_qtty) sum
				from order_details
				where id_order = #orderID#
			");
		return result;
	}
	private function getOrderDetailsByID(){
		var result = QueryExecute("
				select *
				from order_details odt
				 inner join orders od
				 	on odt.id_order = od.id_order
			");
		return result;
	}
	private function getGroupProductInfo(numeric oderID){
		var result = [];
		var data = QueryExecute("
				select id_product, ordd_pricelist, sum(ordd_qtty) sum
				from order_details
				where id_order = #oderID#
				group by id_product, ordd_pricelist
			");
		if(data.recordCount){
			result = queryToArray(data);
		}
		return result;
	}

	private function getListOrderID(){
		var userLevel 	= userService.getUserLevel();
		var result = "";
		if(userLevel == 1){
			//set limit for group_concat
			queryExecute("SET SESSION group_concat_max_len = 10000000000000");
			var qListID = QueryExecute("
					select group_concat(DISTINCT id_order ORDER BY id_order DESC) as id_order
					from orders
				");
			if(qListID.recordCount)
				result = qListID.id_order;
		}else if(userLevel == 2){
			var zoneId = userService.getZoneID();
			//set limit for group_concat
			
			queryExecute("SET SESSION group_concat_max_len = 10000000000000");
			var qListID = QueryExecute("
					select group_concat(DISTINCT id_order ORDER BY id_order DESC) as id_order
					from orders od
						inner join customer cu
							on od.id_customer = cu.id_customer
					where cu.id_zone = #zoneId#
				");
			if(qListID.recordCount)
				result = qListID.id_order;
		}else if(userLevel == 3){
			var agentId = userService.getAgentID();
			queryExecute("SET SESSION group_concat_max_len = 10000000000000");
			var qListID = QueryExecute("
					select group_concat(DISTINCT id_order ORDER BY id_order DESC) as id_order
					from orders od
						inner join customer cu
							on od.id_customer = cu.id_customer
					where cu.id_agent = #agentId#
				");
			if(qListID.recordCount)
				result = qListID.id_order;
		}else{
			var customerID = userService.getCustomerID();
			queryExecute("SET SESSION group_concat_max_len = 10000000000000");
			var qListID = QueryExecute("
					select group_concat(DISTINCT id_order ORDER BY id_order DESC) as id_order
					from orders od
						inner join customer cu
							on od.id_customer = cu.id_customer
					where cu.id_customer = #customerID#					
				");
			if(qListID.recordCount)
				result = qListID.id_order;
		}
		return result;
	}

	private function getFullOrdersLine(numeric startItem, numeric lengthItem,string columns, string order, numeric draw, string search){
		columns = deserializeJSON('['&columns&']');
		order 	= deserializeJSON(order);
		search  = deserializeJSON(search);
		var searchString = "";		
		//search
		if(search.value != ""){
			if(search.value == "none" or search.value == "None"){
    			searchString &= " 
        		OR orders.ord_fty_confirm is NULL OR

				orders.ord_zone_confirm is NULL OR

				orders.ord_fty_delivered is NULL OR

				orders.ord_zone_delivered is NULL OR

				orders.ord_ag_delivered is NULL
            	";
    		}
			searchString &= " AND
				(orders.id_order LIKE '%#search.value#%' OR
				orders.ord_fty_confirm LIKE '%#search.value#%' OR
				customer.cs_name LIKE '%#search.value#%' OR
				orders.ord_description LIKE '%#search.value#%' OR
				odt.ot_description LIKE '%#search.value#%' OR
				odc.oc_description LIKE '%#search.value#%' OR

				orders.ord_zone_confirm LIKE '%#search.value#%' OR
				orders.ord_fty_delivered LIKE '%#search.value#%' OR
				orders.ord_zone_delivered LIKE '%#search.value#%' OR
				orders.ord_ag_delivered LIKE '%#search.value#%' OR

				orders.ord_discount_1 LIKE '%#search.value#%' OR
				orders.ord_discount_2 LIKE '%#search.value#%')
				";
		}
		for(item in columns){
	        if(item.searchable){
	            if(item.search.value != ""){
	            	if(isNull(item.data)){
	            		if(item.search.value == "none" or item.search.value == "None"){
	            			searchString &= " 
		            		OR orders.ord_fty_confirm is NULL OR

							orders.ord_zone_confirm is NULL OR

							orders.ord_fty_delivered is NULL OR

							orders.ord_zone_delivered is NULL OR

							orders.ord_ag_delivered is NULL
			            	";
	            		}else{
		            		searchString &= " OR
		            			orders.ord_fty_confirm LIKE '%#search.value#%' OR
								orders.ord_zone_confirm LIKE '%#search.value#%' OR
								orders.ord_fty_delivered LIKE '%#search.value#%' OR
								orders.ord_zone_delivered LIKE '%#search.value#%' OR
								orders.ord_ag_delivered LIKE '%#search.value#%'
			            	";
			            }
	            	}else{
		                searchString &= " AND "&item.data&" LIKE '%" & item.search.value & "%'";	            		
	            	}
	            }
	        }
	    }
	    //end search
	    //order
		var orderby = "order by";
	    if(order.column == 0){
	        orderby &= " orders.id_order " &order.dir;
	    }
	    if(order.column == 1){
	        orderby &= " customer.cs_name " &order.dir;
	    }
	    if(order.column == 2){
	        orderby &= " orders.ord_description " &order.dir;
	    }
	    if(order.column == 3){
	        orderby &= " odt.ot_description " &order.dir;
	    }
	    if(order.column == 4){
	        orderby &= " odc.oc_description " &order.dir;
	    }
	    if(order.column == 5){
	         orderby &= " orders.id_order " &order.dir;
	    }
	    //get orders
	    var aOrders = getArrayOrders(orderby, searchString, lengthItem, startItem);
		return aOrders;
	}

	private function getArrayOrders(string orderby, string searchString, numeric lengthItem, numeric startItem){
		var aOrders = [];
		var strOrder = getListOrderID();
		var total = 0;
		var length = Len(strOrder);
		if(length){
			if(strOrder[length] == ","){
				strOrder = left(strOrder, length-1);
			}
		}
		if(Len(strOrder)){		
			var orders =  QueryExecute("
					SELECT SQL_CALC_FOUND_ROWS orders.id_order, orders.id_customer, customer.cs_name, agent.ag_code, agent.ag_description, zone.z_code, zone.z_description,
								orders.ord_description, orders.ord_fty_confirm, orders.ord_zone_confirm, orders.ord_date, orders.ord_fty_del_date,
								orders.ord_zone_del_date, orders.ord_ag_del_date, orders.ord_fty_delivered, orders.ord_zone_delivered, orders.ord_ag_delivered,
								orders.ord_discount_1, orders.ord_discount_2, orders.ord_plf as id_plf, orders.ord_plz as id_plz,
							odt.ot_description,
							odc.oc_description,
							(SELECT curr_code FROM currency WHERE currency.id_currency = plf.id_currency) as ord_plf,
							(SELECT curr_code FROM currency WHERE currency.id_currency = plz.id_currency) as ord_plz,
							(select sum(ordd_qtty) from order_details where id_order = orders.id_order) as sum
					FROM orders
						INNER JOIN customer
							ON orders.id_customer = customer.id_customer
						INNER JOIN agent
							ON agent.id_agent = customer.id_agent
						INNER JOIN zone
							ON zone.id_zone = customer.id_zone
						LEFT JOIN price_list_factory plf
							ON plf.id_plf = orders.ord_plf
						LEFT JOIN price_list_zone plz
							ON plz.id_plz = orders.ord_plz
						INNER JOIN order_type odt
							ON odt.id_order_type = orders.id_order_type
						INNER JOIN order_condition odc
							ON odc.id_order_condition = orders.id_order_condition
						INNER JOIN payment
							ON payment.id_payment = orders.id_payment
					WHERE 1 = 1 AND orders.id_order IN (#strOrder#)"
					&searchString&
					orderby&
		        	" LIMIT "&lengthItem&" OFFSET "&startItem
					);
			var totalResult = queryExecute("SELECT FOUND_ROWS() as count");
			if(orders.recordCount){
				aOrders = queryToArray(orders);
				total 	= totalResult.count;
			}
		}
		var result = {"orders": aOrders, "orders_total": total}
		return result;
	}
	
	public function getListOrders(numeric startItem, numeric lengthItem,string columns, string order, numeric draw, string search) {
		var arrOrd 		= [];	
		var orders = getFullOrdersLine(startItem, lengthItem, columns, order, draw, search);
		for(order in orders.orders){
			var strOrd = {};			
			var ord_units = 0;
			if(!isEmpty(order.sum)){
				ord_units = order.sum;
			}
			var groupProductInfo = getGroupProductInfo(order.id_order);
			var factoryPriceGrand = 0;
			var zonePriceGrand    = 0;
			var agentPriceGrand   = 0;
			var ord_ag_value 	  = numberService.roundDecimalPlaces(agentPriceGrand, 2);
			for(product in groupProductInfo){
				var totalPrice = deserializeJSON(product.ordd_pricelist).total;
				factoryPriceGrand += (product.sum * totalPrice.factory);
				zonePriceGrand 	  += (product.sum * totalPrice.zone);
				agentPriceGrand   += (product.sum * totalPrice.agent);
			}
			strOrd["id_order"]    = order.id_order;
			strOrd["id_customer"] = order.id_customer;
			strOrd["cs_name"] 	  = order.cs_name;
			strOrd["ag_code"] 	  = order.ag_code;
			strOrd["ag_description"]  = order.ag_description;
			strOrd["zone_code"] 	  = order.z_code;
			strOrd["z_description"]   = order.z_description;
			strOrd["ord_description"] = order.ord_description != "" ? order.ord_description : 'No Description';
			strOrd["ot_description"]  = order.ot_description;
			strOrd["oc_description"]  = order.oc_description;
			strOrd["ord_fty_confirm"] = !isEmpty(order.ord_fty_confirm) ? dateFormat(order.ord_fty_confirm, 'dd/mm/yyyy') : "None";
			strOrd["ord_zone_confirm"]  = !isEmpty(order.ord_zone_confirm) ? dateFormat(order.ord_zone_confirm, 'dd/mm/yyyy') : "None";
			strOrd["ord_date"]  		= dateFormat(order.ord_date, 'dd/mm/yyyy');
			strOrd["ord_fty_del_date"]  = !isEmpty(order.ord_fty_del_date) ? dateFormat(order.ord_fty_del_date, 'dd/mm/yyyy') : "None";
			strOrd["ord_zone_del_date"] = !isEmpty(order.ord_zone_del_date) ? dateFormat(order.ord_zone_del_date, 'dd/mm/yyyy') : "None";
			strOrd["ord_ag_del_date"]   = !isEmpty(order.ord_ag_del_date) ? dateFormat(order.ord_ag_del_date, 'dd/mm/yyyy') : "None";
			strOrd["ord_units"]   		= ord_units;
			strOrd["ord_fty_delivered"] = order.ord_fty_delivered;
			strOrd["ord_zone_delivered"] = order.ord_zone_delivered;
			strOrd["ord_ag_delivered"]   = order.ord_ag_delivered;
			strOrd["ord_fty_value"]     = numberService.roundDecimalPlaces(factoryPriceGrand, 2);
			strOrd["ord_zone_value"]    = numberService.roundDecimalPlaces(zonePriceGrand, 2);
			strOrd["ord_ag_value"]      = numberService.roundDecimalPlaces(agentPriceGrand, 2);
			if(isEmpty(order.ord_plf)){
				strOrd["ord_plf"]      		= "";
				strOrd["ord_plz"]      		= "";
			}else{
				strOrd["ord_plf"]      		= order.ord_plf;
				strOrd["ord_plz"]      		= order.ord_plz;
			}
			
			strOrd["ord_discount_1"]    = !isEmpty(order.ord_discount_1)?order.ord_discount_1:0;
			strOrd["ord_ag_value_dsc1"]   = numberService.roundDecimalPlaces(strOrd.ord_ag_value * order.ord_discount_1 / 100, 2);
			strOrd["ord_ag_remain_dsc1"]  = numberService.roundDecimalPlaces(strOrd.ord_ag_value - strOrd.ord_ag_value_dsc1, 2);
			strOrd["ord_discount_2"]      = !isEmpty(order.ord_discount_2)?order.ord_discount_2:0;
			strOrd["ord_ag_value_dsc2"]   = numberService.roundDecimalPlaces(strOrd.ord_ag_remain_dsc1 * order.ord_discount_2 / 100, 2);
			strOrd["ord_ag_remain_dsc2"]  = numberService.roundDecimalPlaces(strOrd.ord_ag_remain_dsc1 - strOrd.ord_ag_value_dsc2, 2);

			strOrd["ord_fty_pendent"]  = ord_units - order.ord_fty_delivered;
			strOrd["ord_zone_pendent"] = order.ord_fty_delivered - order.ord_zone_delivered;
			strOrd["ord_ag_pendent"]   = order.ord_zone_delivered - order.ord_ag_delivered;
			arrayAppend(arrOrd, strOrd);
		}
		var thinhResult = {
				"draw": draw,
				"recordsTotal": orders.orders_total,
				"recordsFiltered": orders.orders_total,
				"data": arrOrd
			}
		return thinhResult;
	}
	private function getFullOrdersResume(numeric startItem, numeric lengthItem,string columns, string order, numeric draw, string search){
		var userLevel   = userService.getUserLevel();
		columns = deserializeJSON('['&columns&']');
		order 	= deserializeJSON(order);
		search  = deserializeJSON(search);
		var searchString = "";	
		if(userLevel == 0 or userLevel == 1){
			//header search
			//search
			if(search.value != ""){
				if(search.value == "none" or search.value == "None"){
	    			searchString &= " 
	        		OR orders.ord_fty_confirm is NULL OR

					orders.ord_zone_confirm is NULL OR

					orders.ord_fty_delivered is NULL OR

					orders.ord_zone_delivered is NULL OR

					orders.ord_ag_delivered is NULL
	            	";
	    		}
				searchString &= " AND
					(orders.id_order LIKE '%#search.value#%' OR
					customer.cs_name LIKE '%#search.value#%' OR
					customer.id_customer LIKE '%#search.value#%' OR
					agent.ag_description LIKE '%#search.value#%' OR
					zone.z_description LIKE '%#search.value#%' OR
					orders.ord_description LIKE '%#search.value#%' OR
					odt.ot_description LIKE '%#search.value#%' OR
					odc.oc_description LIKE '%#search.value#%' OR
					orders.ord_fty_confirm LIKE '%#search.value#%' OR
					orders.ord_fty_del_date LIKE '%#search.value#%' OR
					orders.ord_discount_1 LIKE '%#search.value#%' OR
					orders.ord_discount_2 LIKE '%#search.value#%')
					";
			}
			//search
			for(item in columns){
		        if(item.searchable){
		            if(item.search.value != ""){
			            searchString &= " AND "&item.data&" LIKE '%" & item.search.value & "%'";
		            }
		        }
		    }
		    //end search
		    //sort
			var orderby = "order by";
		    if(order.column == 0){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 1){
		        orderby &= " customer.cs_name " &order.dir;
		    }
		    if(order.column == 2){
		        orderby &= " agent.ag_description " &order.dir;
		    }
		    if(order.column == 3){
		        orderby &= " zone.z_description " &order.dir;
		    }
		    if(order.column == 4){
		        orderby &= " orders.ord_description " &order.dir;
		    }
		    if(order.column == 5){
		        orderby &= " odt.ot_description " &order.dir;
		    }
		    if(order.column == 6){
		        orderby &= " odc.oc_description " &order.dir;
		    }
		    if(order.column == 7){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 8){
		        orderby &= " orders.ord_fty_confirm " &order.dir;
		    }
		    if(order.column == 9){
		        orderby &= " orders.ord_fty_del_date " &order.dir;
		    }
		    if(order.column == 10){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 11){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 12){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 13){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 14){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 15){
		        orderby &= " orders.id_order " &order.dir;
		    }
		}else if(userLevel == 2){
			//header search
			//search

			if(search.value != ""){
				if(search.value == "none" or search.value == "None"){
	    			searchString &= " 
	        		OR orders.ord_fty_confirm is NULL OR

					orders.ord_zone_confirm is NULL OR

					orders.ord_fty_delivered is NULL OR

					orders.ord_zone_delivered is NULL OR

					orders.ord_ag_delivered is NULL
	            	";
	    		}
				searchString &= " AND
					(orders.id_order LIKE '%#search.value#%' OR
					customer.cs_name LIKE '%#search.value#%' OR
					customer.id_customer LIKE '%#search.value#%' OR
					agent.ag_description LIKE '%#search.value#%' OR
					orders.ord_description LIKE '%#search.value#%' OR
					odt.ot_description LIKE '%#search.value#%' OR
					odc.oc_description LIKE '%#search.value#%' OR
					orders.ord_fty_del_date LIKE '%#search.value#%' OR
					orders.ord_zone_del_date LIKE '%#search.value#%' OR
					orders.ord_ag_del_date LIKE '%#search.value#%' OR
					orders.ord_discount_1 LIKE '%#search.value#%' OR
					orders.ord_discount_2 LIKE '%#search.value#%')
					";
			}
			//search
			for(item in columns){
		        if(item.searchable){
		            if(item.search.value != ""){
			            searchString &= " AND "&item.data&" LIKE '%" & item.search.value & "%'";
		            }
		        }
		    }
		    //end search
		    //sort
		   	var orderby = "order by";
		    if(order.column == 0){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 1){
		        orderby &= " customer.cs_name " &order.dir;
		    }
		    if(order.column == 2){
		        orderby &= " agent.ag_description " &order.dir;
		    }
		    if(order.column == 3){
		        orderby &= " orders.ord_description " &order.dir;
		    }
		    if(order.column == 4){
		        orderby &= " odt.ot_description " &order.dir;
		    }
		    if(order.column == 5){
		        orderby &= " odc.oc_description " &order.dir;
		    }
		    if(order.column == 6){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 7){
		        orderby &= " orders.ord_fty_del_date " &order.dir;
		    }
		    if(order.column == 8){
		        orderby &= " orders.ord_zone_del_date " &order.dir;
		    }
		    if(order.column == 9){
		        orderby &= " orders.ord_ag_del_date " &order.dir;
		    }
		    if(order.column == 10){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 11){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 12){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 13){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 14){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 15){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 16){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 17){
		        orderby &= " orders.id_order " &order.dir;
		    }
		}else if(userLevel == 3){
			//header search
			//search			
			if(search.value != ""){
				if(search.value == "none" or search.value == "None"){
	    			searchString &= " 
	        		OR orders.ord_fty_confirm is NULL OR

					orders.ord_zone_confirm is NULL OR

					orders.ord_fty_delivered is NULL OR

					orders.ord_zone_delivered is NULL OR

					orders.ord_ag_delivered is NULL
	            	";
	    		}
				searchString &= " AND
					(orders.id_order LIKE '%#search.value#%' OR
					customer.cs_name LIKE '%#search.value#%' OR
					customer.id_customer LIKE '%#search.value#%' OR
					orders.ord_description LIKE '%#search.value#%' OR
					odt.ot_description LIKE '%#search.value#%' OR
					odc.oc_description LIKE '%#search.value#%' OR
					orders.ord_zone_del_date LIKE '%#search.value#%' OR
					orders.ord_ag_del_date LIKE '%#search.value#%' OR
					orders.ord_zone_delivered LIKE '%#search.value#%' OR
					orders.ord_ag_value LIKE '%#search.value#%' OR
					orders.ord_ag_value_dsc1 LIKE '%#search.value#%' OR
					orders.ord_ag_value_dsc2 LIKE '%#search.value#%')
					";
			}
			//search
			for(item in columns){
		        if(item.searchable){
		            if(item.search.value != ""){
			            searchString &= " AND "&item.data&" LIKE '%" & item.search.value & "%'";
		            }
		        }
		    }
		    //end search
		    //sort
			var orderby = "order by";
		    if(order.column == 0){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 1){
		        orderby &= " customer.cs_name " &order.dir;
		    }
		    if(order.column == 2){
		        orderby &= " orders.ord_description " &order.dir;
		    }
		    if(order.column == 3){
		        orderby &= " odt.ot_description " &order.dir;
		    }
		    if(order.column == 4){
		        orderby &= " odc.oc_description " &order.dir;
		    }
		    if(order.column == 5){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 6){
		        orderby &= " orders.ord_zone_del_date " &order.dir;
		    }
		    if(order.column == 7){
		        orderby &= " orders.ord_ag_del_date " &order.dir;
		    }
		    if(order.column == 8){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 9){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 10){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 11){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 12){
		        orderby &= " orders.id_order " &order.dir;
		    }
		}else{
			//header search
			//search

			if(search.value != ""){
				if(search.value == "none" or search.value == "None"){
	    			searchString &= " 
	        		OR orders.ord_fty_confirm is NULL OR

					orders.ord_zone_confirm is NULL OR

					orders.ord_fty_delivered is NULL OR

					orders.ord_zone_delivered is NULL OR

					orders.ord_ag_delivered is NULL
	            	";
	    		}
				searchString &= " AND
					(orders.id_order LIKE '%#search.value#%' OR
					customer.cs_name LIKE '%#search.value#%' OR
					customer.id_customer LIKE '%#search.value#%' OR
					orders.ord_description LIKE '%#search.value#%' OR
					odt.ot_description LIKE '%#search.value#%' OR
					odc.oc_description LIKE '%#search.value#%' OR
					orders.ord_zone_del_date LIKE '%#search.value#%' OR
					orders.ord_ag_del_date LIKE '%#search.value#%' OR
					orders.ord_ag_value LIKE '%#search.value#%' OR
					orders.ord_ag_value_dsc1 LIKE '%#search.value#%' OR
					orders.ord_ag_value_dsc2 LIKE '%#search.value#%')
					";
			}
			//search
			for(item in columns){
		        if(item.searchable){
		            if(item.search.value != ""){
			            searchString &= " AND "&item.data&" LIKE '%" & item.search.value & "%'";
		            }
		        }
		    }
		    //end search
		    //sort
			var orderby = "order by";
		    if(order.column == 0){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 1){
		        orderby &= " customer.cs_name " &order.dir;
		    }
		    if(order.column == 2){
		        orderby &= " orders.ord_description " &order.dir;
		    }
		    if(order.column == 3){
		        orderby &= " odt.ot_description " &order.dir;
		    }
		    if(order.column == 4){
		        orderby &= " odc.oc_description " &order.dir;
		    }
		    if(order.column == 5){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 6){
		        orderby &= " orders.ord_zone_del_date " &order.dir;
		    }
		    if(order.column == 7){
		        orderby &= " orders.ord_ag_del_date " &order.dir;
		    }
		    if(order.column == 8){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 9){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 10){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 11){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 12){
		        orderby &= " orders.id_order " &order.dir;
		    }
		    if(order.column == 13){
		        orderby &= " orders.id_order " &order.dir;
		    }
		}
	    //get orders
	    var aOrders = getArrayOrders(orderby, searchString, lengthItem, startItem);
		return aOrders;
	}
	public function getResumeOrders(numeric startItem, numeric lengthItem,string columns, string order, numeric draw, string search) {
		var userLevel   = userService.getUserLevel();
		var orders = getFullOrdersResume(startItem, lengthItem, columns, order, draw, search);
		var arrOrd 		= [];
		for(order in orders.orders){
			var strOrd = {};
			var ord_units = 0;
			if(!isEmpty(order.sum)){
				ord_units = order.sum;
			}
			var groupProductInfo  = getGroupProductInfo(order.id_order);
			var factoryPriceGrand = 0;
			var zonePriceGrand    = 0;
			var agentPriceGrand   = 0;
			var ord_ag_value 	  = numberService.roundDecimalPlaces(agentPriceGrand, 2);
			var fty_confirm 		= !isEmpty(order.ord_fty_confirm) ? dateFormat(order.ord_fty_confirm, "dd/mm/yyyy") : "None";
			var zone_confirm 		= !isEmpty(order.ord_zone_confirm) ? dateFormat(order.ord_zone_confirm, "dd/mm/yyyy") : "None";
			var order_status 		= getStatus(fty_confirm, zone_confirm);
			for(product in groupProductInfo){
				var totalPrice = deserializeJSON(product.ordd_pricelist).total;
				factoryPriceGrand += (product.sum * totalPrice.factory);
				zonePriceGrand 	  += (product.sum * totalPrice.zone);
				agentPriceGrand   += (product.sum * totalPrice.agent);
			}			
			if(userLevel == 0 || userLevel == 1){
				if(!isEmpty(order.ord_fty_del_date)){
					var count = 1;
				}else{
					var count = 0;
				}
				strOrd["id_order"]    = order.id_order;
				strOrd["fty_confirm"]    = fty_confirm;
				strOrd["zone_confirm"]   = zone_confirm;
				strOrd["id_customer"] = order.id_customer;
				strOrd["cs_name"] 	  = order.cs_name;	
				strOrd["ag_code"] 	  = order.ag_code;
				strOrd["ag_description"]  = order.ag_description;
				strOrd["zone_code"] 	  = order.z_code;
				strOrd["z_description"]   = order.z_description;
				strOrd["ord_description"] = order.ord_description != "" ? order.ord_description : 'No Description';
				strOrd["ot_description"]  = order.ot_description;
				strOrd["oc_description"]  = order.oc_description;
				strOrd["os_description"]  = order_status;
				strOrd["ord_fty_confirm"] 	= !isEmpty(order.ord_fty_confirm) ? dateFormat(order.ord_fty_confirm, 'dd/mm/yyyy') : "None";
				strOrd["ord_zone_confirm"]  = !isEmpty(order.ord_zone_confirm) ? dateFormat(order.ord_zone_confirm, 'dd/mm/yyyy') : "None";
				strOrd["ord_date"]  		= dateFormat(order.ord_date, 'dd/mm/yyyy');
				strOrd["ord_fty_del_date"]  = !isEmpty(order.ord_fty_del_date) ? dateFormat(order.ord_fty_del_date, 'dd/mm/yyyy') : "None";
				strOrd["ord_zone_del_date"] = !isEmpty(order.ord_zone_del_date) ? dateFormat(order.ord_zone_del_date, 'dd/mm/yyyy') : "None";
				strOrd["ord_ag_del_date"]   = !isEmpty(order.ord_ag_del_date) ? dateFormat(order.ord_ag_del_date, 'dd/mm/yyyy') : "None";
				strOrd["ord_units"]   		= ord_units;
				strOrd["ord_fty_delivered"] = order.ord_fty_delivered;
				strOrd["ord_zone_delivered"] = order.ord_zone_delivered;
				strOrd["ord_ag_delivered"]   = order.ord_ag_delivered;
				strOrd["ord_fty_value"]      = numberService.roundDecimalPlaces(factoryPriceGrand, 2);
				strOrd["ord_zone_value"]     = numberService.roundDecimalPlaces(zonePriceGrand, 2);
				strOrd["ord_ag_value"]       = numberService.roundDecimalPlaces(agentPriceGrand, 2);
				if(isEmpty(order.ord_plf)){
					strOrd["ord_plf"]      		= "";
					strOrd["ord_plz"]      		= "";
				}else{
					strOrd["ord_plf"]      		= order.ord_plf;
					strOrd["ord_plz"]      		= order.ord_plz;
				}				
				strOrd["ord_discount_1"]    = !isEmpty(order.ord_discount_1)?order.ord_discount_1:0;
				strOrd["ord_ag_value_dsc1"]   = numberService.roundDecimalPlaces(strOrd.ord_ag_value * order.ord_discount_1 / 100, 2);
				strOrd["ord_ag_remain_dsc1"]  = numberService.roundDecimalPlaces(strOrd.ord_ag_value - strOrd.ord_ag_value_dsc1, 2);
				strOrd["ord_discount_2"]      = !isEmpty(order.ord_discount_2)?order.ord_discount_2:0;
				strOrd["ord_ag_value_dsc2"]   = numberService.roundDecimalPlaces(strOrd.ord_ag_remain_dsc1 * order.ord_discount_2 / 100, 2);
				strOrd["ord_ag_remain_dsc2"]  = numberService.roundDecimalPlaces(strOrd.ord_ag_remain_dsc1 - strOrd.ord_ag_value_dsc2, 2);

				strOrd["ord_fty_pendent"]  = ord_units - order.ord_fty_delivered;
				strOrd["ord_zone_pendent"] = order.ord_fty_delivered - order.ord_zone_delivered;
				strOrd["ord_ag_pendent"]   = order.ord_zone_delivered - order.ord_ag_delivered;
				strOrd["count_row"]   	   = count;
				arrayAppend(arrOrd, strOrd);
			}else if(userLevel == 2){
				if(!isEmpty(order.ord_ag_del_date)){
					var count = 1;
				}else{
					var count = 0;
				}
				strOrd["fty_confirm"]    = fty_confirm;
				strOrd["zone_confirm"]   = zone_confirm;
				strOrd["id_order"]    = order.id_order;
				strOrd["id_customer"] = order.id_customer;
				strOrd["cs_name"] 	  = order.cs_name;
				strOrd["ag_description"]  = order.ag_description;
				strOrd["ord_description"] = order.ord_description != "" ? order.ord_description : 'No Description';
				strOrd["ot_description"]  = order.ot_description;
				strOrd["oc_description"]  = order.oc_description;
				strOrd["os_description"]  = order_status;
				strOrd["ord_fty_del_date"]  = !isEmpty(order.ord_fty_del_date) ? dateFormat(order.ord_fty_del_date, 'dd/mm/yyyy') : "None";
				strOrd["ord_zone_del_date"] = !isEmpty(order.ord_zone_del_date) ? dateFormat(order.ord_zone_del_date, 'dd/mm/yyyy') : "None";
				strOrd["ord_ag_del_date"]   = !isEmpty(order.ord_ag_del_date) ? dateFormat(order.ord_ag_del_date, 'dd/mm/yyyy') : "None";
				strOrd["ord_units"]   		= ord_units;
				strOrd["ord_fty_delivered"] = order.ord_fty_delivered;
				strOrd["ord_zone_delivered"] = order.ord_zone_delivered;
				strOrd["ord_ag_delivered"]   = order.ord_ag_delivered;
				strOrd["ord_ag_value"]       = numberService.roundDecimalPlaces(agentPriceGrand, 2);
				strOrd["ord_fty_value"]     = numberService.roundDecimalPlaces(factoryPriceGrand, 2);
				if(isEmpty(order.ord_plf)){
					strOrd["ord_plf"]      		= "";
					strOrd["ord_plz"]      		= "";
				}else{
					strOrd["ord_plf"]      		= order.ord_plf;
					strOrd["ord_plz"]      		= order.ord_plz;
				}
				strOrd["ord_ag_value_dsc1"] = numberService.roundDecimalPlaces(agentPriceGrand * order.ord_discount_1 / 100, 2);
				strOrd["ord_ag_remain_dsc1"]  = numberService.roundDecimalPlaces(strOrd.ord_ag_value - strOrd.ord_ag_value_dsc1, 2);
				strOrd["ord_ag_value_dsc2"] = numberService.roundDecimalPlaces(strOrd.ord_ag_remain_dsc1 * order.ord_discount_2 / 100, 2);				
				strOrd["count_row"]   	    = count;
				arrayAppend(arrOrd, strOrd);
			}else if(userLevel == 3){
				if(!isEmpty(order.ord_ag_del_date)){
					var count = 1;
				}else{
					var count = 0;
				}
				strOrd["id_order"]    = order.id_order;
				strOrd["fty_confirm"]    = fty_confirm;
				strOrd["zone_confirm"]   = zone_confirm;
				strOrd["id_customer"] = order.id_customer;
				strOrd["cs_name"] 	  = order.cs_name;	
				strOrd["ord_description"] = order.ord_description != "" ? order.ord_description : 'No Description';
				strOrd["ot_description"]  = order.ot_description;
				strOrd["oc_description"]  = order.oc_description;
				strOrd["os_description"]  = order_status;
				strOrd["ord_zone_del_date"] = !isEmpty(order.ord_zone_del_date) ? dateFormat(order.ord_zone_del_date, 'dd/mm/yyyy') : "None";
				strOrd["ord_ag_del_date"]   = !isEmpty(order.ord_ag_del_date) ? dateFormat(order.ord_ag_del_date, 'dd/mm/yyyy') : "None";
				strOrd["ord_units"]   		= ord_units;
				strOrd["ord_zone_delivered"] = order.ord_zone_delivered;
				strOrd["ord_ag_delivered"]   = order.ord_ag_delivered;
				strOrd["ord_ag_value"]       = numberService.roundDecimalPlaces(agentPriceGrand, 2);
				strOrd["ord_ag_value_dsc1"]  = numberService.roundDecimalPlaces(strOrd.ord_ag_value * order.ord_discount_1 / 100, 2);
				strOrd["ord_ag_remain_dsc1"]  = numberService.roundDecimalPlaces(strOrd.ord_ag_value - strOrd.ord_ag_value_dsc1, 2);
				strOrd["ord_ag_value_dsc2"]  = numberService.roundDecimalPlaces(strOrd.ord_ag_remain_dsc1 * order.ord_discount_2 / 100, 2);
				if(isEmpty(order.ord_plz)){
					strOrd["ord_plz"]      		 = "";
				}else{
					strOrd["ord_plz"]      		 = order.ord_plz;
				}				
				strOrd["count_row"]   	     = count;
				arrayAppend(arrOrd, strOrd);
			} else if(userLevel == 4){
				if(!isEmpty(order.ord_ag_del_date)){
					var count = 1;
				}else{
					var count = 0;
				}
				strOrd["id_order"]    = order.id_order;
				strOrd["fty_confirm"]    = fty_confirm;
				strOrd["zone_confirm"]   = zone_confirm;
				strOrd["id_customer"] = order.id_customer;
				strOrd["cs_name"] 	  = order.cs_name;	
				strOrd["ord_description"] = order.ord_description != "" ? order.ord_description : 'No Description';
				strOrd["ot_description"]  = order.ot_description;
				strOrd["oc_description"]  = order.oc_description;
				strOrd["os_description"]  = order_status;
				strOrd["ord_zone_del_date"] = !isEmpty(order.ord_zone_del_date) ? dateFormat(order.ord_zone_del_date, 'dd/mm/yyyy') : "None";
				strOrd["ord_ag_del_date"]   = !isEmpty(order.ord_ag_del_date) ? dateFormat(order.ord_ag_del_date, 'dd/mm/yyyy') : "None";
				strOrd["ord_units"]   		= ord_units;
				strOrd["ord_zone_delivered"] = order.ord_zone_delivered;
				strOrd["ord_ag_delivered"]   = order.ord_ag_delivered;
				strOrd["ord_ag_value"]       = numberService.roundDecimalPlaces(agentPriceGrand, 2);
				strOrd["ord_ag_value_dsc1"]  = numberService.roundDecimalPlaces(strOrd.ord_ag_value * order.ord_discount_1 / 100, 2);
				strOrd["ord_ag_remain_dsc1"]  = numberService.roundDecimalPlaces(strOrd.ord_ag_value - strOrd.ord_ag_value_dsc1, 2);
				strOrd["ord_ag_value_dsc2"]  = numberService.roundDecimalPlaces(strOrd.ord_ag_remain_dsc1 * order.ord_discount_2 / 100, 2);
				if(isEmpty(order.ord_plz)){
					strOrd["ord_plz"]      		 = "";
				}else{
					strOrd["ord_plz"]      		 = order.ord_plz;
				}
				strOrd["count_row"]   	     = count;
				arrayAppend(arrOrd, strOrd);
			}		
		}
		var thinhResult = {
				"draw": draw,
				"recordsTotal": orders.orders_total,
				"recordsFiltered": orders.orders_total,
				"data": arrOrd
			}
		return thinhResult;
	}
	private function getStatus(string fty_confirm, string zone_confirm){
        var status = "Open";
        if(fty_confirm != "None")
            status = "On production";
        if(fty_confirm == "None" && zone_confirm != "None")
            status = "To Factory";
        return status;
    }
	
	function getOrderInfo(numeric orderId){
		var order = entityLoad("orders", {id_order: orderId}, true);
		var _customer = order.getcustomer();	
		var _agent 	 = isNull(_customer)?JavaCast("null", ""):_customer.getAgent();
		var _zone 	 = isNull(_agent)?JavaCast("null", ""):_agent.getZone();
		var groupProductInfo = getGroupProductInfo(orderId);
		var pricelistZone = productService.getplz_id(_agent.getid_Agent());
		var priceListFactory = entityLoadByPK("price_list_factory", pricelistZone.recordCount ? pricelistZone.id_plf : 0);
		var fty_confirm = !isNull(order.getord_fty_confirm()) ? dateFormat(order.getord_fty_confirm(), "dd/mm/yyyy") : "None";
		var zone_confirm = !isNull(order.getord_zone_confirm()) ? dateFormat(order.getord_zone_confirm(), "dd/mm/yyyy") : "None";
		var status = getStatus(fty_confirm, zone_confirm);
		var sumOfQuantityDetails = sumOfQuantityDetails(orderId);
		var units = sumOfQuantityDetails.sum != "" ? sumOfQuantityDetails.sum : 0;
		if(arrayLen(groupProductInfo)){			
			var product = entityLoadByPK("product", groupProductInfo[1].id_product);
			var factoryPriceGrand = 0;
			var zonePriceGrand    = 0;
			var agentPriceGrand   = 0;
			for(product in groupProductInfo){
				var totalPrice = deserializeJSON(product.ordd_pricelist).total;
				factoryPriceGrand += (product.sum * totalPrice.factory);
				zonePriceGrand 	  += (product.sum * totalPrice.zone);
				agentPriceGrand   += (product.sum * totalPrice.agent);
			}
			var str 	= {};
			var zone 	= {};
			var agent 	= {};
			var customer = {};
			/* deliver factory */
			var deliveryFactory = {};
			var factoryCurrencyCode = !isNull(priceListFactory) ? priceListFactory.getcurrency().getcurr_code() : "";
			deliveryFactory["confirmationDate"] 	= fty_confirm;
			deliveryFactory["deliveryDate"] 		= !isNull(order.getord_fty_del_date()) ? dateFormat(order.getord_fty_del_date(), "dd/mm/yyyy") : "None";
			deliveryFactory["priceList"] 			= !isNull(priceListFactory) ? priceListFactory.getplf_code()&" - "&priceListFactory.getplf_description() : "None";
			deliveryFactory["value"] 				= numberService.roundDecimalPlaces(factoryPriceGrand, 2);
			deliveryFactory["currency"] 			= factoryPriceGrand gt 0 ? ' - '& factoryCurrencyCode : "";
			deliveryFactory["delivered"] 			= order.getord_fty_delivered();
			deliveryFactory["toDeliver"] 			= units - order.getord_fty_delivered();
			/* deliver zone */
			var deliveryZone = {};
			var zoneCurrency = entityLoadByPK("currency", pricelistZone.id_currency);
			var zoneCurrencyCode = !isNull(zoneCurrency) ? zoneCurrency.getcurr_code() : "";
			deliveryZone["confirmationDate"] 	= zone_confirm;
			deliveryZone["deliveryDate"] 		= !isNull(order.getord_zone_del_date()) ? dateFormat(order.getord_zone_del_date(), 'dd/mm/yyyy') : "None";
			deliveryZone["value"] 				= numberService.roundDecimalPlaces(zonePriceGrand, 2);
			deliveryZone["currency"] 			= zonePriceGrand gt 0 ? ' - '& zoneCurrencyCode : "";
			deliveryZone["delivered"] 			= order.getord_zone_delivered();
			deliveryZone["toDeliver"] 			= units - order.getord_zone_delivered();
			/* deliver agent */
			var deliveryAgent = {};
			deliveryAgent["deliveryDate"] 		= !isNull(order.getord_ag_del_date()) ? dateFormat(order.getord_ag_del_date(), 'dd/mm/yyyy') : "None";
			deliveryAgent["priceList"] 			= pricelistZone.recordCount ? pricelistZone.plz_code&" - "& pricelistZone.plz_description : "None";
			deliveryAgent["value"] 				= numberService.roundDecimalPlaces(agentPriceGrand, 2);
			deliveryAgent["delivered"] 			= order.getord_ag_delivered();
			deliveryAgent["toDeliver"] 			= units - order.getord_ag_delivered();
			/* description for all type user */
			zone["description"] 	= _zone.getid_Zone() & " - " &_zone.getz_description();
			agent["description"] 	= _agent.getag_code() & " - " &_agent.getag_description();
			customer["ID"] 			= _customer.getid_Customer();
			customer["description"] = _customer.getid_Customer() & " - " & _customer.getcs_name();
			/* set value to order info */
			var value_discount1  = agentPriceGrand * order.getord_discount_1() / 100;
			var remain_discount1 = agentPriceGrand - value_discount1;
			var value_discount2  = remain_discount1 * order.getord_discount_2() / 100;
			var remain_discount2 = remain_discount1 - value_discount2;
			str["id"] 		= order.getid_order();
			str["discount1"] = order.getord_discount_1();
			str["value_discount1"] = numberService.roundDecimalPlaces(value_discount1, 2);
			str["remain_discount1"] = numberService.roundDecimalPlaces(remain_discount1, 2);	

			str["discount2"] = order.getord_discount_2();
			str["value_discount2"] 	= numberService.roundDecimalPlaces(value_discount2, 2);
			str["remain_discount2"] = numberService.roundDecimalPlaces(remain_discount2, 2);

			str["date"] 	= !isNull(order.getord_date()) ? dateFormat(order.getord_date(),"dd/mm/yyyy") : "None";		
			str["units"] 	= units;
			str["offer"] 	= order.getoffer();
			str["payment"] 	= order.getpayment();
			str["condition"] = order.getorder_condition();
			str["type"] 	 = order.getorder_type();
			str["status"] 	 = status;
			str["description"] = order.getord_description();
			str["zone"] 	= zone;
			str["agent"] 	= agent;
			str["customer"] = customer;
			str["deliveryFactory"] = deliveryFactory;
			str["deliveryZone"]    = deliveryZone;
			str["deliveryAgent"]   = deliveryAgent;
			str["orderDate"]       = !isNull(order.getord_date()) ? dateFormat(order.getord_date(),"dd/mm/yyyy") : "None";
		}else{
			var str 	= {};
			var zone 	= {};
			var agent 	= {};
			var customer = {};
			/* deliver factory */
			var deliveryFactory = {};
			deliveryFactory["confirmationDate"] 	= fty_confirm;
			deliveryFactory["deliveryDate"] 		= !isNull(order.getord_fty_del_date()) ? dateFormat(order.getord_fty_del_date(), "dd/mm/yyyy") : "None";
			deliveryFactory["delivered"] 			= order.getord_fty_delivered();
			deliveryFactory["toDeliver"] 			= units - order.getord_fty_delivered();
			deliveryFactory["priceList"] 			= !isNull(priceListFactory) ? priceListFactory.getplf_code()&" - "&priceListFactory.getplf_description() : "None";
			/* deliver zone */
			var deliveryZone = {};
			deliveryZone["confirmationDate"] 	= zone_confirm;
			deliveryZone["deliveryDate"] 		= !isNull(order.getord_zone_del_date()) ? dateFormat(order.getord_zone_del_date(), 'dd/mm/yyyy') : "None";
			deliveryZone["delivered"] 			= order.getord_zone_delivered();
			deliveryZone["toDeliver"] 			= units - order.getord_zone_delivered();

			/* deliver agent */
			var deliveryAgent = {};
			deliveryAgent["deliveryDate"] 		= !isNull(order.getord_ag_del_date()) ? dateFormat(order.getord_ag_del_date(), 'dd/mm/yyyy') : "None";
			deliveryAgent["delivered"] 			= order.getord_ag_delivered();
			deliveryAgent["toDeliver"] 			= units - order.getord_ag_delivered();
			deliveryAgent["priceList"] 			= pricelistZone.recordCount ? pricelistZone.plz_code&" - "& pricelistZone.plz_description : "None";
			/* description for all type user */
			zone["description"] 	= _zone.getid_Zone() & " - " &_zone.getz_description();
			agent["description"] 	= _agent.getag_code() & " - " &_agent.getag_description();
			customer["ID"] 			= _customer.getid_Customer();
			customer["description"] = _customer.getid_Customer() & " - " & _customer.getcs_name();
			/* set value to order info */			
			str["id"] 		= order.getid_order();
			str["discount1"] = order.getord_discount_1();	
			str["discount2"] = order.getord_discount_2();
			str["date"] 	= !isNull(order.getord_date()) ? dateFormat(order.getord_date(),"dd/mm/yyyy") : "None";		
			str["units"] 	= units;
			str["offer"] 	= order.getoffer();
			str["payment"] 	= order.getpayment();
			str["condition"] = order.getorder_condition();
			str["type"] 	 = order.getorder_type();

			str["status"] 	 = status;
			str["description"] = order.getord_description();
			str["zone"] 	= zone;
			str["agent"] 	= agent;
			str["customer"] = customer;
			str["deliveryFactory"] = deliveryFactory;
			str["deliveryZone"]    = deliveryZone;
			str["deliveryAgent"]   = deliveryAgent;
			str["orderDate"]       = !isNull(order.getord_date()) ? dateFormat(order.getord_date(),"dd/mm/yyyy") : "None";
		}

		return str;
	}


	function getGroupProductID(numeric orderID){
		var result = QueryExecute("SELECT id_product
									FROM order_details
									WHERE id_order = #orderID#
									GROUP BY id_product");
		return result;
	}

	function getOrderDetailGroup(){
		var aSize = [];
		aSize[1] = {'size':'_6XS', 'quantity' : 0};
		aSize[2] = {'size':'_5XS', 'quantity' : 0};
		aSize[3] = {'size':'_4XS', 'quantity' : 0};
		aSize[4] = {'size':'_3XS', 'quantity' : 0};
		aSize[5] = {'size':'_XXS', 'quantity' : 0};
		aSize[6] = {'size':'_XS', 'quantity' : 0};
		aSize[7] = {'size':'_S', 'quantity' : 0};
		aSize[8] = {'size':'_M', 'quantity' : 0};
		aSize[9] = {'size':'_L', 'quantity' : 0};
		aSize[10] = {'size':'_XL', 'quantity' : 0};
		aSize[11] = {'size':'_XXL', 'quantity' : 0};
		aSize[12] = {'size':'_3XL', 'quantity' : 0};
		aSize[13] = {'size':'_4XL', 'quantity' : 0};
		aSize[14] = {'size':'_5XL', 'quantity' : 0};
		aSize[15] = {'size':'_6XL', 'quantity' : 0};

		return aSize;
	}

	function getOrderDetailsLineView(numeric orderId) {
		var order = entityLoad("orders", {id_order: orderId}, true);		
		var orderDetails = entityLoad("order_details", {order: order});
		var arrDets = [];
		var userLevel = userService.getUserLevel();
		if(arrayLen(orderDetails)){
			for(det in orderDetails) {
				if(det.getordd_qtty() > 0){
					var priceList = deserializeJSON(det.getordd_pricelist());
					var project   = det.getproduct().getProject();
					var product   = det.getproduct();
					var pattern   = product.getpattern();
					var pattern_variantion   = det.getproduct().getpattern_variantion();
					var str = {};
					str["group"] 	 = det.getordd_cg_name();
					str["fty_confirm"] 	 = !isNull(order.getord_fty_confirm()) ? dateFormat(order.getord_fty_confirm(), "dd/mm/yyyy") : "None";					
					str["zone_confirm"]	 = !isNull(order.getord_zone_confirm()) ? dateFormat(order.getord_zone_confirm(), "dd/mm/yyyy") : "None";					
					str["userLevel"] = userLevel;
					str["id_order"]  = orderId;
					str["id_order_detail"] = det.getid_order_det();
					str["is_size_custom"]  = det.getordd_size_custom();
					str["id_product"]      = det.getproduct().getid_product();
					str["priceList"]       = det.getordd_pricelist();
					str["garment"] = det.getproduct().getproject().getid_project() & "-" & det.getproduct().getpattern().getid_pattern() & "-" & det.getproduct().getpattern_variantion().getid_pattern_var();
					str["pr_version"] = det.getproduct().getpr_version();
					str["prodid"] 	  = det.getproduct().getid_product();
					str["cost_code"]  = det.getproduct().getcosting().getcost_code();
					str["cv_version"] = det.getproduct().getcosting_versions().getcv_version();
					str["pr_description"] = det.getproduct().getpr_description();
					str["sz_description"] = det.getproduct().getsize().getsz_description();
					str["ordd_cg_name"]   = det.getordd_cg_name();
					str["ordd_name"] 	 = isNull(det.getordd_name())?"-":det.getordd_name();
					str["ordd_number"]   = isNull(det.getordd_number())?"-":det.getordd_number();
					str["ordd_size"] 	 = det.getsize_details().getszd_size();
					str["ordd_quantity"] = det.getordd_qtty();
					//will get from deliver
					str["ordd_del_fty"]  = 1;
					str["ordd_del_zone"] = 1;
					str["ordd_del_ag"] 	 = 1;
					//end
					if(isNull(order.getprice_list_factory())){
						str["ord_plf_currency"] = "";
						str["ord_plz_currency"] = "";
						str["ord_plf"] = "";
						str["ord_plz"] = "";
					}else{
						var curr_code_fac = order.getprice_list_factory().getcurrency().getcurr_code();
						var curr_code_zone = order.getprice_list_zone().getcurrency().getcurr_code();
						str["ord_plf_currency"] = curr_code_fac;
						str["ord_plz_currency"] = curr_code_zone;
						str["ord_plf"] = curr_code_fac; 
						str["ord_plz"] = curr_code_zone;
					}
					
					str["prd_description"]  = det.getproduct().getpr_description();
					str["prd_version"]  	= det.getproduct().getpr_version();
					str["pj_display"]  		= project.getId_display();
					str["pattern_code"]  	= isNull(pattern)?"":pattern.getpt_code();
					str["patt_vari_code"]  	= isNull(pattern_variantion)?"":pattern_variantion.getpv_code();

					str["plfd_fty_sell_3"] = numberService.roundDecimalPlaces(det.getproduct().getprice_list_zone_detail().getprice_list_factory_detail().getplfd_fty_sell_3(),2);
					str["plzd_zone_sell_6"] = numberService.roundDecimalPlaces(det.getproduct().getprice_list_zone_detail().getplzd_Zone_Sell_6(),2);
					str["plzd_pvpr_8"] = numberService.roundDecimalPlaces(det.getproduct().getprice_list_zone_detail().getplzd_PVPR_8(),2);
					str["pr_fty_sell_9"] = numberService.roundDecimalPlaces(det.getproduct().getpr_fty_sell_9(),2);
					str["pr_zone_sell_10"] = numberService.roundDecimalPlaces(det.getproduct().getpr_zone_sell_10(),2);
					str["pr_pvpr_11"] = numberService.roundDecimalPlaces(det.getproduct().getpr_PVPR_11(),2);					
					if(userLevel == 1 or userLevel == 2){
						str["price_factory"] = priceList.total.factory;
					}
					if(userLevel != 4){
						str["price_zone"]	 = priceList.total.zone;
					}					
					str["price_agent"]   = priceList.total.agent;
					var ordd_fty_tot  = priceList.total.factory * str.ordd_quantity;
					var ordd_zone_tot = priceList.total.zone  * str.ordd_quantity;
					var ordd_ag_tot	 = priceList.total.agent  * str.ordd_quantity;
					str["ordd_fty_tot"] = numberService.roundDecimalPlaces(ordd_fty_tot,2);
					str["ordd_zone_tot"] =  numberService.roundDecimalPlaces(ordd_zone_tot,2);
					str["ordd_ag_tot"] =  numberService.roundDecimalPlaces(ordd_ag_tot,2);				
					 

					// str["ordd_rcv_zone"] = isnull(det.getordd_rcv_zone()) ? 0 : det.getordd_rcv_zone();
					// str["ordd_rcv_ag"] = isnull(det.getordd_rcv_ag()) ? 0 : det.getordd_rcv_ag();
					// str["ordd_rcv_cs"] = isnull(det.getordd_rcv_cs()) ? 0 : det.getordd_rcv_cs();
					// str["ordd_rcv_pr"] = isnull(det.getordd_rcv_pr()) ? 0 : det.getordd_rcv_pr();
					arrayAppend(arrDets, str);
				}
			}
		}
		return arrDets;
	}
	function getGroupProductIDSize(numeric orderID){
		var result = QueryExecute("SELECT id_product, ordd_pricelist, ordd_cg_name, ordd_size_custom
									FROM order_details
									WHERE id_order = #orderID#
									GROUP BY id_product, ordd_pricelist, ordd_cg_name, ordd_size_custom");
		return result;
	}
	private function sumOfQuantityDetails(orderID){
		var result = QueryExecute("
				select sum(ordd_qtty) sum
				from order_details
				where id_order = #orderID#
			");
		return result;
	}
	private function unitSizeView(numeric orderID, string priceList, string group, numeric size_custom){
		var result = QueryExecute("
				select sum(ordd_qtty) sum, ordd_pricelist, ordd_size_custom
				from order_details
				where id_order = #orderID# and ordd_pricelist = '#priceList#' and ordd_cg_name = '#group#' and ordd_size_custom = '#size_custom#'
			");
		return result;
	}

	function getOrderDetails_SizeView(numeric orderId) {
		var userLevel = userService.getUserLevel();
		var order = entityLoad("orders", {id_order: orderId}, true);
		var fty_confirm 		= !isNull(order.getord_fty_confirm()) ? dateFormat(order.getord_fty_confirm(), "dd/mm/yyyy") : "None";
		var zone_confirm 		= !isNull(order.getord_zone_confirm()) ? dateFormat(order.getord_zone_confirm(), "dd/mm/yyyy") : "None";		
		var qGroupProductID = getGroupProductIDSize(order.getid_order());
		var arrDets = [];		
		var str = {};
		var count = 0;
		for(productID in qGroupProductID){			
			var aListSize =  getOrderDetailGroup();	
			var orderDetails = entityLoad("order_details", {order: order, product = entityLoadByPK("product", productID.id_product), ordd_pricelist: productID.ordd_pricelist, ordd_cg_name: productID.ordd_cg_name, ordd_size_custom: productID.ordd_size_custom});	
			var priceList = deserializeJSON(orderDetails[1].getordd_pricelist());
			var size_custom = orderDetails[1].getordd_size_custom();
			var strSize = {};
			for(det in orderDetails){	
				var units = unitSizeView(orderId, det.getordd_pricelist(), productID.ordd_cg_name, productID.ordd_size_custom);				
				var project   = det.getproduct().getProject();	
				var type_size = "_" & det.getsize_details().getszd_size();
				var arrayIndex 	= ArrayFind(aListSize, function(struct){ 
					return struct.size == "#type_size#"; 
				});
				if(arrayIndex){
					aListSize[arrayIndex].quantity += det.getordd_qtty();
				}
				for(itemSize in aListSize){
					var str = {};
					str["#itemSize.size#"] = itemSize.quantity;
					structAppend(strSize, str);
				}
				strSize["pj_display"]  		= project.getId_display();							
				strSize["id_order_det"]  	= det.getid_order_det();							
				strSize["ordd_cg_name"]  	= det.getordd_cg_name() != "" ? det.getordd_cg_name() : "-";
				if(det.getproduct().getpr_sketch() != ""){
					strSize["prd_sketch"]  		= det.getproduct().getpr_sketch();	
				}else{
					strSize["prd_sketch"]  		= "";
				}									
				strSize["pattern_code"]  	= det.getproduct().getpattern_variantion().getpattern().getpt_code();							
				strSize["patt_vari_code"]  	= det.getproduct().getpattern_variantion().getid_pattern_var();							
				strSize["prd_version"]  	= det.getproduct().getpr_version();							
				strSize["prd_description"]  = det.getproduct().getpr_description();							
				strSize["cost_code"]  		= det.getproduct().getcosting().getcost_code();							
				strSize["cv_version"]  		= det.getproduct().getcosting_versions().getcv_version();							
				strSize["sz_description"]  	= entityLoadByPK("sizes", det.getsize_details().getsize().getid_size()).getsz_description();
				strSize["ordd_units"] 		= units.sum;
				strSize["ordd_fty_tot"]  	= numberService.roundDecimalPlaces(priceList.total.factory * units.sum, 2);
				strSize["ordd_zone_tot"] 	= numberService.roundDecimalPlaces(priceList.total.zone * units.sum, 2);
				strSize["ordd_ag_tot"]   	= numberService.roundDecimalPlaces(priceList.total.agent * units.sum, 2);											
			}
			strSize["price_factory"]  	= numberService.roundDecimalPlaces(priceList.total.factory, 2);
			strSize["price_zone"]  	    = numberService.roundDecimalPlaces(priceList.total.zone, 2);
			strSize["price_agent"]  	= numberService.roundDecimalPlaces(priceList.total.agent, 2);
			strSize["id_order"]   		= orderId;
			strSize["id_product"] 		= productID.id_product;			
			strSize["ord_plf_currency"] = order.getprice_list_factory().getcurrency().getcurr_code();
			strSize["ord_plz_currency"] = order.getprice_list_zone().getcurrency().getcurr_code();
			strSize["fty_confirm"] 		= fty_confirm;
			strSize["zone_confirm"] 	= zone_confirm;
			strSize["price_List"] 		= priceList;
			strSize["priceList"] 		= orderDetails[1].getordd_pricelist();
			strSize["name_number"] 		= size_custom == true ? "Yes" : "No";
			strSize["group"] 			= productID.ordd_cg_name != "" ? productID.ordd_cg_name : "-";
			strSize["is_size_custom"] 	= productID.ordd_size_custom;
			arrayAppend(arrDets,strSize);
		}	
		return arrDets;
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

   	function deleteProduct(numeric id_order_detail){
   		var result = true;
   		var order_details = entityLoadByPK("order_details", id_order_detail);
   		if(!isNull(order_details)){
   			try{
   				orderDetailsService.delete(order_details, true);
   			}catch(any ex) {
   				result = false;
   			}
   		}else{
   			result = false;
   		}
   		return result;
   	}

   	function deleteProductSizeView(numeric id_order, numeric id_product, string priceList, string group_name, boolean size_custom){
   		var result = true;
   		var order_details = entityLoad("order_details", {order: entityLoadByPK("orders", id_order) , product: entityLoadByPK("product", id_product), ordd_pricelist: priceList, ordd_cg_name: group_name, ordd_size_custom: size_custom});
   		var quantity = 0;
   		if(arrayLen(order_details)){
   			try{
   				for(item in order_details){
   					orderDetailsService.delete(item, true);
   				}
   			}catch(any ex) {
   				result = false;
   			}
   		}else{
   			result = false;
   		}
   		return result;
   	}

   	function deleteOrder(numeric id_order){
   		var result = true;
   		try {
   			QueryExecute("
   				delete from orders where id_order = #id_order#
   			");
   		}
   		catch(any ex) {
   			var result = false;
   		}
   		return result;
   		
   	}

   	private function getSizeDetails(numeric id_size){
   		var result = queryToArray(QueryExecute("
   				select s.id_size, sd.id_size_det, sd.szd_position, sd.szd_size
   				from sizes_details sd
   				 inner join sizes s
   				 	on s.id_size = sd.id_size
   				where s.id_size = #id_size#
   				order by sd.szd_position asc
   			"));
   		var str = {"name": "", "number": "", "quantity": 0};
   		for(item in result){   			
   			structAppend(item, str);
   		}
   		return result;
   	}

   	private function sumOfQuantityDetailsPriceList(numeric orderID, string priceList){
		var result = QueryExecute("
				select sum(ordd_qtty) sum
				from order_details
				where id_order = #orderID# and ordd_pricelist = '#priceList#'
			");
		return result;
	}

   	function getProductDetail(numeric id_order, numeric product_id, string priceList, string group, numeric size_custom){
   		var strProductDetail	= {};
   		var order 				= entityLoad("orders", id_order, true);
   		var order_customer		= order.getcustomer();
   		var agent 				= entityLoadByPK("agent", order_customer.getagent().getid_Agent());
		var price_list_factory	= order.getprice_list_factory();
		var price_list_zone		= order.getprice_list_zone();
		var order_type			= order.getorder_type();
		var order_condition		= order.getorder_condition();
		var fty_confirm 		= !isNull(order.getord_fty_confirm()) ? dateFormat(order.getord_fty_confirm(), "dd/mm/yyyy") : "None";
		var zone_confirm 		= !isNull(order.getord_zone_confirm()) ? dateFormat(order.getord_zone_confirm(), "dd/mm/yyyy") : "None";
		var order_status 		= getStatus(fty_confirm, zone_confirm);
		var order_payment		= order.getpayment();
		var order_product		= entityLoadByPK("product", product_id);
		var size_details 		= getSizeDetails(order_product.getsize().getid_size());
		var project             = order_product.getProject();
		var projectDetail 		= projectService.getProjectDetail(project.getid_Project());
		var order_details 		= entityLoad("order_details", {order : order, product: order_product, ordd_pricelist: Trim(priceList), ordd_cg_name: group, ordd_size_custom: size_custom});
		strProductDetail["agent"]			= {"description": agent.getag_code()&" - "& agent.getag_description()};
   		strProductDetail["condition"] 		= {"id_order_condition" : order_condition.getid_order_condition(), "oc_description" : order_condition.getoc_description()};   		
   		strProductDetail["customer"] 		= {"description": order_customer.getid_Customer()&" - "&order_customer.getcs_name(), "ID": order_customer.getid_Customer()};
   		strProductDetail["date"] 			= dateFormat(order.getord_date(), 'dd/mm/yyyy');
   		strProductDetail["deliveryAgent"] 	= {
			   									"delivered": "",
			   									"deliveryDate": "",
			   									"priceList": "",
			   									"toDeliver": ""
			   								  };
   		strProductDetail["deliveryFactory"] = {
			   									"confirmationDate": "",
			   									"delivered": "",
			   									"deliveryDate": "",
			   									"priceList": "",
			   									"toDeliver": ""
			   								  };
   		strProductDetail["deliveryZone"] 	= {
			   									"confirmationDate": "",
			   									"delivered": "",
			   									"deliveryDate": "",
			   									"toDeliver": ""
			   								  };
   		strProductDetail["id"] 				= order.getid_order();
   		strProductDetail["description"] 	= order.getord_description();
   		strProductDetail["discount1"] 		= order.getord_discount_1();
   		strProductDetail["discount2"] 		= order.getord_discount_2();
   		strProductDetail["offer"] 			= order.getoffer();
   		strProductDetail["payment"] 		= {
			   									"id_payment": order_payment.getid_payment(),
			   									"pay_30_days": "",
			   									"pay_60_days": "",
			   									"pay_code": order_payment.getpay_code(),
			   									"pay_day": "",
			   									"pay_delivery": "",
			   									"pay_description": "",
			   									"pay_dp": "",
			   									"pay_other": "",
			   								  };
   		var firstProduct 					= order_details[1];
   		strProductDetail["group"] 			= group;
   		var product 			= {};
   		var sizeDetail 			= [];
   		product["agent"]		= order_customer.getagent().getid_Agent();
   		product["club12"]		= order_product.getpr_Club_12();
   		product["cost_code"]	= order_product.getcosting().getcost_code();
   		product["cost_code_vers"]	= order_product.getcosting_versions().getcv_version();
   		product["customer"]		= order_customer.getcs_name();
   		product["description"]	= order_product.getpr_description();
   		product["garmentCode"]	= project.getId_display()&"-"&(isNull(order_product.getPattern())?"":order_product.getPattern().getpt_code())&"-"&(isNull(order_product.getPattern_variantion())?"":order_product.getPattern_variantion().getpv_code());
   		product["idProduct"]	= order_product.getid_product();
   		product["picture"]		= order_product.getpr_picture();
   		product["price"]		= deserializeJSON(priceList);
   		product["section"]		= order_product.getpr_section();
   		var strOrderDetailsItems 			= [];
   		for(productItem in order_details){
   			var arrayIndex 	= ArrayFind(size_details, function(struct){ 
				return struct.id_size_det == "#productItem.getsize_details().getid_size_det()#"; 
			});
			if(arrayIndex){
				var orderDetailsItems = {
										'id_order_det': productItem.getid_order_det(),
										'id_size': productItem.getsize_details().getsize().getid_size(),
										 'number' : productItem.getordd_number() != "" ? productItem.getordd_number(): "",
										 'szd_position' : productItem.getsize_details().getszd_position(),
										 'id_size_det' : productItem.getsize_details().getid_size_det(),
										 'name' : productItem.getordd_name() != "" ? productItem.getordd_name(): "",
										 'quantity' : productItem.getordd_qtty() != "" ? productItem.getordd_qtty(): "",
										 'szd_size' : productItem.getsize_details().getszd_size()
										};
				arrayAppend(strOrderDetailsItems, orderDetailsItems);
				size_details[arrayIndex].quantity += productItem.getordd_qtty();
				if(productItem.getordd_size_custom() == true){
					size_details[arrayIndex].name 	  = productItem.getordd_name();
					size_details[arrayIndex].number   = productItem.getordd_number();
				}

			}
   		}
   		product["sizesDetail"] 	= size_details;
   		product["sketch"] 		= order_product.getpr_sketch();   		
   		product["version"] 		= order_product.getpr_version();
   		product["web_13"] 		= order_product.getpr_Web_13();
   		product["zone"] 		= agent.getzone().getid_zone();
   		strProductDetail["project"] 			= projectDetail;
   		strProductDetail["orderItems"] 			= strOrderDetailsItems;
		
   		strProductDetail["product"] 			= product;
   		strProductDetail["sizeType"] 			= firstProduct.getordd_size_custom();
   		strProductDetail["status"] 				= order_status;
   		strProductDetail["type"] 				= {"id_order_type": order_type.getid_order_type(), "ot_description": order_type.getot_description()};
   		strProductDetail["units"] 				= sumOfQuantityDetailsPriceList(id_order, Trim(priceList)).sum;
   		strProductDetail["zone"] 				= {"description": agent.getzone().getid_zone() &" - "& agent.getzone().getz_code()};

   		return strProductDetail;
   	}

}