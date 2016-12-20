component persistent="true" {
	property name="Id_unit" 		fieldtype="id" generator="native" setter="false";
	property name="unit_Code" 		ormtype="string";

	property name="factory" 		fieldtype="many-to-one" cfc="factory" 	 fkcolumn="id_Factory";
}