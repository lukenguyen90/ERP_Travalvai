<style type="text/css">
	.select2-container{
		width:100%;
	}
</style>
<section id="widget-grid" class="" ng-app="agent.price" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
	<!-- row -->
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Agent Price</h2>
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
													<div class="form-group">
														<label class="col-md-3 control-label text-left"><b>Agent</b></label>
														<div class="col-md-5">
															<select ui-select2 name="agent" id="agent" ng-model="showCase.user.agent" required>
																<option value="">Choose</option>
																<option ng-repeat="agent in showCase.agents" value="{{agent.ID}}">{{agent.DES}}</option>
															</select>
														</div>
													</div>
													<div class="form-group">
														<label class="col-md-3 control-label text-left"><b>Code</b></label>
														<div class="col-md-5">
															<input type="hidden" value="0" id="id_pagent"/>
															<input class="form-control" placeholder="" type="text" name="code" id="code" ng-model="showCase.user.code" readonly>
														</div>
													</div>
													<div class="form-group">
														<label class="col-md-3 control-label text-left"><b>Description</b></label>
														<div class="col-md-5">
															<input class="form-control" placeholder="" type="text" name="description" id="description" value="" ng-model="showCase.user.description" readonly>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error':userForm.fdate.$invalid && !userForm.fdate.$pristine}">
														<label class="col-md-3 control-label text-left"><b>From Date</b></label>
														<div class="col-md-5">
															<input class="form-control" placeholder="" type="text" name="fdate" id="fdate" value="" ng-model="showCase.user.fdate" required>
															<p ng-show="userForm.fdate.$invalid && !userForm.fdate.$pristine" class="help-block">From Date invalid</p>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error':userForm.todate.$invalid && !userForm.todate.$pristine}">
														<label class="col-md-3 control-label text-left"><b>To Date</b></label>
														<div class="col-md-5">
															<input class="form-control" placeholder="" type="text" name="todate" id="toDate" ng-model="showCase.user.todate" required>
															<p ng-show="userForm.todate.$invalid && !userForm.todate.$pristine" class="help-block">To Date invalid</p>
														</div>
													</div>
													<div class="form-group">
														<label class="control-label col-md-3 text-left"><b>Price List</b></label>
														<div class="col-md-5">
															<select ui-select2 id="priceList" name="plz" ng-model="showCase.user.plz" required>
																<option>Choose Price List</option>
																<option ng-repeat="plz in showCase.plzs" value="{{plz.id_plz}}">{{plz.plz_code}}</option>
															</select>
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
								<fieldset>
									<div class="fcontent">
										<div>
											<div class="col-md-12">
												<button class="btn bg-color-blueDark txt-color-white pull-right" id="btnShowAddAgentPrice" ng-click="showCase.showAddAgentPricePopup()">
															<i class="fa fa-save"></i>
															Add Agent Price
												</button>
											</div>
										</div>
										<div>
											<div class="col-md-12">
												<table id="mytable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance">
												</table>
											</div>
										<div>
									</div>
								</fieldset>
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
                    <!--- <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">#getLabel('Close')#</span></button> --->
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
<script src="/includes/js/views/agent.price.js?v=#application.version#"></script>
</cfoutput>
<script type="text/javascript">
	$(document).ready(function(){
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