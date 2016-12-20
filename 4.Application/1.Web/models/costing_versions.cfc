component persistent="true" {
	property name="id_cost_version" fieldtype="id" generator="native" setter="false";
	property name="cv_version" 				ormtype="string";
	property name="cv_material_cost"		ormtype="string";
	property name="cv_process_cost"			ormtype="string";
	property name="cv_waste"				ormtype="double";
	property name="cv_structure"			ormtype="string";
	property name="cv_margin"				ormtype="double";
	property name="cv_fty_cost_0"			ormtype="double";
	property name="cv_weight"				ormtype="double";
	property name="cv_volume"				ormtype="double";
	property name="cv_sketch"				ormtype="string";
	property name="created" 				ormtype="timestamp";
	property name="updated" 				ormtype="timestamp";

	property name="user_created" 			fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 			fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="costing" 				fieldtype="many-to-one" cfc="costing" 				fkcolumn="id_cost";
}