/**
*
* @file  /E/Work/coldbox-projects/projects/erp_travalvai/4.Application/1.Web/handlers/session_info.cfc
* @author  
* @description
*
*/

component output="false" displayname=""  {
	public function init(){
		return this;
	}

	function getInfo(event,prc,rc){	
		event.renderData(type = "json", data = {"timeout": !SESSION.isLoggedIn});		
	}
}