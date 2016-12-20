component persistent="true" {
	property name="id_payment" 			fieldtype="id" generator="native" setter="false";
	property name="pay_code" 			ormtype="string";
	property name="pay_description" 	ormtype="text";
	property name="pay_dp" 				ormtype="float";
	property name="pay_delivery" 		ormtype="float";
	property name="pay_30_days" 		ormtype="float";
	property name="pay_60_days" 		ormtype="float";
	property name="pay_other" 			ormtype="float";
	property name="pay_day" 			ormtype="float";
	
}