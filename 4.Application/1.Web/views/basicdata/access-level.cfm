<style type="text/css">
	.padding-td{
		padding-top: 4px;
		/*border-bottom: 1px solid #000;*/
	}
</style>
<section id="widget-grid" class="" ng-app="access_level" ng-controller="BindAngularDirectiveCtrl as showCase">
	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Access Level</h2>

				</header>

				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body">
						<form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
							<div class="row" style="">
								<div class="col-md-1" style="margin-top:8px;">
									<table>
										<thead>
											<tr>
												<td style="font-weight: bold;">Roles</td>
											</tr>
										</thead>
										<tbody>
											<tr ng-repeat="person in showCase.persons">
												<th  class="padding-td">{{person.name}}</th>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="col-md-11">
									<table width="100%" datatable="ng" dt-options="showCase.dtOptions" class="row-border hover">
								        <thead>
								        <tr>
								            <th ng-repeat="name in showCase.nameright" style="text-align:center">{{name.name}}</th>
								        </tr>
								        </thead>
								        <tbody>
								        <tr ng-repeat="person in showCase.persons" style="border-bottom:1px solid #000; border-right:1px solid #000; text-align: center;">
								            <td ng-repeat="subperson in person.right" style="border-right:1px solid #000">
								            	<input type="checkbox" ng-model="subperson.right.open" ng-checked="{{subperson.right.open}}" ng-click="showCase.myCheckboxClick($event)">open
								            	<input type="checkbox" ng-model="subperson.right.edit" ng-checked="{{subperson.right.edit}}" ng-click="showCase.myCheckboxClick($event)">edit
								            	<input type="checkbox" ng-model="subperson.right.delete" ng-checked="{{subperson.right.delete}}" ng-click="showCase.myCheckboxClick($event)">delete
								            </td>
								        </tr>
								        </tbody>
								    </table>
							    </div>
							</div>
							<div class="row">
								<div class="col-md-3"></div>
								<div class="col-md-7">
									<button class="btn bg-color-blueDark txt-color-white" id="btnAddRow"  ng-click="showCase.addRow()">
										<i class="fa fa-save"></i>
										&nbsp;Add/Update
									</button>
									<button class="btn btn-default" id="btnRefresh" ng-click="showCase.refresh()">
										<i class="fa fa-refresh"></i>
										&nbsp;Refresh
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</article>
	</div>
</section>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/angular-datatables.scroller.min.js"></script>
<script src="/includes/js/views/access_level.js"></script>
