component persistent="true" {
	property name="id_cost_version_desc" fieldtype="id" generator="native" setter="false";
	property name="cvd_description" 			ormtype="text";
	property name="created" 				ormtype="timestamp";
	property name="updated" 				ormtype="timestamp";

	property name="user_created" 			fieldtype="many-to-one" cfc="user" 	 			fkcolumn="id_user_created";
	property name="user_updated" 			fieldtype="many-to-one" cfc="user" 	 			fkcolumn="id_user_updated";
	property name="costing_version" 		fieldtype="many-to-one" cfc="costing_versions" 	fkcolumn="id_cost_version";
	property name="language" 				fieldtype="many-to-one" cfc="languages" 		fkcolumn="id_language";
}