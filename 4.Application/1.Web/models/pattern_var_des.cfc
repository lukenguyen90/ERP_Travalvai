component persistent="true" {
	property name="id_pv_des" 			fieldtype="id" generator="native" setter="false";
	property name="pv_description" 		ormtype="text";

	property name="pattern_variantion" 	fieldtype="many-to-one" cfc="pattern_variantions" 	fkcolumn="id_pattern_var";
	property name="language" 			fieldtype="many-to-one" cfc="languages" 			fkcolumn="id_language";
}