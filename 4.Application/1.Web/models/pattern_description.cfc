component persistent="true" {
	property name="id_pattern_des" 	fieldtype="id" generator="native" setter="false";
	property name="pd_description" 			ormtype="text";
	property name="created" 				ormtype="timestamp";
	property name="updated" 				ormtype="timestamp";

	property name="user_created" 			fieldtype="many-to-one" cfc="user" 	 		fkcolumn="id_user_created";
	property name="user_updated" 			fieldtype="many-to-one" cfc="user" 	 		fkcolumn="id_user_updated";
	property name="pattern" 				fieldtype="many-to-one" cfc="patterns" 		fkcolumn="id_pattern";
	property name="language" 				fieldtype="many-to-one" cfc="languages" 	fkcolumn="id_language";
}