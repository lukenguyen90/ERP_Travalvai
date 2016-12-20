component persistent="true" {
	property name="Id_process" 				fieldtype="id" generator="native" setter="false";
	property name="process_code" 			ormtype="string";
	property name="process_description" 	ormtype="string";
	property name="process_price" 			ormtype="string";

	property name="unit" 	fieldtype="many-to-one" cfc="Units" 	 fkcolumn="id_unit";
}