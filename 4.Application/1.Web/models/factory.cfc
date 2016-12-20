component persistent="true" {
	property name="id_factory" 		fieldtype="id" 	generator="native" setter="false";
	property name="fty_code" 						ormtype="string";
	property name="fty_description"   				ormtype="string";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="currency" 		fieldtype="many-to-one" 	cfc="currency" 	 	 fkcolumn="id_currency";
	property name="languages" 		fieldtype="many-to-one" 	cfc="languages" 	 fkcolumn="id_language";
	property name="contact" 		fieldtype="many-to-one" 	cfc="contact" 		 fkcolumn="id_contact";
}