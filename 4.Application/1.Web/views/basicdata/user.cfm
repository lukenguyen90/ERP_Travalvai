<section id="widget-grid" class="" ng-app="user" ng-controller="BindAngularDirectiveCtrl as showCase">
	<!-- row -->
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>User</h2>
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
											<button type="button" class="close" id="close" data-dismiss="modal" style="display:none;float:right;">&times;</button>
											<legend class="fcollapsible" id="titleID">User Detail</legend>
											<div class="fcontent">
												<form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
			                                        <input type='hidden' name="id_User" id="id_User" value="0">
													<div class="form-group" ng-class="{'has-error':userForm.name.$invalid && !userForm.name.$pristine}">
				                                        <label class="col-md-3 control-label text-left"><b>Name</b></label>
				                                        <div class="col-md-5">
				                                            <input class="form-control" type="text" name="name" id="name" ng-model="showCase.user.name" required>
			                                                <p ng-show="userForm.name.$error.required && !userForm.name.$pristine" class="help-block">Name is required</p>
				                                        </div>
				                                    </div>
													<div class="form-group" ng-class="{'has-error' : userForm.password.$invalid && !userForm.password.$pristine}">
														<label class="col-md-3 control-label text-left"><b>Password</b></label>
														<div class="col-md-5">
															<input class="form-control" placeholder="" type="password" name="password" id="password" ng-model="showCase.user.password">
															<p ng-show="userForm.password.$error.required && !userForm.password.$pristine" class="help-block">Password is required</p>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error' : userForm.factory.$invalid && !userForm.factory.$pristine}">
														<label class="control-label col-md-3 text-left"><b>Factory</b></label>
														<div class="col-md-5">
															<select ui-select2 id="factory" name="factory" ng-model="showCase.user.factory" data-placeholder="Choose">
															    <option ng-repeat="lang in showCase.factories" value="{{lang.ID}}">{{lang.CODE}}</option>
															</select>
															<p ng-show="userForm.factory.$invalid && !userForm.factory.$pristine" class="help-block">Please choose factory</p>
														</div>
													</div>
													<div class="form-group display-none" ng-class="{'has-error' : userForm.zone.$invalid && !userForm.zone.$pristine}">
														<label class="control-label col-md-3 text-left"><b>Zone</b></label>
														<div class="col-md-5">
															<select ui-select2 id="zone" name="zone" ng-model="showCase.user.zone" data-placeholder="Choose">
															    <option ng-repeat="lang in showCase.zones" value="{{lang.ID}}">{{lang.CODE}}</option>
															</select>
															<!--- <select class="form-control" id="zone" name="zone" ng-model="showCase.user.zone" ng-options="lang.ID as lang.CODE for lang in showCase.zones">
																<option value="">Choose</option>
															</select> --->
															<p ng-show="userForm.zone.$invalid && !userForm.zone.$pristine" class="help-block">Please choose zone</p>
														</div>
													</div>
													<div class="form-group display-none" ng-class="{'has-error' : userForm.agent.$invalid && !userForm.agent.$pristine}">
														<label class="control-label col-md-3 text-left"><b>Agent</b></label>
														<div class="col-md-5">
															<select ui-select2 id="agent" name="agent" ng-model="showCase.user.agent" data-placeholder="Choose">
																<option value="">Choose</option>
															    <option ng-repeat="lang in showCase.agents" value="{{lang.ID}}">{{lang.CODE}}</option>
															</select>
															<!--- <select class="form-control" id="agent" name="agent" ng-model="showCase.user.agent" ng-options="lang.ID as lang.CODE for lang in showCase.agents">
																<option value="">Choose</option>
															</select> --->
															<p ng-show="userForm.agent.$invalid && !userForm.agent.$pristine" class="help-block">Please choose agent</p>
														</div>
													</div>
													<div class="form-group display-none" ng-class="{'has-error' : userForm.customer.$invalid && !userForm.customer.$pristine}">
														<label class="control-label col-md-3 text-left"><b>Customer</b></label>
														<div class="col-md-5">
															<select ui-select2 id="customer" name="customer" ng-model="showCase.user.customer" data-placeholder="Choose">
															    <option ng-repeat="lang in showCase.customers" value="{{lang.ID}}">{{lang.NAME}}</option>
															</select>
															<!--- <select class="form-control" id="customer" name="customer" ng-model="showCase.user.customer" ng-options="lang.ID as lang.NAME for lang in showCase.customers">
																<option value="">Choose</option>
															</select> --->
															<p ng-show="userForm.customer.$invalid && !userForm.customer.$pristine" class="help-block">Please choose customer</p>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error' : userForm.position.$invalid && !userForm.position.$pristine}">
														<label class="control-label col-md-3 text-left"><b>Position</b></label>
														<div class="col-md-5">
															<input class="form-control" placeholder="" type="text" name="position" id="position" ng-model="showCase.user.position">
															<p ng-show="userForm.position.$error.required && !userForm.position.$pristine" class="help-block">Position is required</p>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error' : userForm.access_level.$invalid && !userForm.access_level.$pristine}">
														<label class="control-label col-md-3 text-left"><b>Role</b></label>
														<div class="col-md-5">
															<select ui-select2 id="access_level" name="access_level" ng-model="showCase.user.access_level" data-placeholder="Choose">
															    <option ng-repeat="lang in showCase.access_levels" value="{{lang.ID}}">{{lang.NAME}}</option>
															</select>
															<p ng-show="userForm.access_level.$invalid && !userForm.access_level.$pristine" class="help-block">Please choose access level</p>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error' : userForm.language.$invalid && !userForm.language.$pristine}">
														<label class="control-label col-md-3 text-left"><b>Language</b></label>
														<div class="col-md-5">
															<select ui-select2 id="language" name="language" ng-model="showCase.user.language" data-placeholder="Choose">
															    <option ng-repeat="lang in showCase.languages" value="{{lang.id_language}}">{{lang.lg_name}}</option>
															</select>
															<p ng-show="userForm.language.$invalid && !userForm.language.$pristine" class="help-block">Please choose language</p>
														</div>
													</div>
													<div class="form-group" ng-class="{'has-error':userForm.contact.$invalid && !userForm.contact.$pristine}">
														<label class="col-md-3 control-label text-left"><b>Contact</b></label>
														<div class="col-md-5">
															<input class="form-control" readonly placeholder="" type="text" name="contact" id="contact" ng-model="showCase.user.contact" required>
															 <p ng-show="userForm.contact.$error.required && !userForm.contact.$pristine" class="help-block">Contact is required</p>
														</div>
														<div class="col-md-3">
		                                                    <button id="createContact" type="button" class="btn btn-block bg-color-blueDark txt-color-white" data-toggle="modal" data-target="#myModalContact">Add Contact</button>
		                                                    <button id="editContact" type="button" class="btn btn-block bg-color-blueDark txt-color-white" ng-click="showCase.editRowContact()">Edit Contact</button>
		                                                </div>
													</div>
													<div class="form-group text-center">
														<div class="col-md-3"></div>
														<div class="col-md-7">
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
	<div id="myModalContact" class="modal fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" tabindex="-1">
		<supplier-Contact></supplier-Contact>
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
<script src="/includes/js/views/user.list.js?v=#application.version#"></script>
<script src="/includes/js/views/formcontact.list.js?v=#application.version#"></script>
</cfoutput>
<!--
<script type="text/javascript">
$(document).ready(function() {
	var responsiveHelper_datatable_fixed_column = undefined;

	var breakpointDefinition = {
		tablet : 1024,
		phone : 480
	};


	/* COLUMN FILTER  */
    var otable = $('#datatable_fixed_column').DataTable({
		"sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6 hidden-xs'f><'col-sm-6 col-xs-12 hidden-xs'C>r>"+
				"t"+
				"<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
		"autoWidth" : true,
		"preDrawCallback" : function() {
			// Initialize the responsive datatables helper once.
			if (!responsiveHelper_datatable_fixed_column) {
				responsiveHelper_datatable_fixed_column = new ResponsiveDatatablesHelper($('#datatable_fixed_column'), breakpointDefinition);
			}
		},
		"rowCallback" : function(nRow) {
			responsiveHelper_datatable_fixed_column.createExpandIcon(nRow);
		},
		"drawCallback" : function(oSettings) {
			responsiveHelper_datatable_fixed_column.respond();
		}

    });

    // Apply the filter
    $("#datatable_fixed_column thead th input[type=text]").on( 'keyup change', function () {
        otable
            .column( $(this).parent().index()+':visible' )
            .search( this.value )
            .draw();
    } );

    $("#datatable_fixed_column").on( 'click', '.btnDelete', function () {
	    var result = confirm('Are you sure you want to delete this item?');
	    if(result)
	    {
	    	otable.row( $(this).parents('tr') )
		        .remove()
		        .draw();
	    }
    } );

    $('#btnAddRow').on( 'click', function () {

		otable.row.add( [
            $('#code').val(),
            $('#factory option:selected').text(),
            $('#zone option:selected').text(),
            $('#agent option:selected').text(),
            $('#customer option:selected').text(),
            $('#position option:selected').text(),
            $('#access-level option:selected').text(),
            $('#password').val(),
            $('#contact option:selected').text(),
            '<span class="txt-color-green btnedit" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span><span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>'
        ] ).draw( false );

        refreshUser();
    });

    function refreshUser (argument) {
    	$('#code').val('');
        $('#factory').prop('selectedIndex',0);
        $('#zone').prop('selectedIndex',0);
        $('#agent').prop('selectedIndex',0);
        $('#customer').prop('selectedIndex',0);
        $('#position').prop('selectedIndex',0);
        $('#access-level').prop('selectedIndex',0);
    	$('#password').val('');
        $('#contact').prop('selectedIndex',0);
    }

    $('#btnRefresh').on( 'click', function () {
        refreshUser();
    });

    // $('.editCurrency').editable({
    // 	mode: 'inline',
    //     value: 1,
    //     source: [
    //           {value: 1, text: 'VN'},
    //           {value: 2, text: 'EUR'},
    //           {value: 3, text: 'USD'}
    //        ]
    // });

    // $('.editLanguage').editable({
    // 	mode: 'inline',
    //     value: 1,
    //     source: [
    //           {value: 1, text: 'Vietnamese'},
    //           {value: 2, text: 'English'}
    //        ]
    // });
})
</script> -->
