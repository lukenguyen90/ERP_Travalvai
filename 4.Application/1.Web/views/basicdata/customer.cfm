<style type="text/css">
	.display-none{
		display: none;
	}

	.ws-date{
	    width: 400px !important;
	}
	.select2-container{
        width:100%;
    }
    .ColVis{
    	float: left !important;
    }
    div.dataTables_filter label {
	    font-weight: 400;
	    float: left !important;
	}
</style>
<section id="widget-grid" class="" ng-app="customer.List" ng-controller="BindAngularDirectiveCtrl as showCase">
	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Customer</h2>
				</header>
				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body" >
						<div class="row">
							<div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-body">
											<legend class="fcollapsible" id="titleID">Create</legend>
											<div class="fcontent">
												<form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
													<input type="hidden" value="0" id='id_Customer'>
													<div class="form-group" style="display:none;">
				                                        <label class="col-md-3 control-label text-left">Code</label>
				                                        <div class="col-md-9">
				                                            <input class="form-control" placeholder="" type="text" name="code" id="code" ng-model="showCase.user.code">
				                                        </div>
				                                    </div>
													 <div class="form-group" ng-class="{'has-error':userForm.description.$invalid && !userForm.description.$pristine}">
				                                        <label class="col-md-3 control-label text-left"><b>Name</b></label>
				                                        <div class="col-md-9">
				                                            <input class="form-control" placeholder="" type="text" name="description" id="description" ng-model="showCase.user.description" required>
			                                                <p ng-show="userForm.description.$error.required && !userForm.description.$pristine" class="help-block">Name is required</p>
			                                                <p ng-show="userForm.description.$error.pattern  && !userForm.description.$pristine" class="help-block">Can not enter special char</p>
				                                        </div>
				                                    </div>

													<div class="form-group display-none">
														<label class="control-label col-sm-3 text-left"><strong>Zone</strong></label>
												    	<div class="col-md-9">
												    		<select ui-select2 id="zone" name='zone' ng-model="showCase.user.zone" ng-change="showCase.getAgent()">
																<option value="">Choose</option>
																<option ng-repeat="zone in showCase.zones" value="{{zone.ID}}">{{zone.DES}}</option>
															</select>
											    		</div>
													</div>

													<div class="form-group display-none">
														<label class="control-label col-md-3 text-left"><strong>Agent</strong></label>
														<div class="col-md-9">
															<select ui-select2 id="agent" name="agent" ng-model="showCase.user.agent" >
																<option value="">Choose</option>
																<option ng-repeat="agent in showCase.agents" value="{{agent.ID}}">{{agent.DES}}</option>
															</select>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error':userForm.language.$invalid && !userForm.language.$pristine}">
														<label class="control-label col-md-3 text-left"><b>Language</b></label>
														<div class="col-md-9">
															<select ui-select2 id="language" name="language" ng-model="showCase.user.language" required>
																<option value="">Choose</option>
																<option ng-repeat="lang in showCase.languages" value="{{lang.id_language}}">{{lang.lg_name}}</option>
															</select>
															<p ng-show="userForm.language.$invalid && !userForm.language.$pristine" class="help-block">Please choose language</p>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error':userForm.type.$invalid && !userForm.type.$pristine}">
														<label class="control-label col-md-3 text-left"><b>Type</b></label>
														<div class="col-md-9">
															<select ui-select2 id="type" name="type" ng-model="showCase.user.toc" required>
																<option value="">Choose</option>
																<option ng-repeat="toc in showCase.tocs" value="{{toc.id_type_Customer}}">{{toc.tc_description}}</option>
															</select>
															<p ng-show="userForm.language.$invalid && !userForm.language.$pristine" class="help-block">Please choose language</p>
														</div>
													</div>
													<div class="form-group">
														<label class="col-md-3 control-label text-left"><b>Contact</b></label>
														<div class="col-md-6">
															<input class="form-control" readonly placeholder="" type="text" name="contact" id="contact" ng-model="showCase.user.contact" required>
														</div>
														<div class="col-md-3 text-right">
		                                                    <button id="createContact" type="button" class="btn bg-color-blueDark txt-color-white" data-toggle="modal" data-target="#myModalContact">Add Contact</button>
		                                                    <button id="editContact" type="button" class="btn  bg-color-blueDark txt-color-white" ng-click="showCase.editRowContact()">Edit Contact</button>
		                                                </div>
													</div>
													<div class="form-group text-right">
														<div class="col-md-12">
															<button class="btn bg-color-blueDark txt-color-white" id="btnAddRow" ng-click="showCase.addRow()" ng-disabled="userForm.$invalid">
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
									<div class="btn col-md-2 col-md-offset-10 bg-color-blueDark txt-color-white" id="btnAddNew" ng-click="showCase.showAddNew()">
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
	<div id="myModalContact" class="modal fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" tabindex="-1">
		<supplier-Contact></supplier-Contact>
    </div>
</section>
<cfoutput>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/dataTables.select.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/customer.list.js?v=#application.version#"></script>
<script src="/includes/js/views/formcontact.list.js?v=#application.version#"></script>
</cfoutput>