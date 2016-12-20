component persistent="true" {
	property name="id_plf" fieldtype="id" generator="native" setter="false";
	property name="plf_code" 			ormtype="string";
	property name="plf_description"   	ormtype="string";
	property name="plf_season"			ormtype="string";
	property name="plf_correction" 		ormtype="double";
	property name="plf_Ex_Rate"			ormtype="double";
	property name="plf_date"			ormtype="date";
	property name="plf_update" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";
	property name="language" 			fieldtype="many-to-one" cfc="languages" 			fkcolumn="id_language";
	property name="factory" 			fieldtype="many-to-one" cfc="factory" 				fkcolumn="id_Factory";
	property name="currency" 			fieldtype="many-to-one" cfc="currency" 	 			fkcolumn="id_currency";
	property name="zone" 				fieldtype="many-to-one" cfc="zone" 	 				fkcolumn="id_Zone";
}