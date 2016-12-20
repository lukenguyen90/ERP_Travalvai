component persistent="true" {
	property name="Id_mat" 				fieldtype="id" generator="native" setter="false";
	property name="mat_code" 			ormtype="string";
	property name="mat_description" 	ormtype="string";
	property name="id_unit" 			ormtype="string";
	property name="mat_price" 			ormtype="string";
	property name="mat_date" 			ormtype="string";

	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="group_materials" 	fieldtype="many-to-one" cfc="group_materials" 	 fkcolumn="id_group_mat";
	property name="factory" 			fieldtype="many-to-one" cfc="factory" 	 		 fkcolumn="id_Factory";
	property name="user_created" 		fieldtype="many-to-one" cfc="user" 				 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 			 fkcolumn="id_user_updated";
}