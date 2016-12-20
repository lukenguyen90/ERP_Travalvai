component output="false" displayname=""  {

	property name='userService' 			inject='userService';

	public function init(){
		return this;
	}

	public function getSizes(event, rc, prc) {
		var usertype = userService.getUserLevel();
		if((usertype eq 1))
		{
			var arrSizes     = [];
			var sizes  = EntityLoad('sizes',{}, "id_size desc");
			for(item in sizes) {
			   var size         = {};
			   size.idsize          = item.getid_size();
			   size.qtty        = item.getsz_qtty();
			   size.des         = item.getsz_description();

			   ArrayAppend(arrSizes,size);
			}
			event.renderData(type="json",data=arrSizes);
		}
		else {
			event.renderData(type="json",data=[]);
		}
	}

	public any function getSizeById(event, rc, prc) {
		try {
			var strsize = {};
			var size  = EntityLoad('sizes',{id_size: rc.idsize}, true);
		   	strsize.idsize      = size.getid_size();
		   	strsize.qtty        = size.getsz_qtty();
		   	strsize.des         = size.getsz_description();
			event.renderData(type="json",data= {"success": true,"size": strsize});
		}
		catch(any ex) {
			event.renderData(type="json",data= {"success": false,"message": "Selected size does not exist !"});
		} 
	}

	public any function insertData(event, rc, prc) {
		transaction {
			try {
				if(rc.idsize == 0) {
					var size = entityNew("sizes");
					var checkSize = entityLoad("sizes", {sz_description: rc.des});
					if(arraylen(checkSize) > 0) {
						event.renderData(type="json",data= {"success": false,"message": "Size has already exist !"});
					}
				}
				else {
					var size = entityLoad("sizes", {id_size: rc.idsize}, true);
				}
			   	size.setsz_qtty(rc.qtty);
			   	size.setsz_description(rc.des);
			   	size.setcreated(now());
			   	size.setupdated(now());
			   	size.setuser_created(userService.getLoggedInUser());
			   	size.setuser_updated(userService.getLoggedInUser());
			   	entitySave(size);

			   	if(rc.idsize == 0) {
				   	for(var i = 1; i <= rc.qtty; i++) {
				   		var sd = entityNew("sizes_details");
				   		sd.setszd_position(i);
				   		sd.setsize(size);
				   		entitySave(sd);
				   	}
				}
				else {
					var details = entityLoad("sizes_details", {size: size}, "id_size_det desc");
					var details_qty = arrayLen(details);
					if( details_qty != size.getsz_qtty()) {
						if(details_qty < size.getsz_qtty()) {
							var diff = size.getsz_qtty() - details_qty;
							for(var i = 1; i <= diff; i++) {
						   		var sd = entityNew("sizes_details");
						   		sd.setszd_position(i + details_qty);
						   		sd.setsize(size);
						   		entitySave(sd);
						   	}
						}
						else {
							var diff = details_qty - size.getsz_qtty();
							for(var j = 1; j <= diff; j++) {
								entityDelete(details[j]);
							}
						}
					}
				}

			   	transactioncommit();
				event.renderData(type="json",data= {"success": true,"message": "Size save successfully !", "idsize": size.getid_size()});
			}
			catch(any ex) {
				transactionrollback();
				event.renderData(type="json",data= {"success": false,"message": "Size save failed !"});
			} 
		}
	}
 
	public any function deleteDataById(event, rc, prc) {
		transaction {
			try {
				var size = entityLoad("sizes", {id_size: rc.idsize}, true);

				var product = entityLoad("product", {size: size});
				if(arrayLen(product) > 0) {
					return event.renderData(type="json",data= {"success": false,"message": "Size in use. Can not delete!"});
				}

				var size_dets = entityLoad("sizes_details", {size: size});
				for(item in size_dets) {
					entityDelete(item);
				}
			   	entityDelete(size);
			   	transactioncommit();
				return event.renderData(type="json",data= {"success": true,"message": "Size delete successfully !"});
			}
			catch(any ex) {
				transactionrollback();
				return event.renderData(type="json",data= {"success": false,"message": "Size delete failed !"});
			} 
		}
	}

	public any function getSizeDetailBySizeId(event, rc, prc) {
		try {
			var arrSizeDet = [];
			var size_dets  = EntityLoad('sizes_details',{size: entityLoad("sizes", {id_size:rc.idsize}, true)});
			for(item in size_dets) {
				var strsize_det = {};
				strsize_det.idsizedet      = item.getid_size_det();
				strsize_det.idsize      = rc.idsize;
			   	strsize_det.size        = item.getszd_size();
			   	strsize_det.position    = item.getszd_position();
			   	arrayAppend(arrSizeDet, strsize_det);
			}
		   	
			event.renderData(type="json",data= arrSizeDet);
		}
		catch(any ex) {
			event.renderData(type="json",data= {"success": false,"message": "Can not get size detail !"});
		} 
	}
	public any function updateSizeDetails(event, rc, prc) {
		transaction {
			try {
				for(item in deserializeJSON(rc.arrData)) {
					var sizeDet = entityLoad("sizes_details", {id_size_det: item.idsizedet}, true);
					sizeDet.setszd_size(isnull(item.size) ? "" : item.size);
					entitySave(sizeDet);
				}
			   	transactioncommit();
				return event.renderData(type="json",data= {"success": true,"message": "Size detail update successfully !"});
			}
			catch(any ex) {
				transactionrollback();
				return event.renderData(type="json",data= {"success": false,"message": "Size detail update failed !"});
			} 
		}
	}
}