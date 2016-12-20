<style type="text/css">
.display-none{
	display: none;
}

.ws-date{
    width: 400px !important;
}
</style>
<section id="widget-grid" class="" ng-app="particular.List" ng-controller="BindAngularDirectiveCtrl as showCase">
	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Particular</h2>
				</header>
				<!-- widget div-->
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
													<input type='hidden' name="id_Particular" id="id_Particular" value="0">
													<div class="form-group">
														<label class="col-md-3 control-label text-left"><b>Code</b></label>
														<div class="col-md-5">
															<input class="form-control" placeholder="" ng-model="showCase.user.code" type="text" name="code" id="code" readonly>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error':userForm.name.$invalid && !userForm.name.$pristine}">
				                                        <label class="col-md-3 control-label text-left"><b>Name</b></label>
				                                        <div class="col-md-5">
				                                            <input class="form-control" placeholder="" type="text" name="name" id="name" ng-model="showCase.user.name" ng-pattern="showCase.regex"  required>
				                                                <p ng-show="userForm.name.$error.required && !userForm.name.$pristine" class="help-block">Name is required</p>
				                                                <p ng-show="userForm.name.$error.pattern  && !userForm.name.$pristine" class="help-block">Can not enter special char</p>
				                                        </div>
				                                    </div>
				                                    <div class="form-group" ng-class="{'has-error':userForm.dni.$invalid && !userForm.dni.$pristine}">
				                                        <label class="col-md-3 control-label text-left"><b>DNI</b></label>
				                                        <div class="col-md-5">
				                                            <input class="form-control" placeholder="" type="text" name="dni" id="dni" ng-model="showCase.user.dni" ng-pattern="showCase.regex"  required>
				                                                <p ng-show="userForm.dni.$error.required && !userForm.dni.$pristine" class="help-block">DNI is required</p>
				                                                <p ng-show="userForm.dni.$error.pattern  && !userForm.dni.$pristine" class="help-block">Can not enter special char</p>
				                                        </div>
				                                    </div>
				                                    <div class="form-group" ng-class="{'has-error':userForm.password.$invalid && !userForm.password.$pristine}">
				                                        <label class="col-md-3 control-label text-left"><b>Password</b></label>
				                                        <div class="col-md-5">
				                                            <input class="form-control" placeholder="" type="text" name="password" id="password" ng-model="showCase.user.password" required>
				                                                <p ng-show="userForm.password.$error.required && !userForm.password.$pristine" class="help-block">Password is required</p>
				                                                <p ng-show="userForm.password.$error.pattern  && !userForm.password.$pristine" class="help-block">Can not enter special char</p>
				                                        </div>
				                                    </div>

				                                    <div class="form-group" ng-class="{'has-error':userForm.mail.$invalid && !userForm.mail.$pristine}">
				                                        <label class="col-md-3 control-label text-left"><b>Email</b></label>
				                                        <div class="col-md-5">
				                                            <input class="form-control" placeholder="" type="text" name="mail" id="mail" ng-model="showCase.user.mail" ng-pattern="showCase.regex_email" required>
				                                                <p ng-show="userForm.mail.$error.required && !userForm.mail.$pristine" class="help-block">Email is required</p>
				                                                <p ng-show="userForm.mail.$error.pattern  && !userForm.mail.$pristine" class="help-block">Email not valid</p>
				                                        </div>
				                                    </div>
													<div class="form-group" ng-class="{'has-error':userForm.customer.$invalid && !userForm.customer.$pristine}">
														<label class="control-label col-md-3 text-left"><b>Customer</b></label>
														<div class="col-md-5">
															<select class="form-control" id="customer" name="customer" ng-model="showCase.user.customerID" ng-options="lang.ID as lang.NAME for lang in showCase.customers" required>
																<option value="">Choose</option>
															</select>
															<p ng-show="userForm.customer.$invalid && !userForm.customer.$pristine" class="help-block">Please choose customer</p>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error':userForm.language.$invalid && !userForm.language.$pristine}">
														<label class="control-label col-md-3 text-left"><b>Language</b></label>
														<div class="col-md-5">
															<select class="form-control" id="language" name="language" ng-model="showCase.user.languageID" ng-options="lang.id_language as lang.lg_name for lang in showCase.languages" required>
																<option value="">Choose</option>
															</select>
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
														<div class="col-md-12">
															<button class="btn bg-color-blueDark txt-color-white" id="btnAddRow" ng-disabled="userForm.$invalid" ng-click="showCase.addRow()">
																<i class="fa fa-save"  ></i>
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
							<div class="col-md-1"></div>
							<div class="col-md-10">
								<fieldset>
									<div class="btn col-md-2 col-md-offset-10 bg-color-blueDark txt-color-white" id="btnAddRow" ng-click="showCase.showAddNew()">
                                        <i class="fa fa-save"></i>&nbsp;Create
                                    </div>
									<div class="fcontent">
										<table id="mytable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance">
                                        </table>
									</div>
								</fieldset>
							</div>
							<div class="col-md-1"></div>
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
	<div id="myModalContact" class="modal fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" tabindex="-1">
		<supplier-Contact></supplier-Contact>
    </div>
</div>
</section>
<cfoutput>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/dataTables.select.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/particular.list.js"></script>
<script src="/includes/js/views/formcontact.list.js?v=#application.version#"></script>
</cfoutput>