component persistent="true" {
	property name="id" 		fieldtype="id" 	generator="native" setter="false";
	property name="name" 	ormtype="string";

	property name="idPage" 	unique="true"	ormtype="string";
}