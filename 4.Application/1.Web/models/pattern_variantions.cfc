component persistent="true" {
	property name="id_pattern_var" 		fieldtype="id" generator="native" setter="false";
	property name="pv_code"   			ormtype="string";
	property name="pv_comment"   		ormtype="string";
	property name="pv_sketch" 			ormtype="string";

	property name="pattern_part" 		ormtype="string";
	property name="pattern" 			fieldtype="many-to-one" 	cfc="patterns" 		fkcolumn="id_pattern";
}