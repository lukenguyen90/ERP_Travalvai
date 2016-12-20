component persistent="true" {
	property name="id_size_det" fieldtype="id" generator="native" setter="false";
	property name="szd_position" ormtype="number";
	property name="szd_size"   	ormtype="string";

	property name="size" 		fieldtype="many-to-one" cfc="sizes" 	 fkcolumn="id_size";
}