component persistent="true" {
	property name="id_language" fieldtype="id" generator="native" setter="false";
	property name="lg_code" 	ormtype="string" unique="true";
	property name="lg_name"		ormtype="string";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";
}