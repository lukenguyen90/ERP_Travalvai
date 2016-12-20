component persistent="true" {
	property name="id_plz" fieldtype="id" generator="native" setter="false";
	property name="plz_code" 			ormtype="string";
	property name="plz_description"   	ormtype="text";
	property name="plz_season"   		ormtype="string";
	property name="plz_ex_Rate" 		ormtype="double";
	property name="plz_correction" 		ormtype="double";
	property name="plz_commission" 		ormtype="double";
	property name="plz_freight"			ormtype="double";
	property name="plz_taxes"			ormtype="double";
	property name="plz_margin"			ormtype="double";
	property name="plz_date"			ormtype="date";
	property name="plz_update"			ormtype="date";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	// property name="Agent" 				fieldtype="many-to-one" cfc="agent" 	 fkcolumn="id_agent";
	property name="currency" 			fieldtype="many-to-one" cfc="currency" 	 fkcolumn="id_currency";
	property name="language" 			fieldtype="many-to-one" cfc="languages" 	 fkcolumn="id_language";
	property name="price_list_factory"  fieldtype="many-to-one" cfc="price_list_factory" 	 fkcolumn="id_plf";
}