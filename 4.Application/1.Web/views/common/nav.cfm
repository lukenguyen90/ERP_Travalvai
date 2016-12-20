<!-- #NAVIGATION -->
<!-- Left panel : Navigation area -->
<!-- Note: This width of the aside area can be adjusted through LESS variables -->
<script type="text/javascript">

	$(document).ready(function(){

	    jQuery('ul li').each(function() {
		    var href = jQuery(this).find('a').attr('href');

		    var iurl=(window.location.pathname+window.location.search);

		    if (href === iurl) {
		        jQuery(this).addClass('active');
		    }

		    if(iurl === "/index.cfm/" || iurl === "index.cfm" || iurl === "/"){
		    	$('#liDashboard').parent().addClass('active');
		    }
	    });
 	});
</script>
<aside id="left-panel">
	<!-- User info -->
	<div class="login-info">
		<span> <!-- User image size is adjusted inside CSS, it should stay as it -->

			<a href="javascript:void(0);" id="show-shortcut" data-action="toggleShortcut">
				<img src="/includes/img/avatars/dogfp.jpg" alt="me" class="online" />
				<cfoutput>
					<cfif not IsNull(SESSION.loggedInUserID)>
						<span>
							#SESSION.loggedInUserName#
						</span>
					<cfelse>
						<span>

						</span>
					</cfif>
				</cfoutput>
				<i class="fa fa-angle-down"></i>
			</a>

		</span>
	</div>
	<!-- end user info -->

	<!-- NAVIGATION : This navigation is also responsive-->
	<nav>
		<ul>
			 <li>
				<a id="liDashboard"  title="Dashboard" ><i class="fa fa-lg fa-fw fa-cube"></i> <span class="menu-item-parent">Products</span></a>
				<ul>
					<li>
						<a href="/index.cfm/product.index">Product List</a>
					</li>
					<li>
						<a href="/index.cfm/product.status">Product Status</a>
					</li>
					<li>
						<a href="/index.cfm/patterns.index">Pattern List</a>
					</li>
					<li>
						<a href="/index.cfm/size.index">Size List</a>
					</li>
				</ul>
			</li>

			 <li>
				<a id="liDashboard"  title="Dashboard" ><i class="fa fa-lg fa-fw fa-cubes"></i> <span class="menu-item-parent">Projects</span></a>
				<ul>
					<li>
						<a href="/index.cfm/project.index">Project List</a>
					</li>
					<li>
						<a href="/index.cfm/project.status">Project Status</a>
					</li>
				</ul>
			</li>

			 <li>
				<a id="liDashboard"  title="Dashboard" ><i class="fa fa-lg fa-fw fa-usd"></i> <span class="menu-item-parent">Costing</span></a>
				<ul>
					<li>
						<a href="/index.cfm/cost.index">Cost List</a>
					</li>
					<li>
						<a href="/index.cfm/material.index">Material List</a>
					</li>
					<li>
						<a href="/index.cfm/product.group">Group of Product</a>
					</li>
					<li>
						<a href="/index.cfm/product.type">Type of Product</a>
					</li>
				</ul>
			</li>
			<li>
				<a id="liDashboard"  title="Dashboard" ><i class="fa fa-lg fa-fw fa-usd"></i> <span class="menu-item-parent">Price Lists</span></a>
				<ul>
					<li>
						<a href="/index.cfm/basicdata.price_list_factory">Price List Factory</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.price_list_zone">Price List Zone</a>
					</li>
				</ul>
			</li>
			<li>
				<a id="liDashboard"  title="Dashboard" ><i class="fa fa-lg fa-fw fa-shopping-cart"></i> <span class="menu-item-parent">Order</span></a>
				<ul>
					<li>
						<a href="/index.cfm/order.index">Order List</a>
					</li>
				</ul>
			</li>
			<li>
				<a id="liDashboard"  title="Dashboard" ><i class="fa fa-lg fa-fw fa-truck"></i> <span class="menu-item-parent">Shipments</span></a>
				<ul>
					<li>
						<a href="/index.cfm/shipment.index">Shipment List</a>
					</li>
					<li>
						<a href="/index.cfm/shipment.box-list">Box List</a>
					</li>
				</ul>
			</li>
			<li>
				<a id="liDashboard"  title="Dashboard" ><i class="fa fa-lg fa-fw fa-gears"></i> <span class="menu-item-parent">Admin</span></a>
				<ul>
					<li>
						<a href="/index.cfm/basicdata.factory">Factory</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.zone">Zone</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.agent">Agent</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.customer">Customer</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.contract">Contract</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.particular">Particular</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.user">User</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.roles">Role</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.language">Languages</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.currency">Currency</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.currency_convert">Currency Converter</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.zone-price">Zone Price</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.agent-price">Agent Price</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.type_customer">Type of Customer</a>
					</li>
					<!--- <li>
						<a href="/index.cfm/basicdata.access-level">Access Level</a>
					</li> --->
					<li>
						<a href="/index.cfm/basicdata.access-page">Access Pages</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.shipment-type">Shipment Types</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.freight">Freight</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.forwarder">Forwarder</a>
					</li>
					<li>
						<a href="/index.cfm/contact.contact">Contact</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.incoterm">Incoterm</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.box">Box</a>
					</li>
					<li>
						<a href="/index.cfm/basicdata.typeBox">Type of Box</a>
					</li>
				</ul>
			</li>

		<!---	<li>
				<a href="##"><i class="fa fa-lg fa-fw fa-bar-chart-o"></i> <span class="menu-item-parent">Order</span></a>
				<ul>
					<li>
						<a href="/index.cfm/order.oSearch">Search</a>
					</li>
					<li>
						<a href="/index.cfm/order.inputOrder">Input Order</a>
					</li>
					<li>
						<a href="/index.cfm/import.importOrder">Import Order</a>
					</li>
					<li>
						<a href="/index.cfm/order.evaluation">Evaluation</a>
					</li>
				</ul>
			</li>
			<li>
				<a href="##"><i class="fa fa-lg fa-fw fa-bar-chart-o"></i> <span class="menu-item-parent">Inspection</span></a>
				<ul>
					<!--- <li>
						<a href="/index.cfm/inspection.iSearch">Search</a>
					</li> --->
					<!--- <li>
						<a href="/index.cfm/inspection.inputInspection?schab=366">Input Inspection</a>
					</li> --->
					<li>
						<a href="/index.cfm/inspection.inspectionSchedule?reload=1">Inspection Schedule <!--- <span class="badge pull-right inbox-badge">21</span> ---></a>
					</li>
					<li>
						<a href="/index.cfm/inspection.evaluation">Evaluation</a>
					</li>
				</ul>
			</li>
			<li>
				<a href="##"><i class="fa fa-lg fa-fw fa-bar-chart-o"></i> <span class="menu-item-parent">Basic Data</span></a>
				<ul>
					<!--- <li>
						<a href="/index.cfm/inspectionplanning.list">Inspection Plan</a>
					</li> --->
					<li>
						<a href="/index.cfm/addressBook">General Address Book</a>
					</li>
					<li>
						<a href="#">User Management</a>
						<ul>
							<li >
								<a href="/index.cfm/userManagement/memberInfo" >Member Information</a>
							</li>
							<li >
								<a href="/index.cfm/userManagement/userAccount" >User Account Information</a>
							</li>
							<li >
								<a href="/index.cfm/userManagement/userGroup" >User Group</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="/index.cfm/product/items">Product Item</a>
					</li>
					<!--- <li>
						<a href="/index.cfm/product/lines">Product Line</a>
					</li> --->
					<li>
						<a href="/index.cfm/product/segments">Segment</a>
					</li>
					<li>
						<a href="/index.cfm/qadocuments">Q.A. Documents</a>
					</li>
					<li>
						<a href="/index.cfm/mistakeDictionary">Mistake Dictionary</a>
					</li>
					<li>
						<a href="/index.cfm/quality/aql">AQL</a>
					</li>
					<li>
						<a href="/index.cfm/quality/levels">QL</a>
					</li>
				</ul>
			</li> --->
		</ul>
	</nav>
	<div class="div_minifyme">
		<span class="minifyme" data-action="minifyMenu">
			<i class="fa fa-arrow-circle-left hit"></i>
		</span>
	</div>
</aside>

<!-- END NAVIGATION -->
