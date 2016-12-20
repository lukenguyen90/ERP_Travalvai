component persistent="true" {
	property name="id_shipment_det" fieldtype="id" generator="native" setter="false";
	property name="shd_qtty_fty"				ormtype="number";
	property name="shd_qtty_zone"				ormtype="number";
	property name="shd_qtty_ag"					ormtype="number";
	property name="shd_qtty_rcv_zone"			ormtype="number";
	property name="shd_qtty_rcv_ag"				ormtype="number";
	property name="shd_qtty_rcv_cs"				ormtype="number";
	property name="shd_qtty_rcv_pt"				ormtype="number";

	
	property name="shipment" 			fieldtype="many-to-one" cfc="shipment" 	 			fkcolumn="id_shipment";
	property name="order_details" 		fieldtype="many-to-one" cfc="orders" 	 			fkcolumn="id_order_det";
	property name="box" 				fieldtype="many-to-one" cfc="box" 	 				fkcolumn="id_box";
}