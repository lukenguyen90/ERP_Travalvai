component persistent="true" {
	property name="id_pattern_note" 	fieldtype="id" generator="native" setter="false";
	property name="pn_note" 			ormtype="text";
	property name="pn_date" 			ormtype="timestamp";
	property name="pattern" 			fieldtype="many-to-one" cfc="patterns" 				fkcolumn="id_pattern";
	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 				fkcolumn="id_user_created";	
}