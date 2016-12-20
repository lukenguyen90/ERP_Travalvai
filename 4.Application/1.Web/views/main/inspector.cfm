<section id="widget-grid" class="">
	<div class="row">
		<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
			<h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-home"></i> Dashboard <span>> My Dashboard</span></h1>
		</div>
		<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8">
			<ul id="sparks" class="">
				<li class="sparks-info">
					<a href="/index.cfm/order.oSearch" >
					<h5> Pending Orders <span class="txt-color-greenDark"><i class="fa fa-th-list"></i>&nbsp;2447</span></h5>
					<!--- <div class="sparkline txt-color-greenDark hidden-mobile hidden-md hidden-sm">
						110,150,300,130,400,240,220,310,220,300, 270, 210
					</div> --->
					</a>
				</li>
				<li class="sparks-info">
					<span class="txt-color-greenDark">
						<select class="select2" style="width: 100%"> 
			    			<option value="0" >AXA International Ltd</option>
			    			<option value="0" >ABDOOLALLY EBRAHIM</option>
			    			<option value="0" >FAIRKEEP LTD</option>
			    			<option value="0" >SAGITTARIANS</option>
			    			<option value="0" >TAE YANG VINA CO.</option>
			    			<option value="0" >HONG IK VINA CO</option>
						</select>
					</span>
				</li>
			</ul>
		</div>
	</div>
	<div class="row">
		<article class="col-xs-12 col-sm-12 col-md-6 col-lg-6">

			<!-- new widget -->
			<div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false" data-widget-fullscreenbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-comments txt-color-white"></i> </span>
					<h2> Notifications </h2>
					<div class="widget-toolbar">
						<!-- add: non-hidden - to disable auto hide -->

						
					</div>
				</header>

				<!-- widget div-->
				<div>
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<div>
							<label>Title:</label>
							<input type="text" />
						</div>
					</div>
					<!-- end widget edit box -->

					<div class="widget-body widget-hide-overflow no-padding">
						<!-- content goes here -->

						<!-- CHAT BODY -->
						<div id="chat-body" class="chat-body custom-scroll" >
							<ul>
								<li class="message">
									<img src="/assets/img/avatars/male.png" class="online" alt="">
									<div class="message-text">
										<time>
											01 Nov 2015
										</time> <a href="javascript:void(0);" class="username">System</a> Missing master data
										<p class="chat-file row">
											<b class="pull-left"> Object: Product item. Data: 12345-678-9 </b>
											<span class="col-sm-6 pull-right"><a href="javascript:void(0);" class="btn btn-xs btn-success">delete</a> </span>
										</p>
										<p class="chat-file row">
											<b class="pull-left"> Object: Product item. Data: 45782-482-0 </b>
											<span class="col-sm-6 pull-right"><a href="javascript:void(0);" class="btn btn-xs btn-success">delete</a> </span>
										</p>
										<p class="chat-file row">
											<b class="pull-left"> Object: Customer Nr. Data: 4651 </b>
											<span class="col-sm-6 pull-right"><a href="javascript:void(0);" class="btn btn-xs btn-success">delete</a> </span>
										</p>
										<p class="chat-file row">
											<b class="pull-left"> Object: Supplier Nr. Data: 8659 </b>
											<span class="col-sm-6 pull-right"><a href="javascript:void(0);" class="btn btn-xs btn-success">delete</a> </span>
										</p>
										
										  </div>
								</li>
								 
							</ul>

						</div>

						<!-- CHAT FOOTER -->
						<div class="chat-footer">

							<!-- CHAT TEXTAREA -->
							<div class="textarea-div">

								<div class="typearea">
									<textarea placeholder="Write a reply..." id="textarea-expand" class="custom-scroll"></textarea>
								</div>

							</div>

							<!-- CHAT REPLY/SEND -->
							<span class="textarea-controls">
								<button class="btn btn-sm btn-primary pull-right">
									Send
								</button> 
								<span class="pull-right smart-form" style="margin-top: 3px; margin-right: 10px;"> 
									<label class="checkbox pull-right">
										<input type="checkbox" name="subscription" id="subscription">
										<i></i>Press <strong> ENTER </strong> to send 
									</label> 
								</span> 
								<a href="javascript:void(0);" class="pull-left"><i class="fa fa-camera fa-fw fa-lg"></i></a> 
							</span>

						</div>

						<!-- end content -->
					</div>

				</div>
				<!-- end widget div -->
			</div>
			<!-- end widget -->

		</article>

		<article class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
		<!-- new widget -->
			<div class="jarviswidget" id="wid-id-1" data-widget-colorbutton="false">

				<!-- widget options:
				usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">

				data-widget-colorbutton="false"
				data-widget-editbutton="false"
				data-widget-togglebutton="false"
				data-widget-deletebutton="false"
				data-widget-fullscreenbutton="false"
				data-widget-custombutton="false"
				data-widget-collapsed="true"
				data-widget-sortable="false"

				-->
				<header>
					<span class="widget-icon"> <i class="fa fa-calendar"></i> </span>
					<h2> Work Schedule </h2>
					<div class="widget-toolbar">
						<!-- add: non-hidden - to disable auto hide -->
						<div class="btn-group">
							<button class="btn dropdown-toggle btn-xs btn-default" data-toggle="dropdown">
								Showing <i class="fa fa-caret-down"></i>
							</button>
							<ul class="dropdown-menu js-status-update pull-right">
								<li>
									<a href="javascript:void(0);" id="mt">Month</a>
								</li>
								<li>
									<a href="javascript:void(0);" id="ag">Agenda</a>
								</li>
								<li>
									<a href="javascript:void(0);" id="td">Today</a>
								</li>
							</ul>
						</div>
					</div>
				</header>

				<!-- widget div-->
				<div>
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">

						<input class="form-control" type="text">

					</div>
					<!-- end widget edit box -->

					<div class="widget-body no-padding">
						<!-- content goes here -->
						<div class="widget-body-toolbar">

							<div id="calendar-buttons">

								<div class="btn-group">
									<a href="javascript:void(0)" class="btn btn-default btn-xs" id="btn-prev"><i class="fa fa-chevron-left"></i></a>
									<a href="javascript:void(0)" class="btn btn-default btn-xs" id="btn-next"><i class="fa fa-chevron-right"></i></a>
								</div>
							</div>
						</div>
						<div id="calendar"></div>

						<!-- end content -->
					</div>

				</div>
				<!-- end widget div -->
			</div>
			<!-- end widget -->

		</article>
	</div>
	<div class="row">
		<article class="col-xs-12 col-sm-12 col-md-6 col-lg-6">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget" id="wid-id-2" data-widget-editbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-bar-chart-o"></i> </span>
					<h2>Status of Delay shipment days (9/2015 - 12/2015)</h2>

				</header>

				<!-- widget div-->
				<div>

					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body no-padding">
						
						<div id="shipment-status-lastmonth" class="solidgauge"></div>

					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

			</div>
			<!-- end widget -->

		</article>

		<article class="col-xs-12 col-sm-12 col-md-6 col-lg-6">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget" id="wid-id-3" data-widget-editbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-bar-chart-o"></i> </span>
					<h2>Status of Rejected orders (9/2015 - 12/2015)</h2>

				</header>

				<!-- widget div-->
				<div>

					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body no-padding">
						
						<div id="rejected-status-lastmonth" class="solidgauge"></div>

					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

			</div>
			<!-- end widget -->

		</article>


		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget" id="wid-id-4" data-widget-editbutton="false">
	 
				<header>
					<span class="widget-icon"> <i class="fa fa-bar-chart-o"></i> </span>
					<h2>Accepted and rejected status of AXA International Ltd company (9/2015-12/2015)</h2>

				</header>

				<!-- widget div-->
				<div>

					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body no-padding">

						<div id="compination-inspection-quantity" class="chart" style="min-width: 310px; height: 400px; margin: 0 auto"></div>

					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

			</div>
			<!-- end widget -->
		</article>
	</div>

	<div class="row">
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget" id="wid-id-5" data-widget-editbutton="false">
	 
				<header>
					<span class="widget-icon"> <i class="fa fa-bar-chart-o"></i> </span>
					<h2>Rejected status of AXA International Ltd company in 2015</h2>

				</header>

				<!-- widget div-->
				<div>

					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body no-padding">

						<div id="compination-rejected-quantity" class="chart" style="min-width: 310px; height: 400px; margin: 0 auto"></div>

					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

			</div>
			<!-- end widget -->
		</article>
	</div>

</section>		


<script src="/assets/js/highchart/highcharts.js"></script>
<script src="/assets/js/highchart/highcharts-more.js"></script>
<script src="/assets/js/highchart/exporting.js"></script>

<script src="/assets/js/highchart/solid-gauge.js"></script>

<!-- Full Calendar -->
<script src="/assets/js/plugin/moment/moment.min.js"></script>
<script src="/assets/js/plugin/fullcalendar/jquery.fullcalendar.min.js"></script>

<script src="/assets/js/views/main.inspector.js"></script>
