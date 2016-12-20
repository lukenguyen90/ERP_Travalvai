component persistent="true" {
	property name="id_size" fieldtype="id" generator="native" setter="false";
	property name="sz_description" 		ormtype="string";
	property name="sz_qtty"   			ormtype="number";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";
}