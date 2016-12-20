component persistent="true" {
	property name="id_group_language" 	fieldtype="id" generator="native" setter="false";
	property name="description" 		ormtype="text";

	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";
	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 				fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 				fkcolumn="id_user_updated";
	
	property name="group" 				fieldtype="many-to-one" cfc="group_of_products" 	fkcolumn="id_group";
	property name="language" 			fieldtype="many-to-one" cfc="languages" 			fkcolumn="id_language";
}