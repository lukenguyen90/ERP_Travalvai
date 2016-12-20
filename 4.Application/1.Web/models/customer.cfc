component persistent="true" {
	property name="id_Customer" fieldtype="id" generator="native" setter="false";
	// property name="cs_code" ormtype="string" unique="true";
	property name="cs_name" 	ormtype="string";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="language" 			fieldtype="many-to-one" cfc="languages" 				fkcolumn="id_language";
	property name="agent" 				fieldtype="many-to-one" cfc="agent" 	 				fkcolumn="id_agent";
	property name="zone"				fieldtype="many-to-one" cfc="zone"						fkcolumn="id_Zone";
	property name="type_of_customer" 	fieldtype="many-to-one" cfc="type_of_customers" 	 	fkcolumn="id_type_customer";
	property name="contact" 			fieldtype="many-to-one" cfc="contact" 	 				fkcolumn="id_contact";
}