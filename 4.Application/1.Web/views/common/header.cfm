<!-- ##HEADER -->
<cfoutput>
	<header id="header">
		<link rel="stylesheet" type="text/css" href="/includes/css/customstyles.css">
		<div id="logo-group" style="width:500px">

			<!-- PLACE YOUR LOGO HERE -->
			<span> <img width="45px" style= "margin-left:10px" src="/includes/img/traval-vai.png" alt="ZWLLING"> </span>
			<span style="float:left; font-size: 17px;font-weight: bold;margin-top: 10px;margin-left: 10px;">
				TRAVAL VAI MANAGEMENT TOOL
			</span>
			<!-- END LOGO PLACEHOLDER -->

			<!-- Note: The activity badge color changes when clicked and resets the number to 0
				 Suggestion: You may want to set a flag when this happens to tick off all checked messages /

			<!-- AJAX-DROPDOWN : control this dropdown height, look and feel from the LESS variable file -->
			<div class="ajax-dropdown">

				<!-- the ID links are fetched via AJAX to the ajax container "ajax-notifications" -->
				<div class="btn-group btn-group-justified" data-toggle="buttons">
					<label class="btn btn-default">
						<input type="radio" name="activity" id="ajax/notify/mail.html">
						Msgs (14) </label>
					<label class="btn btn-default">
						<input type="radio" name="activity" id="ajax/notify/notifications.html">
						notify (3) </label>
					<label class="btn btn-default">
						<input type="radio" name="activity" id="ajax/notify/tasks.html">
						Tasks (4) </label>
				</div>

				<!-- notification content -->
				<div class="ajax-notifications custom-scroll">

					<div class="alert alert-transparent">
						<h4>Click a button to show messages here</h4>
						This blank page message helps protect your privacy, or you can show the first message here automatically.
					</div>

					<i class="fa fa-lock fa-4x fa-border"></i>

				</div>
				<!-- end notification content -->

				<!-- footer: refresh area -->
				<span> Last updated on: 12/12/2013 9:43AM
					<button type="button" data-loading-text="<i class='fa fa-refresh fa-spin'></i> Loading..." class="btn btn-xs btn-default pull-right">
						<i class="fa fa-refresh"></i>
					</button> </span>
				<!-- end footer -->

			</div>
			<!-- END AJAX-DROPDOWN -->
		</div>

		<!-- ##PROJECTS: projects dropdown -->
		<!-- end projects dropdown -->

		<!-- ##TOGGLE LAYOUT BUTTONS -->
		<!-- pulled right: nav area -->
		<div class="pull-right">

			<!-- collapse menu button -->
			<div id="hide-menu" class="btn-header pull-right">
				<span> <a href="javascript:void(0);" data-action="toggleMenu" title="Collapse Menu"><i class="fa fa-reorder"></i></a> </span>
			</div>
			<!-- end collapse menu -->

			<!-- ##MOBILE -->
			<!-- Top menu profile link : this shows only when top menu is active -->
			<cfif not IsNull(SESSION.loggedInUserID)>
				<ul id="mobile-profile-img" class="header-dropdown-list hidden-xs padding-5" style="display: inline-block !important;">
					<li class="">
						<a href="#event.buildLink("login.doLogout")#"  class="padding-10 padding-top-5 padding-bottom-5" data-action="userLogout"><i class="fa fa-sign-out fa-lg erp-logout"></i></a>
					</li>
				</ul>
			</cfif>

			<!-- logout button -->
			<div id="logout" class=" hide btn-header transparent pull-right">
				<span> <a href="login.html" title="Sign Out" data-action="userLogout" data-logout-msg="You can improve your security further after logging out by closing this opened browser"><i class="fa fa-sign-out"></i></a> </span>
			</div>
			<!-- end logout button -->

			<!-- search mobile button (this is hidden till mobile view port) -->
			<div id="search-mobile" class="hide btn-header transparent pull-right">
				<span> <a href="javascript:void(0)" title="Search"><i class="fa fa-search"></i></a> </span>
			</div>
			<!-- end search mobile button -->

			<!-- ##SEARCH -->
			<!-- input: search field -->
			<form  action="search.html" class="hide header-search pull-right">
				<input id="search-fld" type="text" name="param" placeholder="Find reports and more">
				<button type="submit">
					<i class="fa fa-search"></i>
				</button>
				<a href="javascript:void(0);" id="cancel-search-js" title="Cancel Search"><i class="fa fa-times"></i></a>
			</form>
			<!-- end input: search field -->

			<!-- fullscreen button -->
			<div id="fullscreen" class="hide btn-header transparent pull-right">
				<span> <a href="javascript:void(0);" data-action="launchFullscreen" title="Full Screen"><i class="fa fa-arrows-alt"></i></a> </span>
			</div>
			<!-- end fullscreen button -->

			<!-- ##Voice Command: Start Speech -->
			<div  id="speech-btn" class="hide btn-header transparent pull-right hidden-sm hidden-xs">
				<div>
					<a href="javascript:void(0)" title="Voice Command" data-action="voiceCommand"><i class="fa fa-microphone"></i></a>
					<div class="popover bottom"><div class="arrow"></div>
						<div class="popover-content">
							<h4 class="vc-title">Voice command activated <br><small>Please speak clearly into the mic</small></h4>
							<h4 class="vc-title-error text-center">
								<i class="fa fa-microphone-slash"></i> Voice command failed
								<br><small class="txt-color-red">Must <strong>"Allow"</strong> Microphone</small>
								<br><small class="txt-color-red">Must have <strong>Internet Connection</strong></small>
							</h4>
							<a href="javascript:void(0);" class="btn btn-success" onclick="commands.help()">See Commands</a>
							<a href="javascript:void(0);" class="btn bg-color-purple txt-color-white" onclick="$('##speech-btn .popover').fadeOut(50);">Close Popup</a>
						</div>
					</div>
				</div>
			</div>
			<!-- end voice command -->

		</div>
		<!-- end pulled right: nav area -->
	</header>
</cfoutput>
<!-- END HEADER -->