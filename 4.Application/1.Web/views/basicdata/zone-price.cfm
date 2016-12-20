<style type="text/css">
	.select2-container{
		width:100%;
	}
</style>
<section id="widget-grid" class="" ng-app="zone.price" ng-controller="BindAngularDirectiveCtrl as showCase">
	<!-- row -->
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Zone Price</h2>
				</header>
				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body">
						<div class="row">
							<div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-body">
											<legend class="fcollapsible" id="titleID">Create</legend>
											<div class="fcontent">
												<form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
													<div class="form-group" ng-class="{'has-error':userForm.zone.$invalid && !userForm.zone.$pristine}">
														<label class="col-md-3 control-label text-left"><b>Zone</b></label>
														<div class="col-md-6">
															<input type="hidden" value="0" id="zone_price"/>
															<select ui-select2 id="zone" name="zone" ng-model="showCase.user.zone" required>
																<option value="">Choose Zone</option>
																<option ng-repeat="zone in showCase.zones" value="{{zone.ID}}">{{zone.CODE}}</option>
															</select>
															<p ng-show="userForm.zone.$invalid && !userForm.zone.$pristine" class="help-block">Please choose zone</p>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error':userForm.fdate.$invalid && !userForm.fdate.$pristine}">
														<label class="col-md-3 control-label text-left"><b>From Date</b></label>
														<div class="col-md-6">
															<input class="form-control" placeholder="" type="text" name="fdate" id="fdate" value="" ng-model="showCase.user.fdate" required>
															<p ng-show="userForm.fdate.$invalid && !userForm.fdate.$pristine" class="help-block">From Date invalid</p>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error':userForm.todate.$invalid && !userForm.todate.$pristine}">
														<label class="col-md-3 control-label text-left"><b>To Date</b></label>
														<div class="col-md-6">
															<input class="form-control" placeholder="" type="text" name="todate" id="toDate" ng-model="showCase.user.todate" required>
															<p ng-show="userForm.todate.$invalid && !userForm.todate.$pristine" class="help-block">To Date invalid</p>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error':userForm.priceList.$invalid && !userForm.priceList.$pristine}">
														<label class="control-label col-md-3 text-left"><b>Price List</b></label>
														<div class="col-md-6">
															<select ui-select2 id="priceList" name="plf" ng-model="showCase.user.plf" required="true">
																<option value="">Choose Price List</option>
																<option ng-repeat="plf in showCase.plfs" value="{{plf.ID}}">{{plf.CODE}}</option>
															</select>
															<p ng-show="userForm.priceList.$invalid && !userForm.priceList.$pristine" class="help-block">Please choose price list</p>
														</div>
													</div>
													<div class="form-group text-center" >
														<button class="btn bg-color-blueDark txt-color-white" id="btnAddRow" ng-click="showCase.addRow()" ng-disabled="userForm.$invalid">
															<i class="fa fa-save"></i>
															&nbsp;Add/Update
														</button>
														<button class="btn btn-default" id="btnRefresh" ng-click="showCase.refresh()">
															<i class="fa fa-refresh"></i>
															&nbsp;Refresh
														</button>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row width-table-content">

									<div class="fcontent">
										<div>
											<div class="col-md-12">
												<button class="btn bg-color-blueDark txt-color-white pull-right" id="btnShowAddZonePrice" ng-click="showCase.showAddZonePricePopup()">
															<i class="fa fa-save"></i>
															Add Zone Price
												</button>
											</div>
										</div>
										<div>
											<div class="col-md-12">
												<table id="datatable_fixed_column" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance">
												</table>
											</div>
										<div>
									</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</article>
	</div>
	<div class="modal fade" id="showDelete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
        <div class="modal-dialog" id="modalForm">
            <div class="modal-content">
                <div class="modal-header alert-info">
                    <h3 class="modal-title" id="myModalLabel">Are you sure you want to delete this item?</h3>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                    <button type="submit" id="butsubmit" class="btn btn-info" ng-click="showCase.deleteUser()">Yes</button>
                </div>
            </div>
        </div>
    </div>

</section>
<cfoutput>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/zone.price.js?v=#application.version#"></script>
</cfoutput>
<script type="text/javascript">
	$(document).ready(function() {
		$("#fdate").datepicker({
	      changeMonth: true,
	      changeYear: true,
	      dateFormat: "dd/mm/yy"
	    });
		$("#toDate").datepicker({
	      changeMonth: true,
	      changeYear: true,
	      dateFormat: "dd/mm/yy"
	    });
	});
</script>
