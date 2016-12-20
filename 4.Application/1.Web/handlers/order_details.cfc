component output="false" displayname=""  {
	property name='userService' 			inject='userService';
	property name='zoneService' 			inject='zoneService';
	property name='agentService' 			inject='agentService';
	property name='customerService' 		inject='customerService';
	property name='paymentService' 			inject='paymentService';
	property name='orderConditionService' 	inject='order_conditionService';
	property name='orderTypeService' 		inject='order_typeService';
	property name='orderStatusService' 		inject='order_statusService';
	property name='productService' 			inject='productService';
	property name='projectService' 			inject='projectService';
	property name='orderService' 			inject='orderService';
	property name='orderDetailsService' 	inject='order_detailsService';
	property name='sizesService' 			inject="sizesService";
	property name='sizesDetailsService' 	inject="entityService:sizes_details";

	function getOrderDetailsLineView(event,prc,rc){
		var rs = {};
		rs = orderDetailsService.getOrderDetailsLineView(72);
		event.renderData(type = "json", data = rs);
	}

	function getOrderDetails_SizeView(event,prc,rc){
		var rs = {};
		rs = orderDetailsService.getOrderDetails_SizeView(72);
		event.renderData(type = "json", data = rs);
	}









}