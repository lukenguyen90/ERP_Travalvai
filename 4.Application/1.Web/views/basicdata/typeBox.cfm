<script type="text/javascript">
	function keypress(){
		 if (window.event.keyCode < 48 || 57 < window.event.keyCode)
 		//nếu phím không phải là số thì bỏ đi
 		window.event.keyCode = 0
	}
</script>
<section id="widget-grid" class="" ng-app="box.type" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
	<!-- row -->
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Type Box</h2>
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
														<label class="col-md-2 control-label text-left"><b>Code</b></label>
														<div class="col-md-10">
															<input type="hidden" id="id_type_box" value="0">
															<input class="form-control" placeholder="" type="text" name="tb_description" id="tb_description" ng-model="showCase.user.tb_description">
														</div>
													</div>
													<div class="form-group">
														<label class="col-md-2 control-label text-left"><b>Depth</b></label>
														<div class="col-md-2">
															<input class="form-control" type="number" min="1" name="tb_depth" id="tb_depth" ng-model="showCase.user.tb_depth" onkeydown="keypress()">
														</div>
														<label class="col-md-2 control-label text-left"><b>Length</b></label>
														<div class="col-md-2">
															<input class="form-control" type="number" min="1" name="tb_length" id="tb_length" ng-model="showCase.user.tb_length">
														</div>
														<label class="col-md-2 control-label text-left"><b>Width</b></label>
														<div class="col-md-2">
															<input class="form-control" type="number" min="1" name="tb_width" id="tb_width" ng-model="showCase.user.tb_width">
														</div>
													</div>
													<div class="form-group text-center">
														<button class="btn bg-color-blueDark txt-color-white" id="btnAddRow" ng-click="showCase.addRow()">
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
									<button class="btn col-md-2 col-md-offset-10 bg-color-blueDark txt-color-white" id="btnAddNew" ng-click="showCase.showAddNew()" style="display:none">
                                        <i class="fa fa-save"></i>&nbsp;Create
                                    </button>
									<div class="fcontent">	
										<table id="datatable_fixed_column" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance">
										</table>											
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
<script src="/includes/js/dataTables.select.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/angular-datatables.columnfilter.min.js"></script>
<script src="/includes/js/views/box.type.js?v=#application.version#"></script>
</cfoutput>

