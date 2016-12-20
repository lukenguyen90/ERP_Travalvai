component persistent="true" {
	property name="Id_pr_comp" 			fieldtype="id" generator="native" setter="false";
	property name="pc_comp_qtty" 		ormtype="string";

	property name="product" 			fieldtype="many-to-one" cfc="product" 	 fkcolumn="id_product";
	property name="materials" 			fieldtype="many-to-one" cfc="materials" 	 fkcolumn="id_mat";
}