<style type="text/css">
.display-none{
	display: none;
}

.ws-date{
    width: 400px !important;
}
</style>
<section id="widget-grid" class="" ng-app="factory.list" ng-controller="BindAngularDirectiveCtrl as showCase">
	<!-- row -->
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Factory</h2>
				</header>
				<div>
					<!-- widget content -->
					<div class="widget-body">
						<div class="row">
							<div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-body">
											<legend class="fcollapsible" id="titleID">Create</legend>
											<div class="fcontent">
												<form class="form-horizontal"  name="userForm" ng-submit="showCase.submitForm()" novalidate>
													<input type="hidden" id="id_Factory" name="id_Factory" value="0" ng-model="showCase.user.uid">
													<div class="form-group" ng-class="{'has-error':userForm.fty_code.$invalid && !userForm.fty_code.$pristine}">
														<label class="col-md-3 control-label text-left"><b>Code</b></label>
														<div class="col-md-9">
															<input class="form-control" placeholder="" type="text" name="fty_code" id="code" ng-model="showCase.user.code" ng-pattern="showCase.regex"  required>
															<p ng-show="userForm.fty_code.$error.required && !userForm.fty_code.$pristine" class="help-block">Code is required</p>
			                                                <p ng-show="userForm.fty_code.$error.pattern  && !userForm.fty_code.$pristine" class="help-block">Can not enter special char</p>
			                                        	</div>
													</div>
													<div class="form-group" ng-class="{'has-error':userForm.description.$invalid && !userForm.description.$pristine}">
														<label class="col-md-3 control-label text-left"><b>Description</b></label>
														<div class="col-md-9">
															<input class="form-control" placeholder="" type="text" name="description" id="description" ng-model="showCase.user.description" required>
															<p ng-show="userForm.description.$error.required && !userForm.description.$pristine" class="help-block">Description is required</p>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error':userForm.currency.$invalid && !userForm.currency.$pristine}">
														<label class="control-label col-md-3 text-left"><b>Currency</b></label>
														<div class="col-md-9">
															<select ui-select2 id="currency" name="currency" ng-model="showCase.user.currency" data-placeholder="Choose" ng-required="true">
															    <option ng-repeat="lang in showCase.currencies" value="{{lang.id_currency}}">{{lang.curr_description}}</option>
															</select>
															<!--- <select class="form-control" id="currency" name="currency"  ng-model="showCase.user.currency" ng-options="cur.id_currency as cur.curr_description for cur in showCase.currencies" required>
																<option value="">Choose</option>
															</select> --->
															<!--- <p ng-show="userForm.currency.$invalid && !userForm.currency.$pristine" class="help-block">Please choose currency</p> --->
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error':userForm.language.$invalid && !userForm.language.$pristine}">
														<label class="control-label col-md-3 text-left"><b>Language</b></label>
														<div class="col-md-9">
															<select ui-select2 id="language" name="language" ng-model="showCase.user.language" data-placeholder="Choose" ng-required="true">
															    <option ng-repeat="lang in showCase.languages" value="{{lang.id_language}}">{{lang.lg_name}}</option>
															</select>
															<!--- <select class="form-control" id="language" name="language" ng-model="showCase.user.language" ng-options="lang.id_language as lang.lg_name for lang in showCase.languages" required>
																<option value="">Choose</option>
															</select> --->
															<p ng-show="userForm.language.$invalid && !userForm.language.$pristine" class="help-block">Please choose language</p>
														</div>
													</div>
													<div class="form-group">
														<label class="col-md-3 control-label text-left"><b>Contact</b></label>
														<div class="col-md-5">
															<input class="form-control" readonly placeholder="" type="text" name="contact" id="contact" ng-model="showCase.user.contact" required>
														</div>
														<div class="col-md-3">
		                                                    <button id="createContact" type="button" class="btn btn-block bg-color-blueDark txt-color-white" data-toggle="modal" data-target="#myModalContact">Add Contact</button>
		                                                    <button id="editContact" type="button" class="btn btn-block bg-color-blueDark txt-color-white" ng-click="showCase.editRowContact()">Edit Contact</button>
		                                                </div>
													</div>
													<div class="form-group text-center">
														<div class="col-md-3"></div>
														 <div class="col-md-7">
															<button class="btn bg-color-blueDark txt-color-white" id="btnAddRow" ng-click="showCase.addRow()" ng-disabled="userForm.$invalid" >
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
								</div>
							</div>
							<div class="row width-table-content">
								<fieldset>
									<div class="btn col-md-2 col-md-offset-10 bg-color-blueDark txt-color-white" id="btnAddNew" ng-click="showCase.showAddNew()" style="display:none">
                                        <i class="fa fa-save"></i>&nbsp;Create
                                    </div>
									<div class="fcontent">
										<table id="mytable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance">
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
	<div id="myModalContact" class="modal fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" tabindex="-1">
		<supplier-Contact></supplier-Contact>
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
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/dataTables.select.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/factory.list.js"></script>
<script src="/includes/js/views/formcontact.list.js"></script>