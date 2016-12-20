component persistent="true" {
	property name="id_access_level" 	fieldtype="id" generator="native" setter="false";
	property name="al_name" 			ormtype="string";
	property name="al_right" 			ormtype="text";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";
}