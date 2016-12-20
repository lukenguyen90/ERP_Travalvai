component persistent="true" {
	property name="id_plf_det" fieldtype="id" generator="native" setter="false";
	property name="plfd_fty_cost_0" 			ormtype="string";
	property name="plfd_fty_sell_1" 			ormtype="double";
	property name="plfd_fty_sell_2" 			ormtype="double";
	property name="plfd_fty_sell_3" 			ormtype="double";
	property name="created" 					ormtype="timestamp";
	property name="updated" 					ormtype="timestamp";

	property name="user_created" 					fieldtype="many-to-one" cfc="user" 	 						fkcolumn="id_user_created";
	property name="user_updated" 					fieldtype="many-to-one" cfc="user" 	 						fkcolumn="id_user_updated";
	property name="price_list_factory" 				fieldtype="many-to-one" cfc="price_list_factory" 			fkcolumn="id_plf";
	property name="costing" 						fieldtype="many-to-one" cfc="costing" 	 	 				fkcolumn="id_cost";
	property name="factory" 						fieldtype="many-to-one" cfc="factory" 	 	 				fkcolumn="id_factory";
	property name="currency" 						fieldtype="many-to-one" cfc="currency" 	 	 				fkcolumn="id_currency";
	property name="costing_version" 				fieldtype="many-to-one" cfc="costing_versions" 	 			fkcolumn="id_cost_version";
}