component persistent="true"  {
	property name="id_agent_pl"		fieldtype="id" 			generator="native"		setter="false";
	property name="apl_date_i"		ormtype="datetime";
	property name="apl_date_f"		ormtype="datetime";
	property name="created" 		ormtype="timestamp";
	property name="updated" 		ormtype="timestamp";

	property name="user_created" 	fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 	fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="agent"			fieldtype="many-to-one" cfc="agent"					fkcolumn="id_Agent";
	property name="price_list_zone"	fieldtype="many-to-one" cfc="price_list_zone"		fkcolumn="id_plz";
	property name="product"			fieldtype="many-to-one" cfc="product"				fkcolumn="id_product";
}