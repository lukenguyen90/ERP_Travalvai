/**
* A ColdBox Enabled virtual entity service
*/
component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';
	property name='numberService' 			inject='numberHelper';
	/**
	* Constructor
	*/
	function init(){
	    // init super class
		super.init( entityName="orders" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.orders" );
	    // EventHandling
	    setEventHandling( true );
	    return this;
	}

	function getOrders() {
		var orders = entityLoad("orders");
		var arrOrders = [];
		var userLevel = userService.getUserLevel();
		for(ord in orders) {
			var zoneId = isnull(ord.getcustomer()) ? "" : isnull(ord.getcustomer().getzone()) ? "" : ord.getcustomer().getzone().getid_zone();
			var agentId = isnull(ord.getcustomer()) ? "" : isnull(ord.getcustomer().getagent()) ? "" : ord.getcustomer().getagent().getid_agent();
			if(userLevel == 1) {
				arrOrders = createListOrders(arrOrders, ord, userLevel);
			}
			else if(userLevel == 2) {
				if(zoneId == ord.getcustomer().getzone().getid_zone()) {
					arrOrders = createListOrders(arrOrders, ord, userLevel);
				}
			}
			else if(userLevel == 3) {
				if(zoneId == ord.getcustomer().getzone().getid_zone() && agentId == ord.getcustomer().getagent().getid_agent()) {
					arrOrders = createListOrders(arrOrders, ord, userLevel);
				}
			}
		}
		return arrOrders;
	}
	

	function getOrderById(string Id) {
		var orders = entityLoad("orders", {id_order: Id});
		var arrOrders = [];
		var userLevel = userService.getUserLevel();
		for(ord in orders) {
			var zoneId = isnull(ord.getcustomer()) ? "" : isnull(ord.getcustomer().getzone()) ? "" : ord.getcustomer().getzone().getid_zone();
			var agentId = isnull(ord.getcustomer()) ? "" : isnull(ord.getcustomer().getagent()) ? "" : ord.getcustomer().getagent().getid_agent();
			if(userLevel == 1) {
				arrOrders = createListOrders(arrOrders, ord, userLevel);
			}
			else if(userLevel == 2) {
				if(zoneId == ord.getcustomer().getzone().getid_zone()) {
					arrOrders = createListOrders(arrOrders, ord, userLevel);
				}
			}
			else if(userLevel == 3) {
				if(zoneId == ord.getcustomer().getzone().getid_zone() && agentId == ord.getcustomer().getagent().getid_agent()) {
					arrOrders = createListOrders(arrOrders, ord, userLevel);
				}
			}
		}
		return arrOrders[1];	
	}

}
