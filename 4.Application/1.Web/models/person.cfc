component persistent="true" {
	property name="id_person" fieldtype="id" generator="native" setter="false";
	property name="cts_p_name"    		ormtype="string";
	property name="cts_p_position"  	ormtype="string";
	property name="cts_p_phone"    		ormtype="string";
	property name="cts_p_email"    		ormtype="string";
	property name="cts_p_notes"    		ormtype="string";
	property name="cts_p_bday"    		ormtype="date";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="contact" 		fieldtype="many-to-one" cfc="contact" 	 fkcolumn="id_contact";
}