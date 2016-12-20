component persistent="true" {
	property name="id_particular" fieldtype="id" generator="native" setter="false";
	property name="pt_name" 		ormtype="string";
	property name="pt_dni"   		ormtype="text";
	property name="pt_password"   	ormtype="text";
	property name="pt_mail"   		ormtype="text";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="customer" 		fieldtype="many-to-one" cfc="customer" 	 fkcolumn="id_customer";
	property name="language" 		fieldtype="many-to-one" cfc="languages" 	 fkcolumn="id_language";
	property name="contact" 		fieldtype="many-to-one" cfc="contact" 	 fkcolumn="id_contact";
}