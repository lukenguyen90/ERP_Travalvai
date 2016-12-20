component persistent="true"  {
	property name="id_shipment_information" 		fieldtype="id" generator="native" setter="false";
	property name="sh_name" 						ormtype="text";
	property name="sh_address_1"   					ormtype="text";
	property name="sh_address_2"					ormtype="text";
	property name="sh_address_3"					ormtype="text";
	property name="sh_city"							ormtype="text";
	property name="sh_province"						ormtype="text";
	property name="sh_zip_code"						ormtype="text";
	property name="sh_country"						ormtype="text";
	property name="sh_phone"						ormtype="text";
	property name="sh_email"						ormtype="text";
	property name="sh_note"							ormtype="text";
	property name="created" 						ormtype="timestamp";
	property name="updated" 						ormtype="timestamp";

	property name="user_created" 					fieldtype="many-to-one" cfc="user" 	  fkcolumn="id_user_created";
	property name="user_updated" 					fieldtype="many-to-one" cfc="user" 	  fkcolumn="id_user_updated";
	property name="contact"							fieldtype="many-to-one" cfc="contact" fkcolumn="id_contact";
}