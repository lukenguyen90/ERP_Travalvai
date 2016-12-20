component persistent="true" {
	 property  name="id_plz_det"                   fieldtype="id"           generator="native"               setter="false";
	 property  name="plzd_Weight"               	  ormtype="double";
	 property  name="plzd_Fty_Sell_4"           	  ormtype="double";
	 property  name="plzd_Freight"              	  ormtype="double";
	 property  name="plzd_Taxes"                	  ormtype="double";
	 property  name="plzd_Margin"             	  	  ormtype="double";
	 property  name="plzd_Margin_1"             	  ormtype="double";
	 property  name="plzd_Margin_2"             	  ormtype="double";
	 property  name="plzd_Zone_Sell_5"          	  ormtype="double";
	 property  name="plzd_Zone_Sell_6"          	  ormtype="double";
	 property  name="plzd_PVPR_7"               	  ormtype="double";
	 property  name="plzd_PVPR_8"               	  ormtype="double";
	 property  name="created"                   	  ormtype="timestamp";
	 property  name="updated"                   	  ormtype="timestamp";

	 property  name="user_created"              	  fieldtype="many-to-one"  cfc="user"                      	fkcolumn="id_user_created";
	 property  name="user_updated"              	  fieldtype="many-to-one"  cfc="user"                      	fkcolumn="id_user_updated";

	 property  name="price_list_zone"           	  fieldtype="many-to-one"  cfc="price_list_zone"           	fkcolumn="id_plz";
	 property  name="price_list_factory_detail" 	  fieldtype="many-to-one"  cfc="price_list_factory_detail" 	fkcolumn="id_plf_det";
}