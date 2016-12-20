<section id="widget-grid" class="" ng-app="box.list" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
	<!-- row -->
	<div class="row">
		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Box</h2>
				</header>
				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body">
						<div class="row">
							<div class="col-md-6">
								<div class="fcontent">
									<form class="form-horizontal">
										<div class="form-group">
											<label class="col-md-3 control-label tex-left"><b>Box</b></label>
											<div class="col-md-9">
												<input class="form-control" placeholder="" type="text" name="" id="textName">
											</div>
										</div>
										<div class="form-group">
											<label class="col-md-3 control-label tex-left"><b>Type Box</b></label>
											<div class="col-md-9">
												<select class="form-control" id="typeBox">
													<option>40*40*60</option>
													<option>20*40*60</option>
													<option>10*40*60</option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-md-3 control-label tex-left"><b>Weight</b></label>
											<div class="col-md-9">
												<input class="form-control" placeholder="" type="text" name="" id="weight">
											</div>
										</div>
										<div class="form-group text-center">
											<div  class="btn bg-color-blueDark txt-color-white" id="addProjectStatus">
												<i class="fa fa-save"></i>
												&nbsp;Add/Update
											</div>
											<div class="btn btn-default" id="">
												<i class="fa fa-refresh"></i>
												&nbsp;Refresh
											</div>
										</div>
									</form>
								</div>		
							</div>
							<div class="col-md-6">
								<fieldset>
									<div class="fcontent">
										<table id="datatable_fixed_column" class="table table-striped table-bordered" width="100%" >
									        <thead>
												<tr>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Box" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Type Box" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Weight" />
													</th>
													<th></th>									
												</tr>
									            <tr>
													<th>BOX</th>
													<th>TYPE BOX</th>
													<th>WEIGHT</th>
													<th style="width: 10%"></th>
									            </tr>
									        </thead>
											<tbody>
												<tr>
													<td>BX-1</td>
													<td>40*40*60</td>
													<td>12.60</td>
													<td>
														<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>BX-2</td>
													<td>40*40*60</td>
													<td>14.10</td>
													<td>
														<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>BX-3</td>
													<td>20*40*60</td>
													<td>6.90</td>
													<td>
														<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>					
											</tbody>
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
</section>

<cfoutput>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/dataTables.select.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/angular-datatables.columnfilter.min.js"></script>
<script src="/includes/js/views/box.list.js?v=#application.version#"></script>
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
// 	            $('#typeBox option:selected').text(),
// 	            $('#weight').val(),
// 	            '<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span><span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>'
// 	        ] ).draw( false );

// 	     $('#textName').val('');
//     })

//     $("#datatable_fixed_column").on( 'click', '.btnDelete', function () {
//         otable.row( $(this).parents('tr') )
// 		        .remove()
// 		        .draw();
//     } );
// })
</script>