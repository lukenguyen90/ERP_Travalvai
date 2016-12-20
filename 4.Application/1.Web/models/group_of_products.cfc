component persistent="true" {
	property name="id_group_products" fieldtype="id" generator="native" setter="false";
	property name="gp_code" 	ormtype="string";

	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="factory" 			fieldtype="many-to-one" cfc="factory" 	 fkcolumn="id_Factory";
	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 	 fkcolumn="id_user_updated";
}