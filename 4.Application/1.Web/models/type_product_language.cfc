component persistent="true" {
	property name="id_type_language" 	fieldtype="id" generator="native" setter="false";
	property name="description" 		ormtype="text";

	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";
	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 				fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 				fkcolumn="id_user_updated";
	
	property name="type" 				fieldtype="many-to-one" cfc="type_of_products" 		fkcolumn="id_type";
	property name="language" 			fieldtype="many-to-one" cfc="languages" 			fkcolumn="id_language";
}