component persistent="true" {
	property name="id_prd_cust" 		fieldtype="id" generator="native" setter="false";
	property name="cost_code" 			ormtype="string";
	property name="cv_version" 			ormtype="string";
	property name="prd_cust_qtty" 		ormtype="number";
	property name="prd_cust_description" 	ormtype="string";

	property name="product" 				fieldtype="many-to-one" cfc="product" 	 			fkcolumn="id_product";
	property name="price_list_zone_detail"	fieldtype="many-to-one" cfc="price_list_zone_details"	 	fkcolumn="id_plz_det";
}