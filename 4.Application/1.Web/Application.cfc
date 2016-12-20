/**
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
*/
component{
    // Application properties
   
    this.name = hash( getCurrentTemplatePath() );
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0,0,30,0);
    this.setClientCookies = true;
    //ORM javaSettings
    this.ormEnabled = true;
    this.datasource = "travalvai";
    this.ormSettings = {
        cflocation = "models",
        dbcreate = "update",
        logSQL = true,
        flushAtRequestEnd = false,
        autoManageSession = false,
        eventHandling = true,
        eventHandler = "cborm.models.EventHandler"
    };    
    
    // COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP
    COLDBOX_APP_ROOT_PATH = getDirectoryFromPath( getCurrentTemplatePath() );
    // The web server mapping to this application. Used for remote purposes or static purposes
    COLDBOX_APP_MAPPING   = "";
    // COLDBOX PROPERTIES
    COLDBOX_CONFIG_FILE      = "";

    // COLDBOX APPLICATION KEY OVERRIDE
    COLDBOX_APP_KEY          = "";

    // JAVA INTEGRATION: JUST DROP JARS IN THE LIB FOLDER
    this.mappings["/cborm"] = COLDBOX_APP_ROOT_PATH & "modules/cborm";
    this.mappings["/javaloader"] = COLDBOX_APP_ROOT_PATH & "modules/javaloader";
    this.mappings["/lib"] = COLDBOX_APP_ROOT_PATH & "lib";
    this.mappings["/cbjavaloader"] = COLDBOX_APP_ROOT_PATH & "modules/cbjavaloader";


// You can add more paths or change the reload flag as well.
    this.javaSettings = { loadPaths = [ "lib" ], reloadOnChange = false };


    // application start
    public boolean function onApplicationStart(){
        application.cbBootstrap = new coldbox.system.Bootstrap( COLDBOX_CONFIG_FILE, COLDBOX_APP_ROOT_PATH, COLDBOX_APP_KEY, COLDBOX_APP_MAPPING );
        application.cbBootstrap.loadColdbox();
        return true;
    }



    // request start
    public boolean function onRequestStart(String targetPage){
        // ORMreload();
        // Process ColdBox Request
        application.version = "4.00";
        application.cbBootstrap.onRequestStart( arguments.targetPage );
        application.userType = getUserType();
        application.userTypeId = getUserTypeId();
        return true;
    }

    public void function onSessionStart(){
        SESSION.isLoggedIn = false;
        application.cbBootStrap.onSessionStart();
    }

    public void function onSessionEnd( struct sessionScope, struct appScope ){
        arguments.appScope.cbBootStrap.onSessionEnd( argumentCollection=arguments );
    }

    public boolean function onMissingTemplate( template ){
        return application.cbBootstrap.onMissingTemplate( argumentCollection=arguments );
    }

    number function getUserTypeId(){
        if(isnull(SESSION) || isnull(SESSION.loggedInUserID) || len(SESSION.loggedInUserID) == 0)
            return 0;

        if(SESSION.userType == 2)
            return  SESSION.zoneID; 
        else if(SESSION.userType == 3)
            return  SESSION.agentID; 
        else if(SESSION.userType == 4)
            return  SESSION.customerID; 

        return SESSION.loggedInUserID
    }

    string function getUserType() {
        if(isnull(SESSION) || isnull(SESSION.userType))
            return "";
        if(SESSION.userType == 1)
            return  'factory';  
        else if(SESSION.userType == 2)
            return  'zone'; 
        else if(SESSION.userType == 3)
            return  'agent'; 
        else if(SESSION.userType == 4)
            return  'customer';  
            
        return '';
    }   
}