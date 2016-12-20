<cfoutput>
	<style type="text/css">
		.select2-container{
			width: 100%;
		}
		.modal-dialog{
			width: 630px;
		}
		.action{
			padding-left: 0px;
			padding-right: 0px;
			font-size: 12px;
		}
		.input_check{
			margin-right: 3px !important;
		}
	</style>
	
 	<section id="widget-grid" class="" ng-app="project.list" ng-controller="BindAngularDirectiveCtrl as showCase">
		<div class="row">
			<article class="col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-check"></i> </span>
						<h2> Project Information </h2>
					</header>
					<div>
						<div class="widget-body">
							<div class="widget-body-toolbar">
								<div class="row">
									<div class="col-sm-4">
										<div id="thShowHideColumnid" style="float:left"></div>
										<div class="input-group">
											<div class="input-group-btn">
												<button class="btn btn-default" type="button">
													<i class="fa fa-search"></i>
												</button>
											</div>
											<input class="form-control" type="text" id="searchbox">
										</div>
									</div>
									<div class="col-sm-8 text-align-right">
										<div class="btn-group">
											<a class="btn bg-color-blueDark txt-color-white" id="btnAddNew" ng-click="showCase.showAddNew()">Create</a>
										</div>
									</div>
									<div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
		                                <div class="modal-dialog">
		                                    <div class="modal-content">
		                                        <div class="modal-body">
													<legend class="fcollapsible" id="titleID" style="text-align:left;">Create</legend>
													<div class="fcontent">
														<form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
															<div class="row">
																<div class="col-md-6">
																	<input type='hidden' name="id_Project" id="id_Project" value="0">
																	<div class="form-group">
								                                        <label class="control-label col-sm-4 text-left"><strong>Project</strong></label>
								                                        <div class="col-sm-8">
								                                            <input class="form-control" placeholder="" type="text" name="display" id="display" ng-model="showCase.user.display" ng-pattern="showCase.regex"  required>
								                                        </div>
								                                    </div>
																</div>
																<div class="col-md-6">
														    		<div class="form-group">
																    	<label class="control-label col-sm-4 text-left"><strong>Date</strong></label>
																    	<div class="col-sm-8" ng-class="{'has-error':userForm.date.$invalid && !userForm.date.$pristine}">
																    		<input class="form-control" placeholder="" type="text" name="date" id="date" ng-model="showCase.user.date">
							                                                <p ng-show="userForm.date.$error.required && !userForm.date.$pristine" class="help-block">Date is required</p>
							                                                <p ng-show="userForm.date.$error.pattern  && !userForm.date.$pristine" class="help-block">Can not enter special char</p>
																    	</div>
																  	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">
																	<div class="form-group" ng-class="{'has-error':userForm.customer.$invalid && !userForm.customer.$pristine}">
								                                        <label class="control-label col-sm-4 text-left"><strong>Customer</strong></label>
								                                        <div class="col-sm-8">
								                                        	<select ui-select2  id="customer" name="customer" ng-model="showCase.user.customerID" required>
																				<option value="">Choose</option>
																				<option ng-repeat="cus in showCase.customers" value="{{cus.ID}}">{{cus.ID}} - {{cus.NAME}}</option>
																			</select>
																			<p ng-show="userForm.customer.$invalid && !userForm.customer.$pristine" class="help-block">Please choose customer</p>
								                                        </div>
								                                    </div>
																</div>
																<div class="col-md-6">
																	<div class="form-group">
																    	<label class="control-label col-sm-4 text-left"><strong>Status</strong></label>
																    	<div class="col-sm-8" ng-class="{'has-error':userForm.status.$invalid && !userForm.status.$pristine}">
																    		<select ui-select2 id="status"  name="status" ng-model="showCase.user.statusID" required>
																				<option value="">Choose</option>
																				<option ng-repeat="sta in showCase.status" value="{{sta.id_pj_Status}}">{{sta.pj_stat_desc}}</option>
																			</select>
																			<p ng-show="userForm.status.$invalid && !userForm.status.$pristine" class="help-block">Please choose status</p>
																    	</div>
																  	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12">
																  	<div class="form-group" ng-class="{'has-error':userForm.description.$invalid && !userForm.description.$pristine}">
								                                        <label class="control-label col-sm-2 text-left"><strong>Description</strong></label>
								                                        <div class="col-sm-10">
								                                        	<textarea name="" id="" class="form-control" placeholder="" name="description" id="description" ng-model="showCase.user.description" ></textarea>
								                                        </div>
								                                    </div>
								                                </div>
								                            </div>
															<!--- <div class="row"  style="background-color:white;">
																<label class="col-md-2 control-label  text-left"><strong>Actions</strong></label>
																<div class="col-md-10" style="font-size:12px; margin-left: -15px">
																	<div class="col-md-4">
																		<div class="form-group">
																			<div class="col-md-12">
																				<div class="row">
																					<label class="col-md-12 control-label text-left">
																						<input class="input_check" type="checkbox" ng-model="showCase.user.groupWaitingFD_VN" ng-true-value="'YES'" ng-false-value="'NO'"> Waiting for design - VN
																					</label>
																				</div>
																				<div class="row">
																					<label class="col-md-12 control-label text-left">
																						<input class="input_check" type="checkbox" ng-model="showCase.user.groupWaitingFD_local" ng-true-value="'YES'" ng-false-value="'NO'"> Waiting for design - Local
																					</label>
																				</div>
																				<div class="row">
																					<label class="col-md-12 control-label text-left">
																						<input class="input_check" type="checkbox" ng-model="showCase.user.groupUrgent" ng-true-value="'YES'" ng-false-value="'NO'">Urgent
																					</label>
																				</div>
																				<div class="row">
																					<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.groupVUrgent" ng-true-value="'YES'" ng-false-value="'NO'"> Very Urgent</label>
																				</div>
																			</div>
																		</div>
																	</div>
																	<div class="col-md-4">
																		<div class="form-group">
																			<div class="col-md-12">
																				<div class="row">
																					<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.groupDesignProcess" ng-true-value="'YES'" ng-false-value="'NO'"> Designing in Process</label>
																				</div>
																				<div class="row">
																					<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.groupWaitingFC" ng-true-value="'YES'" ng-false-value="'NO'"> Waiting for Comments</label>
																				</div>
																				<div class="row">
																					<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.groupSentTCom" ng-true-value="'YES'" ng-false-value="'NO'"> Sent to Commercial</label>
																				</div>
																				<div class="row">
																					<label class="col-md-12 control-label text-left">
																						<input class="input_check" type="checkbox" ng-model="showCase.user.groupSentTCus" ng-true-value="'YES'" ng-false-value="'NO'">Sent to Customer
																					</label>								
																				</div>
																			</div>
																		</div>
																	</div>
																	<div class="col-md-4">
																		<div class="row">
																			<label class="col-md-12 control-label text-left"><input class="input_check" type="checkbox" ng-model="showCase.user.pj_act_9" ng-true-value="'YES'" ng-false-value="'NO'">Action 9</label>
																		</div>
																		<div class="row">
																			<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.pj_act_10" ng-true-value="'YES'" ng-false-value="'NO'"> Action 10</label>
																		</div>
																	</div>
																</div>
															</div> --->
															<div class="row">
																<div class="col-md-12 text-right">
																	<button class="btn bg-color-blueDark txt-color-white" id="save_order" ng-disabled="userForm.$invalid" ng-click="showCase.addRow()">
																		<i class="fa fa-save"></i>
																		&nbsp;Save
																	</button>
																</div>
															</div>
														</form>
													</div>
												</div>
											</div>
										</div>
									</div>
							</div>
							<div class="table-responsive">
								<table id="datatable_fixed_column" class="table table-striped table-bordered" width="100%">
							        <thead>	
										<tr>
						                    <th>PROJECT</th>
											<th>DESCRIPTION</th>
											<th>CUSTOMER</th>
											<th>AGENT</th>
											<th>ZONE</th>
											<th>DATE</th>
											<th>STATUS</th>
											<th>DETAIL</th>
											<th>ACTIONS</th>
							            </tr>
							            <tr>
											<th class="hasinput" style="width:5%;">
												<input type="text" class="form-control"/>
											</th>
											<th class="hasinput" style="width:15%;">
												<input type="text" class="form-control"/>
											</th>
											<th class="hasinput" style="width:8%;">
												<input type="text" class="form-control"/>
											</th>
											<th class="hasinput" style="width:11%;">
												<input type="text" class="form-control"/>
											</th>
											<th class="hasinput" style="width:11%;">
												<input type="text" class="form-control"/>
											</th>
											<th class="hasinput" style="width:10%;">
												<input type="text" class="form-control inputDate"/>
											</th>
											<th class="hasinput"  style="width:5%;">
												<input type="text" class="form-control"/>
											</th>
											<th class="hasinput"  style="width:5%;">
											</th>
											<th class="hasinput"  style="width:5%;">
											</th>
										</tr>
							        </thead>
			        				<tbody>
										<cfloop array="#prc.projects#" index="pj">
											<tr>
												<input type='hidden' name="id_Project" id="id_Project" value="#pj.id_project#">
												<td>PJ-#pj.id_display#</td>
												<td>#pj.pj_description#</td>
												<td >#pj.id_customer# - #pj.cs_name#</td>
												<td>#pj.agent#</td>
												<td>#pj.zone#</td>
												<td>
													#LSDATEFORMAT(pj.date,'dd/mm/yyyy')#
												</td>
												<td>#pj.name_status#</td>
												<td>
													<a href="/index.cfm/project.edit?id=#pj.id_project#">
														<span class="txt-color-green btngotoplfdetail" title="Go to Project edit">
															<i class="ace-icon bigger-130 fa fa-sign-out"></i>
														</span>
													</a>
												</td>
												<td>
													<span class="txt-color-red btndelete" title="Delete project" ng-click="showCase.deleteProject(#pj.id_project#)">
		                    							<i class="ace-icon bigger-130 fa fa-trash-o"></i>
		                    						</span>
												</td>
											</tr>
										</cfloop>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</article>
		</div>
	</section>

	<script type="text/javascript">
		$(document).ready(function() {
			$("##date").datepicker();
			var responsiveHelper_datatable_fixed_column = undefined;

			var breakpointDefinition = {
				tablet : 1024,
				phone : 480
			};

			$("##datatable_fixed_column tbody tr").click(function(){
				$(".highlight").removeClass("highlight");
				$(this).addClass("highlight");
			});

			var arrActionSelect = [];
			//check if datatable has been saved to localStorage
			var datatableKey = 'DataTables_datatable_fixed_column_/index.cfm/project.index';
			var perform = performance.navigation.type;
			if(perform === 0 || perform === 1) {
				localStorage.removeItem(datatableKey);
			}
			var cachedTable = JSON.parse(localStorage.getItem(datatableKey));
			if(cachedTable !== null) {
				
				$("##datatable_fixed_column thead tr:first-child").children('th').each(function(index) {
					if(!$(this).is(':empty')) {
						var searchValue = cachedTable.columns[index].search.search;
						searchValue = searchValue.trim();
						if(typeof(searchValue) !== 'undefined' && searchValue.length > 0) {
							if ($(this).hasClass('filteraction')) {
								var arrSearchValue = searchValue.split(' ');
								var arrLength = arrSearchValue.length;
								for(var i = 0; i< arrLength; i++){
									var search = arrSearchValue[i];									
									if(search.length > 0)
										appendSearchObject($("##labelAction-" + search));
								}
							}
							else {
								$(this).children().val(searchValue);
							}
						}
					}
				});
				
			}	
				
			/* COLUMN FILTER  */
		    var otable = $('##datatable_fixed_column').DataTable({
				// "dom": '<"top"<"clear">>rt<"bottom"iflp<"clear">>',
				// "bFilter": false,
				"autoWidth" : true,
				"bLengthChange": false,
				"info": false,
				"pageLength": 50,
				'stateSave': true,
				preDrawCallback : function() {
					// Initialize the responsive datatables helper once.
					if (!responsiveHelper_datatable_fixed_column) {
						responsiveHelper_datatable_fixed_column = new ResponsiveDatatablesHelper($('##datatable_fixed_column'), breakpointDefinition);
					}
				},
				rowCallback : function(nRow) {
					responsiveHelper_datatable_fixed_column.createExpandIcon(nRow);
				},
				drawCallback : function(oSettings) {
					responsiveHelper_datatable_fixed_column.respond();
				},
				fnStateLoad: function (oSettings){
					return cachedTable;
				}

		    });

		    $("##searchbox").keyup(function() {
			   otable.search( this.value).draw();
			});

		    var colvis = new $.fn.dataTable.ColVis( otable, {
		        buttonText: 'Select columns'
		    } );

		    $('##thShowHideColumnid').append($( colvis.button() ));

		    // Apply the filter
		    $("##datatable_fixed_column thead th input[type=text]").on( 'keyup change', function () {
		        otable
		            .column( $(this).parent().index()+':visible' )
		            .search( this.value )
		            .draw();
		    });

		    $('##datatable_fixed_column tbody').on('dblclick', 'tr', function () {
		        var data = otable.row(this).data();
		        // console.log($(this).children('##id_Project').val());
		        var url = '/index.cfm/project.edit?id=';
			   	// var inputURL = data[0];
			   	var inputURL = $(this).children('##id_Project').val();
			   	window.location.href = url + inputURL;
		    });

		    

			$('.label-action').on('click', function () {
				$('.filter-action').toggleClass( "showfilter" );
			})

			$(document).on("click",'.btn-label-close', function (event) {
				var labelSelect = $(this).parent(".actionSelected");
				$('##labelAction-'+labelSelect.attr('value')).css('display','block');
				var item = labelSelect.prop('outerHTML')+ ';;' +labelSelect.attr('value');
				var indexItem = jQuery.inArray( item, arrActionSelect );
				arrActionSelect.splice(indexItem, 1);
				$(this).parent(".actionSelected").remove();
		    	var totalWidth = 0;
		    	$('.actionSelected').each(function (item) {
		    		totalWidth += $(this).width()+3;
		    	})
		    	$('##label-action').width(totalWidth+25);
				searchAction();
			})

			$('label.actionLabel').on('click', function(e) {
			    // if(!currencyAction.find('input[type="checkbox"]').is(':checked')){
			    	$(this).css('display','none');
					
			    	appendSearchObject($(this));
			    // }
			   	searchAction();
			})

			function appendSearchObject(objectSearch) {
				
				var textAppend = '<label class="actionSelected '+ objectSearch.attr('class').split(' ')[1] +'" value="'+objectSearch.attr('value')+'">'+objectSearch.attr('value')+'<span class="btn-label-close"><i class="glyphicon glyphicon-remove"></i></span></label>';
				$('##label-action').html('');
				var itemArray = textAppend + ';;' +objectSearch.attr('value');
				arrActionSelect.push(itemArray);
				textAppend = '';
				for (var i = 0; i <= arrActionSelect.length - 1; i++) {
					textAppend += arrActionSelect[i].split(';;')[0];
				};
				$('##label-action').append(textAppend);
				var totalWidth = 0;
				$('.actionSelected').each(function (item) {
					totalWidth += $(this).width()+3;
				})
				$('##label-action').width(totalWidth+25);
			}

			function searchAction () {
				$('.filter-action').removeClass( "showfilter" );
				var textSearch = "";
				for (var i = 0; i <= arrActionSelect.length - 1; i++) {
		    		textSearch = textSearch + ' '+ arrActionSelect[i].split(';;')[1];
		    	};
				otable.column( '7:visible' ).search(textSearch).draw();
			}

			// .on('change', 'input', function(e) {
			// 	// alert('change');
			//     e.stopPropagation();
			// }).on('click', 'input', function(e) {
			// 	// alert('click');
			//     e.stopPropagation();
			// });

			// $("label.actionLabel input[type=checkbox]").change(function() {
			// 	// console.log($(this).is(':checked'));
			// 	if($(this).is(':checked')){
			// 		// alert("ghjgdfhdfghd");
			//         $(this).attr('checked', false);
			// 	}
			// 	if(!$(this).is(':checked')){
			// 		$(this).parent().css('display','none');
			//     	$('##label-action').append($(this).parent().attr('value'));
			//     	$(this).attr('checked', true);
			// 	}
			// });
		});
	</script>

	<script src="/includes/js/angular-datatables.min.js"></script>
	<script src="/includes/js/angular-datatables.columnfilter.min.js"></script>
	<script src="/includes/js/views/project.list.js"></script>

 </cfoutput>


<style type="text/css">

	
	
	.dataTables_filter{
		display: none;
	}

	.select2-container-multi .select2-choices .select2-search-field input{
		font-size: 13px;
	}

	.label-action{
		display: block;
		background: #fff;
		font-size: 13px;
		color: #ccc;
		border: 1px solid #ccc;
		height: 32px;
	    padding: 6px 12px;
	    margin-bottom: 0px;
	    min-width: 175px;
	}

	.modal-dialog{
		width: 800px;
	}

	.filter-action{
		position: relative;
		width: 100%;
		display: none;
	}

	.filter-action.showfilter{
		display: block;
		z-index: 100;
	}

	.content-filter-action{
		position: absolute;
		width: 100%;
		background: #fff;
	}

	.filter-action .actionLabel{
	  	color: #fff;
	  	padding-left: 20px;
	  	line-height: 23px;
	  	font-weight: bold;
	  	display: block;
	  	margin-top: 3px;
	}

	table.dataTable thead>tr>th input[type="checkbox"]{
		display: inline-block;
		width: auto !important;
		margin-left: -15px;
	}

	.filter-action .checkbox-inline+.checkbox-inline{
		margin-left: 0px;
	}


	.btn-label-close{
		position: relative;
	    display: inline-block;
	    padding: 2px 4px;
	    background: rgba(0,0,0,.15);
	    margin-left: 4px;
	}

	.btn-label-close:hover{
		cursor: pointer;
	}

	label.actionSelected {
	    padding-left: 4px;
	    margin-bottom: 0px;
	    font-size: 10px;
	    font-weight: bold;
	    color: #fff;
	    margin-right: 2px;
	}
</style>