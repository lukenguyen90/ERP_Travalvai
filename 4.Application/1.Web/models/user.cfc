component persistent="true" {
	property name="id_user" fieldtype="id" generator="native" setter="false";
	property name="user_name"     ormtype="string";
	property name="user_position" ormtype="text";
	property name="user_password" ormtype="text";
	property name="is_root" ormtype="boolean" default=false;


	property name="factory" 		fieldtype="many-to-one" cfc="factory" 	 	 fkcolumn="id_Factory";
	property name="language" 		fieldtype="many-to-one" cfc="languages"  	 fkcolumn="id_language";
	property name="zone"            fieldtype="many-to-one" cfc="zone" 	     	 fkcolumn="id_Zone";
	property name="agent" 		    fieldtype="many-to-one" cfc="agent" 	 	 fkcolumn="id_Agent";
	property name="customer" 		fieldtype="many-to-one" cfc="customer" 	 	 fkcolumn="id_Customer";
	property name="access_level"    fieldtype="many-to-one" cfc="access_level" 	 fkcolumn="id_access_level";
	property name="contact" 		fieldtype="many-to-one" cfc="contact" 	 	 fkcolumn="id_contact";
}