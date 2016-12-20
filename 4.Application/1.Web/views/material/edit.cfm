<section id="widget-grid" class="">
	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Material</h2>

				</header>

				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body">
						<div class="row">
							<div class="col-md-12">
								<div class="form-horizontal">
									<fieldset>
										<legend class="fcollapsible">Material Information</legend>
										<div class="fcontent">
											<div class="row">
												<div class="col-md-6">
													<div class="form-group">
														<label class="col-md-3 control-label text-left">Code</label>
														<label class="col-md-3 control-label"></label>
														<label class="col-md-3 control-label text-left">Unit</label>
														<label class="col-md-3 control-label"></label>
													</div>
													<div class="form-group">
														<label class="col-md-3 control-label text-left">Group</label>
														<label class="col-md-3 control-label"></label>
														<label class="col-md-3 control-label text-left">Price</label>
														<label class="col-md-3 control-label "></label>
													</div>
													<div class="form-group">
														<label class="col-md-3 control-label text-left">Description</label>
														<label class="col-md-3 control-label"></label>
														<label class="col-md-3 control-label text-left">Date</label>
														<label class="col-md-3 control-label"></label>
													</div>
												</div> 
											</div>
										</div>
									</fieldset>
								</div>
							</div>
						</div>
						<form class="form-horizontal">
							<div class="row">
								<div class="col-md-6">
									<legend class="fcollapsible">Materials Detail</legend>
									<div class="fcontent">
										<form class="form-horizontal">
											<div class="form-group">
												<label class="col-md-3 control-label text-left">VAR. Code</label>
												<div class="col-md-9">
													<input class="form-control" placeholder="" type="text" name="">
												</div>
											</div>
											<div class="form-group">
												<label class="col-md-3 control-label text-left">Description</label>
												<div class="col-md-9">
													<input class="form-control" placeholder="" type="text" name="">
												</div>
											</div>
											<div class="form-group">
												<label class="col-md-3 control-label text-left">Price</label>
												<div class="col-md-9">
													<input class="form-control" placeholder="" type="text" name="">
												</div>
											</div>
											<div class="form-group">
												<label class="col-md-3 control-label text-left">Date</label>
												<div class="col-md-9">
													<input class="form-control inputDate" placeholder="" type="text" name="">
												</div>
											</div>
											<div class="form-group text-center">
												<button class="btn bg-color-blueDark txt-color-white" id="complete_report">
													<i class="fa fa-save"></i>
													&nbsp;Add
												</button>
												<button class="btn btn-default" id="">
													<i class="fa fa-refresh"></i>
													&nbsp;Refresh
												</button>
											</div>
										</form>
									</div>		
								</div>
								<div class="col-md-6">
									<fieldset>
										<legend class="fcollapsible">Materials List</legend>

										<div class="fcontent">
											
											<table id="datatable_fixed_column" class="table table-striped table-bordered" width="100%">
						
										        <thead>
													<tr>
														<th class="hasinput">
															<input type="text" class="form-control" placeholder="Filter VAR. Code" />
														</th>
														<th class="hasinput">
															<input type="text" class="form-control" placeholder="Filter Description " />
														</th>
														<th class="hasinput">
															<input type="text" class="form-control" placeholder="Filter Price " />
														</th>
														<th class="hasinput">
															<input type="text" class="form-control inputDate" placeholder="Filter Date" />
														</th>
														<th></th>									
													</tr>
										            <tr>
									                    <th>Code</th>
									                    <th>Description</th>
									                    <th>Price</th>
														<th>Date</th>
														<th style="width: 8%"></th>
										            </tr>
										        </thead>
												<tbody>
																				
												</tbody>
											</table>											
										</div>
									</fieldset>
								</div>
							</div>
							<div class="row form-actions">
								<div class="col-md-12 text-center">
									<button class="btn bg-color-blueDark txt-color-white" id="save_order">
										<i class="fa fa-save"></i>
										&nbsp;Save
									</button>
									<button class="btn btn-default">
										<i class="fa fa-sign-out"></i>
										&nbsp;Quit
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</article>
	</div>
</section>

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
})
</script>