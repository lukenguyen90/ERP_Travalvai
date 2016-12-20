component persistent="true" {
	property name="Id_group_mat" 		fieldtype="id" generator="native" setter="false";
	property name="gm_code" 			ormtype="string";
	property name="gm_order" 			ormtype="string";
	property name="gm_description" 		ormtype="string";

	property name="factory" 			fieldtype="many-to-one" cfc="factory" 	 fkcolumn="id_Factory";
}