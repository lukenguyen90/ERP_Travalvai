component persistent="true" {
	property name="id_Zone" 			fieldtype="id" generator="native" setter="false";
	property name="z_code" 				ormtype="string"  	unique="true";
	property name="z_description"   	ormtype="text";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="factory" 			fieldtype="many-to-one" cfc="factory" 	 fkcolumn="id_Factory";
	property name="currency" 			fieldtype="many-to-one" cfc="currency" 	 fkcolumn="id_currency";
	property name="language" 			fieldtype="many-to-one" cfc="languages"  fkcolumn="id_language";
	property name="contact"				fieldtype="many-to-one" cfc="contact" 	 fkcolumn="id_contact";
}