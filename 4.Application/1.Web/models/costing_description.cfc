component persistent="true" {
	property name="id_cost_description" 	fieldtype="id" generator="native" setter="false";
	property name="cd_description" 			ormtype="text";
	property name="created" 				ormtype="timestamp";
	property name="updated" 				ormtype="timestamp";

	property name="user_created" 			fieldtype="many-to-one" cfc="user" 	 		fkcolumn="id_user_created";
	property name="user_updated" 			fieldtype="many-to-one" cfc="user" 	 		fkcolumn="id_user_updated";
	property name="costing" 				fieldtype="many-to-one" cfc="costing" 		fkcolumn="id_cost";
	property name="language" 				fieldtype="many-to-one" cfc="languages" 	fkcolumn="id_language";
}