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
	<cfoutput>
		<nav>
			<ul>
				 <li>
					<a id="liDashboard"  title="Dashboard" ><i class="fa fa-lg fa-fw fa-cube"></i> <span class="menu-item-parent">#getResource('products')#</span></a>
					<ul>
						<li>
							<a href="/index.cfm/product.index">#getResource('productlist')#</a>
						</li>
						<li>
							<a href="/index.cfm/product.status">#getResource('productstatus')#</a>
						</li>
						<li>
							<a href="/index.cfm/patterns.index">#getResource('patternlist')#</a>
						</li>
						<li>
							<a href="/index.cfm/size.index">#getResource('sizelist')#</a>
						</li>
					</ul>
				</li>

				 <li>
					<a id="liDashboard"  title="Dashboard" ><i class="fa fa-lg fa-fw fa-cubes"></i> <span class="menu-item-parent">#getResource('projects')#</span></a>
					<ul>
						<li>
							<a href="/index.cfm/project.index">#getResource('projectlist')#</a>
						</li>
						<li>
							<a href="/index.cfm/project.status">#getResource('projectstatus')#</a>
						</li>
					</ul>
				</li>

				 <li>
					<a id="liDashboard"  title="Dashboard" ><i class="fa fa-lg fa-fw fa-usd"></i> <span class="menu-item-parent">#getResource('costing')#</span></a>
					<ul>
						<li>
							<a href="/index.cfm/cost.index">#getResource('costlist')#</a>
						</li>
						<li>
							<a href="/index.cfm/material.index">#getResource('materiallist')#</a>
						</li>
						<li>
							<a href="/index.cfm/product.group">#getResource('groupofproduct')#</a>
						</li>
						<li>
							<a href="/index.cfm/product.type">#getResource('typeofproduct')#</a>
						</li>
					</ul>
				</li>
				<li>
					<a id="liDashboard"  title="Dashboard" ><i class="fa fa-lg fa-fw fa-usd"></i> <span class="menu-item-parent">#getResource('pricelists')#</span></a>
					<ul>
						<li>
							<a href="/index.cfm/basicdata.price_list_factory">#getResource('pricelistfactory')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.price_list_zone">#getResource('pricelistzone')#</a>
						</li>
					</ul>
				</li>
				<li>
					<a id="liDashboard"  title="Dashboard" ><i class="fa fa-lg fa-fw fa-shopping-cart"></i> <span class="menu-item-parent">#getResource('order')#</span></a>
					<ul>
						<li>
							<a href="/index.cfm/order.order-list.cfm">#getResource('orderlist')#</a>
						</li>
					</ul>
				</li>
				<li>
					<a id="liDashboard"  title="Dashboard" ><i class="fa fa-lg fa-fw fa-truck"></i> <span class="menu-item-parent">#getResource('shipments')#</span></a>
					<ul>
						<li>
							<a href="/index.cfm/shipment.shipment-list.cfm">#getResource('shipmentlist')#</a>
						</li>
					</ul>
				</li>
				<li>
					<a id="liDashboard"  title="Dashboard" ><i class="fa fa-lg fa-fw fa-gears"></i> <span class="menu-item-parent">#getResource('admin')#</span></a>
					<ul>
						<li>
							<a href="/index.cfm/basicdata.factory">#getResource('factory')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.zone">#getResource('zone')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.agent">#getResource('agent')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.customer">#getResource('customer')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.contract">#getResource('contract')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.particular">#getResource('particular')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.user">#getResource('user')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.roles">#getResource('role')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.language">#getResource('languages')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.currency">#getResource('currency')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.currency_convert">#getResource('currencyconverter')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.zone-price">#getResource('zoneprice')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.agent-price">#getResource('agentprice')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.type_customer">#getResource('typeofcustomer')#</a>
						</li>
						<!--- <li>
							<a href="/index.cfm/basicdata.access-level">Access Level</a>
						</li> --->
						<li>
							<a href="/index.cfm/basicdata.access-page">#getResource('accesspages')#</a>
						</li>
						<!--- <li>
							<a href="/index.cfm/basicdata.shipment-type">#getResource('shipmenttypes')#</a>
						</li>
						<li>
							<a href="/index.cfm/basicdata.freight">#getResource('freight')#</a>
						</li> --->
						<li>
							<a href="/index.cfm/basicdata.forwarder">#getResource('forwarder')#</a>
						</li>
						<li>
							<a href="/index.cfm/contact.contact">#getResource('contact')#</a>
						</li>
						<!--- <li>
							<a href="/index.cfm/basicdata.incoterm">#getResource('incoterm')#</a>
						</li> --->
						<li>
							<a href="/index.cfm/basicdata.box">#getResource('box')#</a>
						</li>
						<!--- <li>
							<a href="/index.cfm/basicdata.typeBox">#getResource('typeofbox')#</a>
						</li> --->
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
	</cfoutput>
	<div class="div_minifyme">
		<span class="minifyme" data-action="minifyMenu">
			<i class="fa fa-arrow-circle-left hit"></i>
		</span>
	</div>
</aside>

<!-- END NAVIGATION -->
