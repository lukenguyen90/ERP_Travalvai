component persistent="true" {
	property name="id_forwarder" 		fieldtype="id" generator="native" setter="false";
	property name="fw_name" 			ormtype="string";
	property name="zone_name"			ormtype="string";
	property name="agent_name"			ormtype="string";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="contact" 			fieldtype="many-to-one" cfc="contact" 	 fkcolumn="id_contact";
}