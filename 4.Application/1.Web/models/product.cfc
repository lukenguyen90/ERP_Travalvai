component persistent="true" {
	property name="id_product" 						fieldtype="id" 			generator="native" 			setter="false";
	property name="pr_version"						ormtype="integer";
	property name="pr_description" 					ormtype="text";
	property name="pr_section"						ormtype="string";
	property name="pr_fty_sell_9"					ormtype="double";
	property name="pr_zone_sell_10"					ormtype="double";
	property name="pr_PVPR_11"						ormtype="double";
	property name="pr_Club_12"						ormtype="double";
	property name="pr_Web_13"						ormtype="double";
	property name="pr_date"							ormtype="date";
	property name="pr_date_update"					ormtype="date";
	property name="pr_web"							ormtype="boolean";
	property name="pr_9_valid"						ormtype="double";
	property name="pr_10_valid"						ormtype="double";
	property name="pr_11_valid"						ormtype="double";
	property name="pr_sketch"						ormtype="string";
	property name="pr_picture"						ormtype="string";
	property name="pr_stock"						ormtype="boolean";
	property name="pr_comment" 						ormtype="text";
	property name="pr_commission" 					ormtype="double" default=0;

	property name="project" 						fieldtype="many-to-one" cfc="project" 	 					fkcolumn="id_Project";
	property name="type_of_products"				fieldtype="many-to-one" cfc="type_of_products"	 			fkcolumn="id_type_products";
	property name="pattern_variantion"				fieldtype="many-to-one" cfc="pattern_variantions"			fkcolumn="id_pattern_var";
	property name="product_status"					fieldtype="many-to-one" cfc="product_status"	 			fkcolumn="id_pr_status";
	property name="costing"							fieldtype="many-to-one" cfc="costing"	 					fkcolumn="id_cost";
	property name="costing_versions"				fieldtype="many-to-one" cfc="costing_versions"	 			fkcolumn="id_cost_version";
	property name="pattern"							fieldtype="many-to-one" cfc="patterns"	 					fkcolumn="id_Pattern";
	property name="size"							fieldtype="many-to-one" cfc="sizes"	 						fkcolumn="id_size";
	property name="contract"						fieldtype="many-to-one" cfc="contract"	 					fkcolumn="id_contract"  ; 
	property name="price_list_zone_detail"			fieldtype="many-to-one" cfc="price_list_zone_details"	 	fkcolumn="id_plz_det";
	property name="user_created" 					fieldtype="many-to-one" cfc="user" 	 						fkcolumn="id_user_created";
	property name="user_updated" 					fieldtype="many-to-one" cfc="user" 	 						fkcolumn="id_user_updated";
	property name="factory" 						fieldtype="many-to-one" cfc="factory" 						fkcolumn="id_Factory";
}