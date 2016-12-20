component output="false" extends="base" displayname="Login Manager"  {

	property name='userService' 				inject="userService";
	// core event
	function index(event,rc,prc){
		if(structKeyExists(SESSION, "isLoggedIn") and SESSION.isLoggedIn){
			setNextEvent("main.index");
		}

		event.setLayout( "loginLayout" );
		event.setView(view =  "login/index",layout = "loginLayout" );
	}
	function redirect(event,rc,prc){
		event.renderData(type = "json", data = { "session" : false, "backlink": SESSION.backlink});
	}

	function attemptLogin(event,rc,prc){
		var username = rc.username ?: "";
		var password = rc.password ?: "";

		if(authenticate(username,password)){
			if(userService.isAdmin()) setNextEvent("basicdata.user");
			if(!structKeyExists(rc, "backlink") or rc.backlink eq "")
			{
				setNextEvent("main.index");
			}
			else location(rc.backlink,false);
		}
		else{
			// getPlugin("MessageBox").setMessage("error","Login failed!");
			rc.backlink = rc.backlink ?: "";
			setNextEvent(event = "login.index",persistStruct={message ="the username or password is wrong",class="alert-danger",backlink = rc.backlink});
		}
	}

	//SecurityService
	private boolean function authenticate(required any username, required any password){
		SESSION.isLoggedIn = false ;
		var user = userService.getUserLogin(arguments.username,arguments.password);
		if( not isNull(user) ){
			SESSION.loggedInUserName   	= user.getUser_name();
			SESSION.loggedInUserID 		= user.getId_user() ;
			SESSION.isLoggedIn     		= true ;
			SESSION.Title     	   		= "" ;
			SESSION.level 				= 100;
			SESSION.userType 			= userService.getUserLevel();
			SESSION.zoneID   			= userService.getZoneID();
			SESSION.agentID 			= userService.getAgentID();
			SESSION.customerID  		= userService.getCustomerID();
			
			return true;
		}
		return false;
	}

	// private function getLoggedInUserSess(){
	// 	return entityLoadByPK("user",SESSION.loggedInUserID);
	// }

	// private function getUserTypeSess(){
	// 	if(isNull(getLoggedInUser().getFactory()) AND isNull(getLoggedInUser().getZone()) AND isNull(getLoggedInUser().getAgent()) AND isNull(getLoggedInUser().getCustomer())){
	// 		return  SESSION.Title =  " ";
	// 	}
	// 	else if(not isNull(getLoggedInUser().getFactory()) AND isNull(getLoggedInUser().getZone()) AND isNull(getLoggedInUser().getAgent()) AND isNull(getLoggedInUser().getCustomer())){
	// 		return SESSION.Title = getLoggedInUser().getFactory().getfty_code() + " - " +"Factory Admin";
	// 	}
	// 	else if (not isNull(getLoggedInUser().getFactory()) AND (not isNull(getLoggedInUser().getZone())) AND isNull(getLoggedInUser().getAgent()) AND isNull(getLoggedInUser().getCustomer())){
	// 		return SESSION.Title = getLoggedInUser().getFactory().getfty_code() + "/" + getLoggedInUser().getZone().getz_code() + " - " + "Zone Admin";
	// 	}
	// 	else if (not isNull(getLoggedInUser().getFactory()) AND (not isNull(getLoggedInUser().getZone())) AND (not isNull(getLoggedInUser().getAgent())) AND isNull(getLoggedInUser().getCustomer())){
	// 		return SESSION.Title = getLoggedInUser().getFactory().getfty_code() + "/" + getLoggedInUser().getZone().getz_code() + "/" + getLoggedInUser().getAgent().getag_code() + " - " + "Agent Admin";
	// 	}
	// 	else if (not isNull(getLoggedInUser().getFactory()) AND (not isNull(getLoggedInUser().getZone())) AND (not isNull(getLoggedInUser().getAgent())) AND (not isNull(getLoggedInUser().getCustomer()))){
	// 		return SESSION.Title = getLoggedInUser().getFactory().getfty_code() + "/" + getLoggedInUser().getZone().getz_code() + "/" + getLoggedInUser().getAgent().getag_code() + "/" + getLoggedInUser().getCustomer().getcs_code() + " - " + "Customer Admin";
	// 	}
	// 	return SESSION.Title =  " ";
	// }

	//logout

	public any function doLogout(event,rc,prc){
		SESSION.isLoggedIn = false;
		SESSION.loggedInUserID = "";
		setNextEvent("login.index");
	}

	// //register
	// public any function register(event,rc,prc){
	// 	setView("login.register");
	// }

	// public any function function_name(param) {

	// 	return;
	// }
}