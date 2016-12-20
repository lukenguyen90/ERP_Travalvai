component persistent="true" {
	property name="Id_pr_process" 		fieldtype="id" generator="native" setter="false";
	property name="pr_process_qtty" 	ormtype="string";

	property name="process" 			fieldtype="many-to-one" cfc="process"		 	 fkcolumn="id_process";
	property name="product" 			fieldtype="many-to-one" cfc="product" 	 		 fkcolumn="id_product";
}