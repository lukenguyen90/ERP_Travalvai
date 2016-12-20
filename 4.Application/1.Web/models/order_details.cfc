component persistent="true" {
	property name="id_order_det" 		fieldtype="id" generator="native" setter="false";
	property name="ordd_cg_name" 		ormtype="string";
	property name="ordd_line" 			ormtype="string";
	property name="ordd_name" 			ormtype="string";
	property name="ordd_number" 		ormtype="string";
	property name="ordd_qtty" 			ormtype="double" default=0;
	property name="ordd_fty_pr" 		ormtype="double" default=0;
	property name="ordd_zone_pr" 		ormtype="double" default=0;
	property name="ordd_ag_pr" 			ormtype="double" default=0;
	
	property name="ordd_fty_tot" 		ormtype="double" default=0;
	property name="ordd_zone_tot" 		ormtype="double" default=0;
	property name="ordd_ag_tot" 		ormtype="double" default=0;

	property name="ordd_pricelist" 		ormtype="text";
	property name="ordd_size_custom"	ormtype="int" default=0;	
	// property name="ordd_del_fty" 		ormtype="double" default=0;
	// property name="ordd_del_zone" 		ormtype="double" default=0;
	// property name="ordd_del_ag" 		ormtype="double" default=0;
	// property name="ordd_rcv_zone"		ormtype="double" default=0;
	// property name="ordd_rcv_ag"			ormtype="double" default=0;
	// property name="ordd_rcv_cs"			ormtype="double" default=0;
	// property name="ordd_rcv_pr"			ormtype="double" default=0;
	
	property name="size_details" 		fieldtype="many-to-one"   		cfc="sizes_details" 	fkcolumn="id_size_det";
	property name="order" 				fieldtype="many-to-one"   		cfc="orders" 	 		fkcolumn="id_order";
	property name="product" 			fieldtype="many-to-one" 		cfc="product" 			fkcolumn="id_product";
}