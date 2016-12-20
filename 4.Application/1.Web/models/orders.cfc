component persistent="true" {
	property name="id_order" 			fieldtype="id" generator="native" setter="false";
	property name="ord_date" 			ormtype="timestamp";
	property name="ord_description" 	ormtype="text";
	property name="offer" 				ormtype="text";
	property name="ord_fty_del_date" 	ormtype="timestamp";
	property name="ord_fty_delivered" 	ormtype="double" default=0;
	property name="ord_fty_value" 		ormtype="double" default=0;
	property name="ord_fty_confirm" 	ormtype="timestamp";
	property name="ord_zone_del_date" 	ormtype="timestamp";
	property name="ord_zone_delivered" 	ormtype="double" default=0;
	property name="ord_zone_value" 		ormtype="double" default=0;
	property name="ord_zone_confirm" 	ormtype="timestamp";
	property name="ord_ag_del_date" 	ormtype="timestamp";
	property name="ord_ag_commission" 	ormtype="integer" default=0;
	property name="ord_discount_1" 		ormtype="double" default=0;
	property name="ord_discount_2" 		ormtype="double" default=0;
	property name="ord_ag_delivered" 	ormtype="double" default=0;
	property name="ord_ag_value" 		ormtype="double" default=0;
	property name="ord_ag_value_dsc1" 	ormtype="double" default=0;
	property name="ord_ag_value_dsc2" 	ormtype="double" default=0;
	property name="customer" 			fieldtype="many-to-one"   	cfc="customer" 	 					fkcolumn="id_customer";
	property name="price_list_factory" 	fieldtype="many-to-one" 	cfc="price_list_factory" 			fkcolumn="ord_plf";
	property name="price_list_zone"    	fieldtype="many-to-one"  	cfc="price_list_zone"           	fkcolumn="ord_plz";
	property name="order_type"    		fieldtype="many-to-one"  	cfc="order_type"           			fkcolumn="id_order_type";
	property name="order_condition"   	fieldtype="many-to-one"  	cfc="order_condition"           	fkcolumn="id_order_condition";
	property name="payment"    			fieldtype="many-to-one"  	cfc="payment"           			fkcolumn="id_payment";
}