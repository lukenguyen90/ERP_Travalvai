component persistent="true" {
	property name="id_pj_comment" fieldtype="id" generator="native" setter="false";
	property name="pj_com_comment" 	ormtype="text";
	property name="pj_com_date"   	ormtype="timestamp";
	property name="created" 		ormtype="timestamp";
	property name="updated" 		ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="project" 		fieldtype="many-to-one" cfc="project" 	 fkcolumn="id_Project";
	property name="user" 			fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user";
}