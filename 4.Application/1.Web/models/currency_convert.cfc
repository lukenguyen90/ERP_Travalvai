component persistent="true" {
	property name="id_curr_conv" fieldtype="id" generator="native" setter="false";
	property name="cc_date" 	 ormtype="date";
	property name="cc_value"	 ormtype="double";
	property name="currency" 	 fieldtype="many-to-one" cfc="currency" 	 fkcolumn="id_currency";


	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";
}