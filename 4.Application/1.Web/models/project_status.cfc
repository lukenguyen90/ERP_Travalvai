component persistent="true" {
	property name="id_pj_Status" fieldtype="id" generator="native" setter="false";
	property name="pj_stat_desc" 	ormtype="string";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";
}