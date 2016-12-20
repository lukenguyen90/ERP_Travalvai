component persistent="true" {
	property name="id_currency" 		fieldtype="id" generator="native" setter="false";
	property name="curr_code" 			ormtype="string"  unique=true;
	property name="curr_description" 	ormtype="text";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";
}