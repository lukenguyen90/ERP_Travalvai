<section id="widget-grid" class="" ng-app="freight.list" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
	<!-- row -->
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Freight</h2>
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
													<div class="form-group" ng-class="{'has-error':userForm.fr_description.$invalid && !userForm.fr_description.$pristine}">
														<label class="col-md-3 control-label tex-left"><b>Freight</b></label>
														<div class="col-md-9">
															<input type="hidden" id="id_freight" value="0">
															<input class="form-control" placeholder="" type="text" name="fr_description" id="fr_description" ng-model="showCase.user.fr_description" required>
															<p ng-show="userForm.fr_description.$error.required && !userForm.fr_description.$pristine" class="help-block">Freight is required </p>
														</div>
													</div>		
													<div class="form-group text-center">
														<button class="btn bg-color-blueDark txt-color-white" id="btnAddRow" ng-disabled="userForm.$invalid" ng-click="showCase.addRow()">
															<i class="fa fa-save"  ></i>
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
<script src="/includes/js/views/freight.list.js?v=#application.version#"></script>
</cfoutput>

<script type="text/javascript">

// $(document).ready(function() {
// 	var responsiveHelper_datatable_fixed_column = undefined;

// 	var breakpointDefinition = {
// 		tablet : 1024,
// 		phone : 480
// 	};

	
// 	/* COLUMN FILTER  */
//     var otable = $('#datatable_fixed_column').DataTable({
// 		"sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6 hidden-xs'f><'col-sm-6 col-xs-12 hidden-xs'C>r>"+
// 				"t"+
// 				"<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
// 		"autoWidth" : true,
// 		"preDrawCallback" : function() {
// 			// Initialize the responsive datatables helper once.
// 			if (!responsiveHelper_datatable_fixed_column) {
// 				responsiveHelper_datatable_fixed_column = new ResponsiveDatatablesHelper($('#datatable_fixed_column'), breakpointDefinition);
// 			}
// 		},
// 		"rowCallback" : function(nRow) {
// 			responsiveHelper_datatable_fixed_column.createExpandIcon(nRow);
// 		},
// 		"drawCallback" : function(oSettings) {
// 			responsiveHelper_datatable_fixed_column.respond();
// 		}		
	
//     });
    	   
//     // Apply the filter
//     $("#datatable_fixed_column thead th input[type=text]").on( 'keyup change', function () {
    	
//         otable
//             .column( $(this).parent().index()+':visible' )
//             .search( this.value )
//             .draw();
            
//     } );

//     $('#addProjectStatus').on('click', function () {
//     	otable.row.add( [
// 	            $('#textName').val(),
// 	            '<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span><span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>'
// 	        ] ).draw( false );

// 	     $('#textName').val('');
//     })

//     $("#datatable_fixed_column").on( 'click', '.btnDelete', function () {
// 	    var result = confirm('Are you sure you want to delete this item?');
//     	if(result)
//     	{
// 			 otable.row( $(this).parents('tr') )
// 		        .remove()
// 		        .draw();
//     	}
       
//     } );
// })
</script>