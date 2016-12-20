component persistent="true" {
	property name="id_Agent" fieldtype="id" generator="native" setter="false";
	property name="ag_code" 			ormtype="string" 	unique="true";
	property name="ag_description"   	ormtype="text";
	property name="ag_commission"   	ormtype="integer";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="zone" 			fieldtype="many-to-one" cfc="zone" 	 		 	 fkcolumn="id_Zone";
	property name="language" 		fieldtype="many-to-one" cfc="languages" 	 	 fkcolumn="id_language";
	property name="contact"			fieldtype="many-to-one" cfc="contact" 	 	 	 fkcolumn="id_contact";
	property name="price_list_zone"	fieldtype="many-to-one" cfc="price_list_zone" 	 fkcolumn="id_plz";
}