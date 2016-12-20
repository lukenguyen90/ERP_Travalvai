component persistent="true" {
	property name="id_pattern" fieldtype="id" generator="native" setter="false";
	property name="pt_code" 			ormtype="string" unique="true";
	property name="pt_date" 			ormtype="date";
	property name="pt_update"   		ormtype="date";
	property name="pt_notes"			ormtype="string";
	property name="pt_Sketch"			ormtype="string";
	property name="pt_Parts"			ormtype="string";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 				fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 				fkcolumn="id_user_updated";
	property name="factory" 			fieldtype="many-to-one" cfc="factory" 				fkcolumn="id_Factory";
	property name="group_of_product" 	fieldtype="many-to-one" cfc="group_of_products" 	fkcolumn="id_group_products";
}