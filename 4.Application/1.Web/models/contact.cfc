component persistent="true" {
	property name="id_contact" 			fieldtype="id" generator="native" setter="false";
	property name="cn_name"    			ormtype="string";
	property name="cts_address_1"    	ormtype="string";
	property name="cts_address_2"    	ormtype="string";
	property name="cts_address_3"    	ormtype="string";
	property name="cts_city"    		ormtype="string";
	property name="cts_province"    	ormtype="string";
	property name="cts_zip_code"    	ormtype="string";
	property name="cts_country"    		ormtype="string";
	property name="cts_phone"    		ormtype="string";
	property name="cts_email"    		ormtype="string";
	property name="cts_vat_code"    	ormtype="string";
	property name="cts_notes"    		ormtype="string";
	property name="cts_type"   		 	ormtype="integer";

	property name="draft"   		 	ormtype="boolean" default=true;

	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="cts_sh_name"    		ormtype="string";
	property name="cts_sh_address_1"    ormtype="string";
	property name="cts_sh_address_2"    ormtype="string";
	property name="cts_sh_address_3"    ormtype="string";
	property name="cts_sh_city"    		ormtype="string";
	property name="cts_sh_province"    	ormtype="string";
	property name="cts_sh_zip_code"    	ormtype="string";
}