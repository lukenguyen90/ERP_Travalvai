component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 					inject='userService';
	property name='numberService' 					inject='numberHelper';
	property name='price_list_zone_detailsService' inject='entityService:price_list_zone_details';
	/**
	* Constructor
	*/
	function init(){

		// init super class
		super.init( entityName="price_list_zone_details" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.price_list_zone_details" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}

	public function checkPLFExitInPLZDetail(any idplfd){
		var exist = false;
		var check = QueryExecute("
				select id_plf_det
				from price_list_zone_details
				where id_plf_det = #idplfd#
			");

		if(check.recordcount > 0){
			exist = true;
		}
		return exist;
	}

	public function PLF_Exist_In_PLZF(any idplfd){
		var result = QueryExecute("select plz_code from price_list_zone where id_plz in (select id_plz from price_list_zone_details where id_plf_det = #idplfd#)");
		return result;
	}

	public function updatePriceListZoneDetail(any plzd){
		var plfd = plzd.getPrice_list_factory_detail();
		var plz = plzd.getPrice_list_zone();
		var costing_version = plfd.getCosting_version();
		var plzcc_value = plz.getPlz_ex_rate();
		plzd.setplzd_Weight(costing_version.getcv_weight());
		var plzd_freight = val(numberService.roundDecimalPlaces(costing_version.getcv_weight() * plz.getPlz_freight()/1000,2));
		var plfd_fty_sell_3  = isNull(plfd)?0:plfd.getPlfd_fty_sell_3();

		var plzd_fty_sell_4 = val(numberService.roundDecimalPlaces(plfd_fty_sell_3/plzcc_value,2));
		var plzd_taxes = val(numberService.roundDecimalPlaces((plzd_fty_sell_4 + plzd_freight)*plz.getplz_taxes()/100,2));
		var plzd_margin = val(numberService.roundDecimalPlaces((plzd_fty_sell_4 + plzd_freight + plzd_taxes)*plz.getplz_margin()/100,2));
		var plzd_zone_sell_5 = val(numberService.roundDecimalPlaces(plzd_fty_sell_4 + plzd_freight + plzd_taxes + plzd_margin,2));
		var plzd_zone_sell_6 = plzd.getPlzd_zone_sell_6();
		var plzd_margin_1 = val(numberService.roundDecimalPlaces((plzd_zone_sell_6 - plzd_fty_sell_4 - plzd_freight - plzd_taxes)*100/(plzd_fty_sell_4 + plzd_freight + plzd_taxes),2));
		var plzd_pvpr_7 = val(numberService.roundDecimalPlaces(plzd_zone_sell_6*100/(100 - plz.getplz_commission()),2));
		var plzd_pvpr_8 = plzd.getPlzd_pvpr_8();
		var plzd_margin_2 = val(numberService.roundDecimalPlaces((plzd_pvpr_8 - plzd_zone_sell_6)*100/plzd_pvpr_8,2));

		plzd.SetPlzd_freight(plzd_freight);
		plzd.setPlzd_fty_sell_4(plzd_fty_sell_4);
		plzd.setPlzd_taxes(plzd_taxes);
		plzd.setplzd_Margin(plzd_margin);
		plzd.setPlzd_zone_sell_5(plzd_zone_sell_5);
		plzd.setplzd_Margin_1(plzd_margin_1);
		plzd.setPlzd_pvpr_7(plzd_pvpr_7);
		plzd.setPlzd_margin_2(plzd_margin_2);
		price_list_zone_detailsService.save(plzd);
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