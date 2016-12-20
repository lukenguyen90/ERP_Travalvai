component persistent="true"  {
	property name="id_incoterm" 		fieldtype="id" generator="native" setter="false";
	property name="ict_code" 			ormtype="string";
	property name="ict_description"   	ormtype="text";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";
}