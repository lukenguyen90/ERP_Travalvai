<section id="widget-grid" class="" ng-app="product.List" ng-controller="BindAngularDirectiveCtrl as showCase">
	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Product Status</h2>

				</header>

				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body">
						
						<div class="row">
							<div class="col-md-6">
								<legend class="fcollapsible">Product Status Detail</legend>
								<div class="fcontent">
									<form class="form-horizontal" ng-submit="showCase.submitForm()" name="userForm">
										<input type='hidden' name="id_Status" id="id_Status" value="0">
										<div class="form-group" ng-class="{'has-error':userForm.description.$invalid && !userForm.description.$pristine}">
											<label class="col-md-3 control-label tex-left">Product Status</label>
											<div class="col-md-9">
												<!--- <input class="form-control" placeholder="" type="text" name=""> --->
												<input class="form-control" placeholder="" type="text" name="description" id="description" ng-model="showCase.user.description" ng-pattern="showCase.regex"  required>
                                                <p ng-show="userForm.description.$error.required && !userForm.description.$pristine" class="help-block">Description is required</p>
                                                <p ng-show="userForm.description.$error.pattern  && !userForm.description.$pristine" class="help-block">Can not enter special char</p>
											</div>
										</div>
										<div class="form-group text-center">
											<button class="btn bg-color-blueDark txt-color-white" id="complete_report" ng-disabled="userForm.$invalid" ng-click="showCase.addRow()">
												<i class="fa fa-save"></i>
												&nbsp;Add/Update
											</button>
											<button class="btn btn-default" id="" ng-click="showCase.refresh()">
												<i class="fa fa-refresh"></i>
												&nbsp;Refresh
											</button>
										</div>
									</form>
								</div>		
							</div>
							<div class="col-md-6">
								<fieldset>
									<legend class="fcollapsible">Product Status List</legend>

									<div class="fcontent">
										<table id="datatable_fixed_column" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance">
                                        </table>	
										
										<!--- <table id="datatable_fixed_column" dt-columns="showCase.dtColumns" class="table table-striped table-bordered" width="100%">
					
									        <thead>
												<tr>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter No. " />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Product Status" />
													</th>
													<th></th>									
												</tr>
									            <tr>
								                    <th style="width: 10%">No.</th>
													<th>Product Line</th>
													<th style="width: 8%"></th>
									            </tr>
									        </thead>
											<tbody>
																			
											</tbody>
										</table> --->
											
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
<script src="/includes/js/jquery.dataTables.min.js?v=#application.version#"></script>
<script src="/includes/js/dataTables.select.min.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.min.js?v=#application.version#"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js?v=#application.version#"></script>
<script src="/includes/js/views/product.status.js?v=#application.version#"></script>
</cfoutput>