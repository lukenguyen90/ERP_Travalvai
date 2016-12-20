component persistent="true" {
	property name="id_cost" 			fieldtype="id" generator="native" setter="false";
	property name="cost_code" 			ormtype="string";
	property name="cost_season" 		ormtype="string";
	property name="cost_pl"				ormtype="boolean";
	property name="cost_date"			ormtype="date";
	property name="cost_update"			ormtype="date";
	property name="cost_weight"			ormtype="double";
	property name="cost_volume"			ormtype="double";
	property name="cost_variants"		ormtype="integer";
	property name="cost_sketch"			ormtype="string";
	property name="hashid" 				ormtype="string" 	length="32" unique="true";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="factory" 			fieldtype="many-to-one" cfc="factory" 				fkcolumn="id_Factory";
	property name="customer" 			fieldtype="many-to-one" cfc="customer" 	 			fkcolumn="id_customer";
	property name="type_of_product"		fieldtype="many-to-one" cfc="type_of_products"		fkcolumn="id_type_products";

}