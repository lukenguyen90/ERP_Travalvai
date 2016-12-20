component persistent="true" {
	property name="id_pattern_part" 	fieldtype="id" generator="native" setter="false";
	property name="pp_vn" 					ormtype="text";
	property name="pp_en" 					ormtype="text";
	property name="pp_code" 				ormtype="text";

	property name="pattern" 				fieldtype="many-to-one" cfc="patterns" 		fkcolumn="id_pattern";
}