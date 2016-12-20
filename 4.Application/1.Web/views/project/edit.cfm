<!--- #structKeyExists(URL,"id")?'':randId# --->
<cfoutput>
	<!--- <cfset randId = "">
	<cfif !structKeyExists(URL,"id")>
		<cfset randId ="pj"&"-"&RandRange(1,99999, "SHA1PRNG")>
	</cfif> --->
	<style>
		.select2-container{
			width:100%;
		}
		.modal-content {
		  background-color: ##333333;
		}
		.modal-body {
		  background-color: ##fff;
		}
		.action{
			padding-left: 0px;
			padding-right: 0px;
			font-size: 12px;
		}
		.input_check{
			margin-right: 3px !important;
		}
		textarea.form-control {
   			height: 34px;
   		}
	</style>
	<section id="widget-grid" class="" ng-app="project" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
		<div class="row">
			<article class="col-sm-12 col-md-12 col-lg-12">

				<!-- Widget ID (each widget will need unique ID)-->
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-arrow-left" style="cursor:pointer !important;" ng-click="showCase.backState()" title="Back to Project List"></i> </span>
						<h2> Project Information </h2>
					</header>
					<div>
						<div class="jarviswidget-editbox">
						</div>
						<div class="widget-body">
							<div class="form-horizontal" >
								<div class="row">
									<div class="col-md-12 col-sm-12 col-xs-12">
										<fieldset>
											<legend class="fcollapsible">General</legend>
											<div class="fcontent">
												<form class="form-horizontal col-md-12" name="userForm" ng-submit="showCase.submitForm()" novalidate>
													<input type='hidden' name="id_Project" id="id_Project" value="0">
													<div class="row">
														<div class="col-md-3">
															<div class="form-group">
						                                        <label class="control-label col-md-4 text-left" style="padding-left: 0px !important;"><strong>Project</strong></label>
						                                        <div class="col-md-8">
						                                            <input class="form-control" readonly placeholder="" type="text" name="display" id="display" ng-model="showCase.user.display" ng-pattern="showCase.regex"  required>
						                                        </div>
						                                    </div>
														</div>
														<div class="col-md-3">
															<div class="form-group" ng-class="{'has-error':userForm.customer.$invalid && !userForm.customer.$pristine}">
						                                        <label class="control-label col-md-3 text-left" style="padding-left: 0px !important;"><strong>Customer</strong></label>
						                                        <div class="col-md-9">
						                                        	<select ui-select2 id="customer" name="customer" ng-model="showCase.user.customerID"  required>
																		<option value="">Choose Customer</option>
																		<option ng-repeat="cus in showCase.customers" value="{{cus.ID}}">{{cus.ID}} - {{cus.NAME}}</option>
																	</select>
																	<p ng-show="userForm.customer.$invalid && !userForm.customer.$pristine" class="help-block">Please choose customer</p>
						                                        </div>
						                                    </div>
														</div>
														<div class="col-md-3">
															<div class="form-group">
														    	<label class="control-label col-md-3 text-left" ><strong>Zone</strong></label>
														    	<div class="col-md-9">
														    		<input class="form-control" readonly placeholder="" type="text" name="zone" id="zone" ng-model="showCase.user.zone ">
													    		</div>
												    		</div>
														</div>
														<div class="col-md-3">
															<div class="form-group">
														    	<label class="control-label col-md-3 text-left" style="padding-left: 0px !important;"><strong>Date</strong></label>
														    	<div class="col-md-9" ng-class="{'has-error':userForm.date.$invalid && !userForm.date.$pristine}">
														    		<input class="form-control" placeholder="" type="text" name="date" id="date" ng-model="showCase.user.date">
					                                                <p ng-show="userForm.date.$error.required && !userForm.date.$pristine" class="help-block">Date is required</p>
					                                                <p ng-show="userForm.date.$error.pattern  && !userForm.date.$pristine" class="help-block">Can not enter special char</p>
														    	</div>
														  	</div>
														</div>														
													</div>
													<div class="row">
														<div class="col-md-6">
															<div class="form-group" ng-class="{'has-error':userForm.description.$invalid && !userForm.description.$pristine}">
						                                        <label class="control-label col-md-2 text-left" style="padding-left: 0px !important;"><strong>Description</strong></label>
						                                        <div class="col-md-10">
						                                        	<textarea name="pro_des" id="pro_des" class="form-control" rows="1" placeholder="Project Description" name="description" id="description" ng-model="showCase.user.description" required></textarea>
					                                                <p ng-show="userForm.description.$error.required && !userForm.description.$pristine" class="help-block">Description is required</p>
						                                        </div>
						                                    </div>
														</div>
														<div class="col-md-3">
															<div class="form-group">
														    	<label class="control-label col-md-3 text-left"><strong>Agent</strong></label>
														    	<div class="col-md-9">
														    		<input class="form-control" placeholder="" type="agent" name="agent" id="agent" ng-model="showCase.user.agent" readonly>
														    	</div>
														    </div>
														</div>

														<div class="col-md-3">
															<div class="form-group">
														    	<label class="control-label col-md-3 text-left" style="padding-left: 0px !important;"><strong>Status</strong></label>
														    	<div class="col-md-9" ng-class="{'has-error':userForm.status.$invalid && !userForm.status.$pristine}">
														    		<select ui-select2 id="status" name="status" ng-model="showCase.user.statusID" required>
																		<option value="">Choose</option>
																		<option ng-repeat="sta in showCase.status" value="{{sta.id_pj_Status}}">{{sta.pj_stat_desc}}</option>
																	</select>
																	<p ng-show="userForm.status.$invalid && !userForm.status.$pristine" class="help-block">Please choose status</p>
														    	</div>
														  	</div>
														</div>
														
													</div>
													<div class="row action well" style="background-color:white;">
														<div class="col-md-1 row">
															<label class="control-label  text-left" style="font-size: 13px"><strong>Action :</label>
														</div>
														<div class="col-md-3">
															<div class="row">
																<div class="col-md-12" style="margin-left: 11px;">
																	<label class="col-md-12 control-label text-left">
																		<input class="input_check" type="checkbox" ng-model="showCase.user.groupWaitingFD_VN" ng-true-value="'YES'" ng-false-value="'NO'"> Waiting for design - VN
																	</label>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12" style="margin-left: 11px;">
																	<label class="col-md-12 control-label text-left">
																		<input class="input_check" type="checkbox" ng-model="showCase.user.groupWaitingFD_local" ng-true-value="'YES'" ng-false-value="'NO'"> Waiting for design - Local
																	</label>
																</div>
															</div>
														</div>
														<div class="col-md-4">
															<div class="row">
																<div class="col-md-5">
																	<label class="col-md-12 control-label text-left">
																		<input class="input_check" type="checkbox" ng-model="showCase.user.groupUrgent" ng-true-value="'YES'" ng-false-value="'NO'">Urgent
																	</label>
																</div>
																<div class="col-md-7">
																	<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.groupDesignProcess" ng-true-value="'YES'" ng-false-value="'NO'"> Designing in Process</label>
																</div>
															</div>
															<div class="row">
																<div class="col-md-5">
																	<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.groupVUrgent" ng-true-value="'YES'" ng-false-value="'NO'"> Very Urgent</label>
																</div>
																<div class="col-md-7">
																	<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.groupWaitingFC" ng-true-value="'YES'" ng-false-value="'NO'"> Waiting for Comments</label>
																</div>
															</div>
														</div>	

														<div class="col-md-4">
															<div class="row">
																<div class="col-md-7">
																	<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.groupSentTCom" ng-true-value="'YES'" ng-false-value="'NO'"> Sent to Commercial</label>
																</div>
																<div class="col-md-5">
																	<label class="col-md-12 control-label text-left"><input class="input_check" type="checkbox" ng-model="showCase.user.pj_act_9" ng-true-value="'YES'" ng-false-value="'NO'">Action 9</label>
																</div>
															</div>
															<div class="row">
																<div class="col-md-7">
																	<label class="col-md-12 control-label text-left">
																		<input class="input_check" type="checkbox" ng-model="showCase.user.groupSentTCus" ng-true-value="'YES'" ng-false-value="'NO'">Sent to Customer
																	</label>
																</div>
																<div class="col-md-5">
																	<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.pj_act_10" ng-true-value="'YES'" ng-false-value="'NO'"> Action 10</label>
																</div>
															</div>
														</div>
													</div>
													<div class="form-group margin-top-10">
														<div class="col-md-12 text-right" style="margin-top:5px;">
															<button class="btn bg-color-blueDark txt-color-white" id="save_order" ng-disabled="userForm.$invalid" ng-click="showCase.addRow()">
																<i class="fa fa-save"></i>
																&nbsp;Save
															</button>
														</div>
													</div>
												</form>
											</div>
										</fieldset>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12 col-xs-12">
		                                <ul id="myTab1" class="nav nav-tabs">
		                                    <li class="active">
		                                        <a href="##s1" data-toggle="tab">Product List</a>
		                                    </li>
		                                    <li>
		                                        <a href="##s2" data-toggle="tab">Comment</a>
		                                    </li>
		                                </ul>
		                            </div>
								</div>
								<div id="myTabContent1" class="tab-content padding-10">
									<div class="tab-pane fade in active" id="s1">
										<div class="row" style="padding:0px 15px;">
											<div class="table-responsive">
												<table class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.pddtOptions" dt-columns="showCase.pddtColumns" dt-instance="showCase.pddtInstance">
			                                    </table>
											</div>
										</div>
									</div>
									<div class="tab-pane fade in" id="s2">
										<div class="row">
											<div class="col-md-12 col-sm-12 col-xs-12">
												<div class="modal fade" id="addComment" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
					                                <div class="modal-dialog">
					                                    <div class="modal-content">
					                                        <div class="modal-body">
					                                        	<button type="button" class="close" id="close" data-dismiss="modal" style="float:right;">&times;</button>
					                                        	<fieldset>
																	<form id="commentForm" name="commentForm" class="form-horizontal col-md-12" ng-submit="showCase.submitForm()" novalidate>
																		<input type='hidden' name="id_Comment" id="id_Comment" value="0">
																		<div class="form-group">
																			<div class="col-md-12">
																				<div ckeditor="options" ng-model="showCase.comment.commentContent" ready="onReady()"></div>
																			</div>
																		</div>
																		<div class="form-group">
																			<div class="col-md-1">
																				<button class="btn bg-color-blueDark txt-color-white" id="btnAddComment" ng-disabled="commentForm.$invalid" ng-click="showCase.addRowComment()" style="">
																					Add Comment
																				</button>
																			</div>
																			<div style="display:none;" class="col-md-4 col-md-offset-7">
																				<input type="date" class="form-control" name="todayComment" id="todayComment" ng-model="showCase.comment.todaycomment" readonly required/>
																			</div>
																		</div>
																	</form>
					                                        	</fieldset>
															</div>
														</div>
													</div>
												</div>
												<div class="modal fade" id="detailComment" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
					                                <div class="modal-dialog">
					                                    <div class="modal-content">
						                                	<div class="modal-header">
						                                		<div class="row" style="padding:0px 20px;">
															        <button type="button" class="close" data-dismiss="modal">&times;</button>
															        <h4 class="modal-title" style="color:white;"><span data-ng-bind="showCase.comment.DATE"></span> by <span data-ng-bind="showCase.comment.USER"></span></h4>
						                                		</div>
														    </div>
					                                        <div class="modal-body">
																<div class="row" style="max-height:60vh;overflow-y:scroll;">
																	<div id="contentComment"></div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div class="form-group margin-top-10">
														<div class="col-md-12 text-right" style="margin-top:5px;">
															<button class="btn bg-color-blueDark txt-color-white" id="save_order" ng-disabled="userForm.$invalid" ng-click="showCase.addComment()">
																<i class="fa fa-plus-square"></i>
																&nbsp;Add Comment
															</button>
														</div>
													</div>
												<div id="table_comment" class="row" style="margin:10px 0px;">
													<table class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance">
			                                        </table>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- end widget content -->
					</div>
					<!-- end widget div -->
				</div>
				<!-- end widget -->

			</article>

		</div>
	</section>

	<script type="text/javascript">
		$(document).ready(function() {
			$("##date").datepicker({dateFormat: 'dd-mm-yy'});
			var queryString = window.location.search;
			if(queryString){
				$('##id_Project').val(queryString.slice(4));
			}

			var responsiveHelper_datatable_fixed_column_1 = undefined;
			var responsiveHelper_datatable_fixed_column_2 = undefined;
			var breakpointDefinition = {
				tablet : 1024,
				phone : 480
			};

			/* COLUMN FILTER  */
		    var otable_1 = $('##datatable_fixed_column_1').DataTable({
				"sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6 hidden-xs'f><'col-sm-6 col-xs-12 hidden-xs'C>r>"+
						"t"+
						"<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
				"autoWidth" : true,
				"preDrawCallback" : function() {
					// Initialize the responsive datatables helper once.
					if (!responsiveHelper_datatable_fixed_column_1) {
						responsiveHelper_datatable_fixed_column_1 = new ResponsiveDatatablesHelper($('##datatable_fixed_column_1'), breakpointDefinition);
					}
				},
				"rowCallback" : function(nRow) {
					responsiveHelper_datatable_fixed_column_1.createExpandIcon(nRow);
				},
				"drawCallback" : function(oSettings) {
					responsiveHelper_datatable_fixed_column_1.respond();
				}

		    });

		    var otable_2 = $('##datatable_fixed_column_2').DataTable({
				"sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6 hidden-xs'f><'col-sm-6 col-xs-12 hidden-xs'C>r>"+
						"t"+
						"<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
				"autoWidth" : true,
				"preDrawCallback" : function() {
					// Initialize the responsive datatables helper once.
					if (!responsiveHelper_datatable_fixed_column_2) {
						responsiveHelper_datatable_fixed_column_2 = new ResponsiveDatatablesHelper($('##datatable_fixed_column_2'), breakpointDefinition);
					}
				},
				"rowCallback" : function(nRow) {
					responsiveHelper_datatable_fixed_column_2.createExpandIcon(nRow);
				},
				"drawCallback" : function(oSettings) {
					responsiveHelper_datatable_fixed_column_2.respond();
				}

		    });

		    // Apply the filter
		    $("##datatable_fixed_column_1 thead th input[type=text]").on( 'keyup change', function () {

		    	if ($(this).val().length < 3)	return false;
		        otable_1
		            .column( $(this).parent().index()+':visible' )
		            .search( this.value )
		            .draw();

		    } );

		    $("##datatable_fixed_column_2 thead th input[type=text]").on( 'keyup change', function () {

		    	if ($(this).val().length < 3)	return false;
		        otable_2
		            .column( $(this).parent().index()+':visible' )
		            .search( this.value )
		            .draw();

		    } );

		    $('##addProjectProduct').on( 'click', function () {
		        otable_1.row.add( [
		            $('##productName').val(),
		            $('##productGarmentCode').val(),
		            $('##productVersion').val(),
		            $('##productCostCode').val(),
		            $('##productCostCodeVers').val(),
		            $('##productStatus').val(),
		            $('##productDescription').val(),
		            '<img class="img-responsive" src="/includes/img/ao/images.jpg">',
		            '<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span><span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>'
		        ] ).draw( false );

		        resetProjectProductForm();
		    } );

			function resetProjectProductForm () {
				$('##productName').val('');
	            $('##productGarmentCode').val('');
	            $('##productVersion').val('');
	            $('##productCostCode').val('');
	            $('##productCostCodeVers').val('');
	            $('##productStatus').val('');
	            $('##productDescription').val('');
			}

		    // $('##btnAddComment').on( 'click', function () {
		    //     otable_2.row.add( [
		    //         $('##commentDate').val(),
		    //         $('##commentUser').val(),
		    //         $('##commentContent').val().replace(/\r\n|\r|\n/g,"<br />"),
		    //         '<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span><span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>'
		    //     ] ).draw( false );

		    //     $('##commentDate').val('');
		    //     $('##commentUser').val('');
		    //     $('##commentContent').val('');
		    // } );

		    $("##datatable_fixed_column_2").on( 'click', '.btnDelete', function () {
		        otable_2.row( $(this).parents('tr') )
				        .remove()
				        .draw();
		    } );
		});
	</script>



<script src="/includes/js/jquery.dataTables.min.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.min.js?v=#application.version#"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.columnfilter.min.js?v=#application.version#"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js?v=#application.version#"></script>
<script src="/includes/js/views/project.js?v=#application.version#"></script>

<script src="/includes/js/plugin/ckeditor/ckeditor.js?v=#application.version#"></script>
<script src="/includes/js/plugin/ckeditor/angular-ckeditor.min.js"></script>
</cfoutput>
<style type="text/css">
.dt-toolbar{
	padding: 6px 0px 1px;
}
#table_comment{
	background-color: white;
}

.well{
	padding: 5px;
}
</style>