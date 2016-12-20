component persistent="true" {
	property name="id_contract" 		fieldtype="id" generator="native" setter="false";
	property name="c_description" 		ormtype="text";
	property name="c_date_i"  			ormtype="timestamp";
	property name="c_no_of_years"  		ormtype="double";
	property name="c_increase_year"  	ormtype="double";

	property name="customer"			fieldtype="many-to-one" cfc="customer" 	 fkcolumn="id_Customer";
	property name="agent" 		    	fieldtype="many-to-one" cfc="agent" 	 fkcolumn="id_Agent";
	property name="zone"				fieldtype="many-to-one" cfc="zone"		 fkcolumn="id_Zone";
}