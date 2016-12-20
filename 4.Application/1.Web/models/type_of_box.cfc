component persistent="true"  {
	property name="id_type_box" 		fieldtype="id" generator="native" setter="false";
	property name="tb_description" 		ormtype="text";
	property name="tb_depth"   			ormtype="number";
	property name="tb_length"			ormtype="number";
	property name="tb_width"			ormtype="number";
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";
}