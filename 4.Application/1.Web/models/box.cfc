component persistent="true" {
	property name="id_box" fieldtype="id" generator="native" setter="false";	
	property name="bx_weight"			ormtype="double";
	property name="bx_code"				ormtype="string";

	property name="type_of_box" 		fieldtype="many-to-one" 	cfc="type_of_box" 	 	fkcolumn="id_type_box";
}