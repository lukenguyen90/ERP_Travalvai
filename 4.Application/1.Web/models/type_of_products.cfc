component persistent="true" {
	property name="id_type_products" fieldtype="id" generator="native" setter="false";
	property name="tp_code" 			ormtype="string";
	property name="tp_description"   	ormtype="string";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="factory" 			fieldtype="many-to-one" cfc="factory" 	 			 fkcolumn="id_Factory";
	property name="group_of_product" 	fieldtype="many-to-one" cfc="group_of_products" 	 fkcolumn="id_group_products";
}