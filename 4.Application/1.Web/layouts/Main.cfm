<!DOCTYPE html>
<html lang="en-us">
	<head>
		<meta charset="utf-8">
		<title> <cfif structKeyExists(rc,"pagetitle")><cfoutput>#rc.pagetitle# - </cfoutput></cfif> Traval Vai </title>
		<meta name="description" content="">
		<meta name="author" content="">

		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		

		<!-- #CSS Links -->
		<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="/includes/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/includes/css/font-awesome.min.css">

		<!-- SmartAdmin Styles : Caution! DO NOT change the order -->
		<link rel="stylesheet" type="text/css" media="screen" href="/includes/css/smartadmin-production-plugins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/includes/css/smartadmin-production.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/includes/css/smartadmin-skins.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/includes/css/styletable.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/includes/css/customstyles.css?v=2">

		<!-- SmartAdmin RTL Support -->
		<link rel="stylesheet" type="text/css" media="screen" href="/includes/css/smartadmin-rtl.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/includes/css/lightbox.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="/includes/css/lightbox.custom.css">

		<!-- We recommend you use "your_style.css" to override SmartAdmin
		     specific styles this will also ensure you retrain your customization with each SmartAdmin update. -->
		<link rel="stylesheet" type="text/css" media="screen" href="/includes/css/style.css">

		<!-- Demo purpose only: goes with demo.js, you can delete this css when designing your own WebApp -->
		<link rel="stylesheet" type="text/css" media="screen" href="/includes/css/demo.min.css">

		<!-- CSS for 3rd plugin -->
		<link rel="stylesheet" type="text/css" media="screen" href="/includes/css/select.dataTables.min.css">
		<!-- CSS for 3rd plugin -->

		<!-- #FAVICONS -->
		<link rel="shortcut icon" href="/includes/img/favicon-traval-vai.ico" type="image/x-icon">
		<link rel="icon" href="/includes/img/favicon-traval-vai.ico" type="image/x-icon">

		<!-- #GOOGLE FONT -->
		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">

		<!-- #PLUG-IN CSS -->
		<link rel="stylesheet" type="text/css" media="screen" href="/includes/js/plugin/nya-bs-select/css/nya-bs-select.css">

		<!-- #APP SCREEN / ICONS -->
		<!-- Specifying a Webpage Icon for Web Clip
			 Ref: https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html -->
		<link rel="apple-touch-icon" href="img/splash/sptouch-icon-iphone.png">
		<link rel="apple-touch-icon" sizes="76x76" href="img/splash/touch-icon-ipad.png">
		<link rel="apple-touch-icon" sizes="120x120" href="img/splash/touch-icon-iphone-retina.png">
		<link rel="apple-touch-icon" sizes="152x152" href="img/splash/touch-icon-ipad-retina.png">

		<!-- iOS web-app metas : hides Safari UI Components and Changes Status Bar Appearance -->
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">

		<!-- Startup image for web apps -->
		<link rel="apple-touch-startup-image" href="/includes/img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
		<link rel="apple-touch-startup-image" href="/includes/img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
		<link rel="apple-touch-startup-image" href="/includes/img/splash/iphone.png" media="screen and (max-device-width: 320px)">

		<script data-pace-options='{ "restartOnRequestAfter": true }' src="/includes/js/plugin/pace/pace.min.js"></script>

		<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
		<script>
			if (!window.jQuery) {
				document.write('<script src="/includes/js/libs/jquery-2.1.1.min.js"><\/script>');
			}
		</script>
		<script>
			if (!window.jQuery.ui) {
				document.write('<script src="/includes/js/libs/jquery-ui-1.10.3.min.js"><\/script>');
			}
		</script>
		<script src="/includes/js/angular.min.js"></script>
		<script src="/includes/js/lodash.min.js"></script>
		<!--Plugin-->

		
			
		

		<script src="/includes/js/plugin/angular-bootstrap/ui-bootstrap-tpls.min.js"> </script>
		<script src="/includes/js/plugin/nya-bs-select/js/nya-bs-select.min.js"> </script>
		<script src="/includes/js/plugin/angular-resource/angular-resource.min.js"> </script>
		<script src="/includes/js/plugin/angular-ui/angular-ui-router.min.js"> </script>
		<script src="/includes/js/plugin/notification/bootstrap-notify.min.js"> </script>	
		<script src="/includes/js/plugin/angular-csv-import/angular-csv-import.min.js"> </script>		

		<script src="/includes/js/views/app.helper.js?v=6"></script>
	

		<style type="text/css">
			.select2-hidden-accessible{
			    border: 0;
			    clip: rect(0 0 0 0);
			    height: 1px;
			    margin: -1px;
			    overflow: hidden;
			    padding: 0;
			    position: absolute;
			    width: 1px;
			}
		</style>
	</head>

	<body class="fixed-header fixed-navigation fixed-ribbon">
	
		<cfoutput>
			#Renderview('common/header')#

			<!-- Factory -->
			<cfif SESSION.userType == 1>
				#Renderview('common/nav-factory')#
			<!-- Zone -->
			<CFELSEIF SESSION.userType == 2>
				#Renderview('common/nav-zone')#
				<!-- Agent -->
			<CFELSEIF SESSION.userType == 3>
				#Renderview('common/nav-agent')#
				<!-- Customer -->
			<CFELSEIF SESSION.userType == 4>
				#Renderview('common/nav-customer')#
			</cfif>
				

			

			<!-- MAIN PANEL -->
			<div id="main" role="main">

				<!-- RIBBON -->
				<div id="ribbon">

					<span class="ribbon-button-alignment">
						<!--- <span id="refresh" class="btn btn-ribbon" data-action="resetWidgets" data-title="refresh"  rel="tooltip" data-placement="bottom" data-original-title="<i class='text-warning fa fa-warning'></i> Warning! This will reset all your widget settings." data-html="true">
							<i class="fa fa-refresh"></i>
						</span> --->
						<cfif not IsNull(SESSION.loggedInUserID)>
							<span>
								<!--- <span style="color:##fff; font-size:16px;">#SESSION.loggedInUserName#/#SESSION.Title#</span>  --->
								<span style="color:##fff; font-size:16px;">#SESSION.loggedInUserName#/#SESSION.Title#</span>
							</span>
						</cfif>
					</span>

					<!-- breadcrumb -->
					<ol class="breadcrumb">
						<!--- <li>Home</li>
						<li>Miscellaneous</li>
						<li>Blank Page</li> --->
					</ol>
				</div>
				<!-- END RIBBON -->



				<!-- MAIN CONTENT -->
				<div id="content">

					#Renderview()#

				</div>
				<!-- END MAIN CONTENT -->

			</div>
			<!-- END MAIN PANEL -->

		  #Renderview('common/footer')#
		</cfoutput>
	</body>

</html>
