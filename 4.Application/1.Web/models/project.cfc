component persistent="true" {
	property name="id_Project" 			fieldtype="id" generator="native" setter="false";
	property name="id_display"			ormtype="integer" unique=true;
	property name="pj_description"		ormtype="text";
	property name="pj_date"				ormtype="date";
	property name="pj_act_1"			ormtype="boolean" default=false;
	property name="pj_act_2"			ormtype="boolean" default=false;
	property name="pj_act_3"			ormtype="boolean" default=false;
	property name="pj_act_4"			ormtype="boolean" default=false;
	property name="pj_act_5"			ormtype="boolean" default=false;
	property name="pj_act_6"			ormtype="boolean" default=false;
	property name="pj_act_7"			ormtype="boolean" default=false;
	property name="pj_act_8"			ormtype="boolean" default=false;
	property name="pj_act_9"			ormtype="boolean" default=false;
	property name="pj_act_10"			ormtype="boolean" default=false;
	property name="created" 			ormtype="timestamp";
	property name="updated" 			ormtype="timestamp";

	property name="user_created" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_created";
	property name="user_updated" 		fieldtype="many-to-one" cfc="user" 	 fkcolumn="id_user_updated";

	property name="factory" 			fieldtype="many-to-one"   cfc="factory" 	 	fkcolumn="id_Factory";
	property name="customer" 			fieldtype="many-to-one"   cfc="customer" 	 	fkcolumn="id_customer";
	property name="project_status"  	fieldtype="many-to-one"   cfc="project_status"	fkcolumn="id_pj_Status";
}