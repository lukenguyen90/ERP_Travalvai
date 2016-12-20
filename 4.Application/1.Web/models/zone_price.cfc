component persistent="true" {
	property name="id_zone_pl" 		fieldtype="id" generator="native" setter="false";
	property name="zpl_date_i" 		ormtype="datetime";
	property name="zpl_date_f"   	ormtype="datetime";
	property name="created" 		ormtype="timestamp";
	property name="updated" 		ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="price_list_factory" 		fieldtype="many-to-one" cfc="price_list_factory" 	 fkcolumn="id_plf";
	property name="zone" 					fieldtype="many-to-one" cfc="zone" 	 	 			 fkcolumn="id_Zone";
	property name="agent_price" 			fieldtype="many-to-one" cfc="agent_price" 	 	 	 fkcolumn="id_agent_pl";
}