<section id="widget-grid"  ng-app='size.List' ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
	<!-- row -->
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Sizes</h2>
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
												<form class="form-horizontal" name="sizeForm" ng-submit="showCase.submitForm()" novalidate>
													<input class="form-control" placeholder="" type="hidden" id="sizeId" value="0">
													<div class="form-group" ng-class="{'has-error':sizeForm.sz_des.$invalid && !sizeForm.sz_des.$pristine}">
						                                <label class="col-md-3 control-label text-left"><b>Description</b></label>
						                                <div class="col-md-5">
						                                    <input class="form-control" placeholder="" type="text" name="sz_des" id="sz_des" ng-model="showCase.size.sz_des" required>
						                                    <p ng-show="sizeForm.sz_des.$error.required && !sizeForm.sz_des.$pristine" class="help-block">Description is required</p>
						                                </div>
						                            </div>
						                            <div class="form-group" ng-class="{'has-error':sizeForm.sz_qtty.$invalid && !sizeForm.sz_qtty.$pristine}">
						                                <label class="col-md-3 control-label text-left"><b>QTTY</b></label>
						                                <div class="col-md-5">
						                                    <input class="form-control" placeholder="" type="number" name="sz_qtty" id="sz_qtty" ng-model="showCase.size.sz_qtty" required>
						                                    <p ng-show="sizeForm.sz_qtty.$error.required && !sizeForm.sz_qtty.$pristine" class="help-block">Quatity is required</p>
						                                </div>
						                            </div>
													<div class="form-group text-center">
														<button class="btn bg-color-blueDark txt-color-white" id="btnsave" ng-click="showCase.insertData()" ng-disabled="sizeForm.$invalid">
															<i class="fa fa-save"></i>
															&nbsp;Save
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
									<div class="btn col-md-2 col-md-offset-10 bg-color-blueDark txt-color-white" id="btnAddNew" ng-click="showCase.showAddNew()">
                                        <i class="fa fa-save"></i>&nbsp;Create
                                	</div>
									<div class="fcontent">
                                    	<table id="sizesviewTable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptionsSizesViewTable" dt-columns="showCase.dtColumnsSizesViewTable" dt-instance="showCase.dtInstance">
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
					<!--- <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">#getLabel('Close')#</span></button> --->
					<h3 class="modal-title" id="myModalLabel">Are you sure you want to delete this item?</h3>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
					<button type="submit" id="butsubmit" class="btn btn-info" ng-click="showCase.deleteSize()">Yes</button>
				</div>
			</div>
		</div>
	</div>
</section>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.select.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/size.main.js"></script>