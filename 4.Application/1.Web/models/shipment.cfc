component persistent="true" {
	property name="id_shipment" fieldtype="id" generator="native" setter="false";
	property name="sh_incoterm" 			ormtype="string";
	property name="sh_send" 				ormtype="string";
	property name="sh_send_id"   			ormtype="number";
	property name="sh_desti"				ormtype="string";
	property name="sh_desti_id"				ormtype="number";
	property name="sh_open_date"			ormtype="timestamp";
	property name="sh_estim_del_date"		ormtype="timestamp";
	property name="sh_delivery_date"		ormtype="timestamp";
	property name="sh_estim_arr_date"		ormtype="timestamp";
	property name="sh_arrival_date"			ormtype="timestamp";
	property name="sh_frg_cost"				ormtype="number";
	property name="sh_taxes"				ormtype="number";
	property name="sh_imp_duty"				ormtype="number";


	property name="agent" 				fieldtype="many-to-one" cfc="agent" 	 			fkcolumn="id_agent";
	property name="zone"				fieldtype="many-to-one" cfc="zone"					fkcolumn="id_Zone";
	property name="customer"			fieldtype="many-to-one" cfc="customer" 	 			fkcolumn="id_Customer";
	property name="forwarder" 			fieldtype="many-to-one" cfc="forwarder" 	 		fkcolumn="id_forwarder";
	property name="shipment_type" 		fieldtype="many-to-one" cfc="shipment_type" 	 	fkcolumn="id_shipment_type";
	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 				fkcolumn="id_user_created";
	property name="freight" 			fieldtype="many-to-one" cfc="freight" 	 			fkcolumn="id_freight";
	property name="incoterm" 			fieldtype="many-to-one" cfc="incoterm" 	 			fkcolumn="id_incoterm";
}